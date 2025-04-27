import 'dart:convert';
import 'dart:typed_data';
import 'package:ebookapp/app/data/models/motivasi_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ebookapp/core/constants/constant.dart';

class MotivasiController extends GetxController {
  var motivasiList = <Motivasi>[].obs;
  var motivasiDetail = Rx<Motivasi?>(null);
  var subcategories = <Subcategory>[].obs;
  var subcategoryIds = <int>[].obs;
  var subcategoryIdsList = <int>[].obs;
  var imageBytesList = <Rx<Uint8List?>>[].obs;
  var idLength = <int, int>{}.obs;
  var currentPage = 1.obs;
  var totalPages = 1.obs;
  var isLoading = true.obs;
  var isDetailLoading = true.obs;
  var subcategoryTotalIds = <int, int>{}.obs;
  var searchQuery = ''.obs;

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  // Helper to make an authenticated API request
  Future<http.Response?> makeAuthenticatedRequest(String url) async {
    final token = await getToken();
    if (token == null) {
      Get.snackbar('Error', 'User not authenticated!');
      return null;
    }

    try {
      return await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );
    } catch (e) {
      debugPrint("Error: $e");
      Get.snackbar('Error', 'Failed to fetch data: $e');
      return null;
    }
  }

  // Fetch subcategories
  Future<void> fetchSubcategories() async {
    debugPrint('🔄 Fetching subcategories...');
    final response =
        await makeAuthenticatedRequest('$baseUrl/api/v1/0/subcategories');
    if (response == null || response.statusCode != 200) {
      Get.snackbar('Error', 'Failed to fetch subcategories');
      return;
    }

    final jsonResponse = json.decode(response.body);
    if (jsonResponse['data'] != null) {
      subcategories.value = (jsonResponse['data'] as List)
          .map((item) => Subcategory.fromJson(item))
          .toList();

      debugPrint('✅ Subcategories fetched successfully');

      // Update subcategoryIds dengan ID subkategori yang diambil
      subcategoryIds.clear(); // Clear any existing data first
      subcategoryIds.addAll(subcategories.map((subcategory) => subcategory.id));

      // Simpan ID subkategori ke dalam subcategoryIdsList
      subcategoryIdsList.clear(); // Clear previous IDs
      subcategoryIdsList.addAll(subcategoryIds); // Menyimpan ID subkategori

      // Log subcategoryIds untuk memastikan mereka diperbarui dengan benar
      debugPrint('Subcategory IDs: ${subcategoryIds.join(', ')}');
      debugPrint('Subcategory IDs List: ${subcategoryIdsList.join(', ')}');

      await _fetchMotivasiForSubcategories();
    }
  }

  // Fetch motivasi data for all subcategories
  Future<void> _fetchMotivasiForSubcategories() async {
    for (var subcategory in subcategories) {
      await fetchMotivasiData(subcategoryId: subcategory.id);
    }
  }

  // Fetch motivasi data based on subcategoryId
  Future<void> fetchMotivasiData({required int subcategoryId}) async {
    if (isLoading.value) return;
    isLoading.value = true;
    update();

    final response = await makeAuthenticatedRequest(
        '$baseUrl/api/v1/contents?subcategory_id=$subcategoryId&page=${currentPage.value}');
    if (response == null || response.statusCode != 200) {
      Get.snackbar('Error', 'Failed to fetch motivasi data');
      return;
    }

    final jsonResponse = json.decode(response.body);
    if (jsonResponse['data'] != null && jsonResponse['data'].isNotEmpty) {
      var subcategoryMotivasi = (jsonResponse['data'] as List)
          .map((item) => Motivasi.fromJson(item))
          .toList();

      // Debugging: Pastikan data motivasi terambil dengan benar
      debugPrint('Fetched motivasi: ${subcategoryMotivasi.length} items');

      // Update motivasi list dan subcategoryTotalIds
      _updateMotivasiData(jsonResponse, subcategoryId, subcategoryMotivasi);
    } else {
      debugPrint('No motivasi data found for subcategoryId: $subcategoryId');
    }
  }

  // Update motivasi list and pagination
  void _updateMotivasiData(Map<String, dynamic> jsonResponse, int subcategoryId,
      List<Motivasi> subcategoryMotivasi) {
    int totalId = subcategoryMotivasi.length;
    debugPrint(
        'Updating subcategoryTotalIds for subcategoryId: $subcategoryId with totalId: $totalId');

    // Update idLength untuk menyimpan jumlah motivasi per subkategori
    idLength[subcategoryId] =
        totalId; // Menyimpan jumlah motivasi untuk subkategori
    idLength.refresh(); // Menyegarkan nilai Map

    subcategoryTotalIds[subcategoryId] =
        totalId; // Update jumlah motivasi dalam subcategoryTotalIds
    subcategoryTotalIds.refresh(); // Menyegarkan nilai Map

    motivasiList.assignAll(subcategoryMotivasi);

    debugPrint(
        'Updated motivasi list: ${motivasiList.map((motivasi) => motivasi.subcategory.id).toList()}');
  }

  // Fetch motivation detail
  Future<void> fetchMotivationDetail(int id) async {
    isDetailLoading(true);
    try {
      final token = await getToken();
      if (token == null) {
        Get.snackbar('Error', 'User not authenticated!');
        return;
      }

      var url = Uri.parse('$baseUrl/api/v1/contents/$id');
      final response = await http.get(url, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      });

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data['data'] != null) {
          motivasiDetail.value = Motivasi.fromJson(data['data']);
        } else {
          throw Exception('Data is null');
        }
      } else {
        throw Exception('Gagal mengambil data detail motivasi');
      }
    } catch (e) {
      debugPrint("Error: $e");
      Get.snackbar('Oops! Sepertinya ada sedikit kendala',
          'Jangan khawatir—bukan salah Anda! Sesuatu tidak berjalan sebagaimana mestinya, tapi kami sedang mengatasinya.');
    } finally {
      isDetailLoading(false);
    }
  }

  // Helper function for fetching total ID per subcategory
  int getTotalIdForSubcategory(int subcategoryId) {
    return subcategoryTotalIds[subcategoryId] ?? 0;
  }

  @override
  void onInit() {
    super.onInit();
    fetchSubcategories();
  }
}
