import 'dart:convert';
import 'dart:typed_data';
import 'package:ebookapp/app/data/models/motivasi_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '/../../../core/constants/constant.dart';

class PengingatIdController extends GetxController {
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

  Future<http.Response?> makeAuthenticatedRequest(String url) async {
    final token = await getToken();
    if (token == null) {
      Get.snackbar('Kesalahan', 'Pengguna tidak terautentikasi!');
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
      Get.snackbar('Kesalahan', 'Gagal mengambil data: $e');
      return null;
    }
  }

  Future<void> fetchSubcategories() async {
    debugPrint('🔄 Mengambil subkategori...');
    final response = await makeAuthenticatedRequest(
        '${baseUrl}/api/v1/1/subcategories/');
    if (response == null || response.statusCode != 200) {
      Get.snackbar('Kesalahan', 'Gagal mengambil subkategori');
      return;
    }

    final jsonResponse = json.decode(response.body);
    if (jsonResponse['data'] != null) {
      subcategories.value = (jsonResponse['data'] as List)
          .map((item) => Subcategory.fromJson(item))
          .toList();

      debugPrint('✅ Subkategori berhasil diambil');

      subcategoryIds.clear();
      subcategoryIds.addAll(subcategories.map((subcategory) => subcategory.id));

      subcategoryIdsList.clear();
      subcategoryIdsList.addAll(subcategoryIds);

      debugPrint('ID Subkategori: ${subcategoryIds.join(', ')}');
      debugPrint('Daftar ID Subkategori: ${subcategoryIdsList.join(', ')}');

      await _fetchMotivasiForSubcategories();
    }
  }

  Future<void> _fetchMotivasiForSubcategories() async {
    for (var subcategory in subcategories) {
      await fetchMotivasiData(subcategoryId: subcategory.id);
    }
  }

  Future<void> fetchMotivasiData({required int subcategoryId}) async {
    if (isLoading.value) return;
    isLoading.value = true;
    update();

    final response = await makeAuthenticatedRequest(
        '${baseUrl}/api/v1/contents?subcategory_id=$subcategoryId&page=${currentPage.value}');
    if (response == null || response.statusCode != 200) {
      Get.snackbar('Kesalahan', 'Gagal mengambil data motivasi');
      return;
    }

    final jsonResponse = json.decode(response.body);
    if (jsonResponse['data'] != null && jsonResponse['data'].isNotEmpty) {
      var subcategoryMotivasi = (jsonResponse['data'] as List)
          .map((item) => Motivasi.fromJson(item))
          .toList();

      debugPrint('Motivasi diambil: ${subcategoryMotivasi.length} item');

      _updateMotivasiData(jsonResponse, subcategoryId, subcategoryMotivasi);
    } else {
      debugPrint(
          'Data motivasi tidak ditemukan untuk subcategoryId: $subcategoryId');
    }
  }

  void _updateMotivasiData(Map<String, dynamic> jsonResponse, int subcategoryId,
      List<Motivasi> subcategoryMotivasi) {
    int totalId = subcategoryMotivasi.length;
    debugPrint(
        'Memperbarui subcategoryTotalIds untuk subcategoryId: $subcategoryId dengan totalId: $totalId');

    idLength[subcategoryId] = totalId;
    idLength.refresh();

    subcategoryTotalIds[subcategoryId] = totalId;
    subcategoryTotalIds.refresh();

    motivasiList.assignAll(subcategoryMotivasi);

    debugPrint(
        'Daftar motivasi yang diperbarui: ${motivasiList.map((motivasi) => motivasi.subcategory.id).toList()}');
  }

  Future<void> _fetchImagesForMotivasi(
      List<Motivasi> subcategoryMotivasi) async {
    imageBytesList.clear();
    await Future.wait(subcategoryMotivasi.map((motivasi) async {
      Rx<Uint8List?> imageRx = Rx<Uint8List?>(null);
      String imageToDownload = motivasi.imageUrls.original.isNotEmpty
          ? motivasi.imageUrls.original
          : '';

      if (imageToDownload.isNotEmpty) {
        final imageResponse = await http.get(Uri.parse(imageToDownload));
        if (imageResponse.statusCode == 200) {
          imageRx.value = imageResponse.bodyBytes;
        }
      }
      imageBytesList.add(imageRx);
    }));
  }

  Future<void> fetchMotivationDetail(int id) async {
    isDetailLoading(true);
    try {
      final token = await getToken();
      if (token == null) {
        Get.snackbar('Kesalahan', 'Pengguna tidak terautentikasi!');
        return;
      }

      var url =
          Uri.parse('${baseUrl}/api/v1/contents/$id');
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
          throw Exception('Data null');
        }
      } else {
        throw Exception('Gagal mengambil data detail motivasi');
      }
    } catch (e) {
      Get.snackbar('Kesalahan', 'Gagal mengambil data detail: $e');
    } finally {
      isDetailLoading(false);
    }
  }

  int getTotalIdForSubcategory(int subcategoryId) {
    return subcategoryTotalIds[subcategoryId] ?? 0;
  }

  @override
  void onInit() {
    super.onInit();
    fetchSubcategories();
  }
}
