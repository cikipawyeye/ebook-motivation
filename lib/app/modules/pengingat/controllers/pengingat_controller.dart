import 'dart:convert';
import 'dart:typed_data';
import 'package:ebookapp/app/data/models/content_model.dart';
import 'package:ebookapp/app/data/models/cursor_pagination_model.dart';
import 'package:ebookapp/app/data/models/motivasi_model.dart';
import 'package:ebookapp/app/modules/pengingat/controllers/pengingat_category_controller.dart';
import 'package:ebookapp/app/routes/app_pages.dart';
import 'package:ebookapp/core/constants/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PengingatController extends GetxController {
  var contents = <Content>[].obs;
  var imageBytesList = <Rx<Uint8List?>>[].obs;
  var isLoading = false.obs;
  var nextCursor = RxnString();
  var subcategoryId = 0.obs;
  var subcategories = <Subcategory>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchSubcategoriesFromMotivasiController();
  }

  @override
  void onClose() {
    contents.clear();
    imageBytesList.clear();
    isLoading.value = false;
    nextCursor.value = null;
    super.onClose();
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<void> fetchContents({required int subcategoryId}) async {
    if (isLoading.value) return;
    isLoading.value = true;
    update();

    try {
      final token = await getToken();
      if (token == null) {
        Get.snackbar('Kesalahan', 'Pengguna tidak terautentikasi!');
        return;
      }

      final response = await http.get(
        Uri.parse(
            '$baseUrl/api/v1/contents?subcategory_id=$subcategoryId&cursor=${nextCursor.value ?? ''}&limit=3'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode != 200) {
        Get.snackbar('Kesalahan', 'Gagal memuat motivasi');
        return;
      }

      final jsonResponse = json.decode(response.body);

      if (jsonResponse['data'] == null || jsonResponse['data'].isEmpty) {
        Get.snackbar('Tidak Ada Data', 'Data motivasi tidak ditemukan.');
        return;
      }

      if (nextCursor.value == null) {
        contents.clear();
        imageBytesList.clear();
      }

      await fetchImages(jsonResponse['data']);

      if (jsonResponse['meta'] != null) {
        nextCursor.value =
            CursorPagination.fromJson(jsonResponse['meta']).nextCursor;
      } else {
        nextCursor.value = null;
      }

      debugPrint('✅ Data motivasi berhasil diambil');
      debugPrint('Total item yang diambil: ${contents.length}');
      debugPrint('Cursor berikutnya: ${nextCursor.value}');

      if (nextCursor.value == null) {
        final currentSubcategory = subcategories.firstWhere(
          (subcategory) => subcategory.id == subcategoryId,
        );
        _loadNextSubcategory(currentSubcategory);
      }
    } catch (e) {
      Get.snackbar('Kesalahan', 'Terjadi kesalahan saat mengambil motivasi.');
      debugPrint("Kesalahan saat mengambil motivasi: $e");
    } finally {
      isLoading.value = false;
      update();
    }
  }

  Future<void> fetchImages(List rawContentsData) async {
    List<Future<void>> downloadTasks = [];

    for (var element in rawContentsData) {
      Content content = Content.fromJson(element);
      Rx<Uint8List?> imageRx = Rx<Uint8List?>(null);
      String imageUrl = content.imageUrls.optimized.isNotEmpty
          ? content.imageUrls.optimized
          : content.imageUrls.original;

      contents.add(content);
      imageBytesList.add(imageRx);

      downloadTasks.add(downloadAndConvertImage(imageUrl, imageRx));
    }

    await Future.wait(downloadTasks);
  }

  Future<void> downloadAndConvertImage(
      String imageUrl, Rx<Uint8List?> imageRx) async {
    if (imageUrl.isEmpty) {
      debugPrint("URL gambar tidak valid: $imageUrl");
      imageRx.value = null;
      return;
    }

    final token = await getToken();
    if (token == null) {
      Get.snackbar('Kesalahan', 'Pengguna tidak terautentikasi!');
      return;
    }

    try {
      debugPrint("Mengunduh gambar: $imageUrl");

      final response = await http.get(
        Uri.parse(imageUrl),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200 && response.bodyBytes.isNotEmpty) {
        imageRx.value = response.bodyBytes;
        debugPrint("✅ Gambar berhasil diunduh: $imageUrl");
      } else {
        imageRx.value = null;
        debugPrint(
            "❌ Gagal mengunduh gambar, Status Kode: ${response.statusCode}");
      }
    } catch (e) {
      imageRx.value = null;
      debugPrint("⚠️ Kesalahan saat mengunduh gambar: $e");
    }
  }

  Subcategory? getNextSubcategory(Subcategory currentSubcategory) {
    if (subcategories.isEmpty) {
      debugPrint("Daftar subcategory kosong");
      return null;
    }

    final currentIndex = subcategories.indexWhere(
      (subcategory) => subcategory.id == currentSubcategory.id,
    );

    if (currentIndex == -1) {
      debugPrint("Subcategory saat ini tidak ditemukan dalam daftar");
      return null;
    }

    if (currentIndex >= subcategories.length - 1) {
      debugPrint("Tidak ada subcategory berikutnya");
      return null;
    }

    return subcategories[currentIndex + 1];
  }

  Future<void> fetchSubcategoriesFromMotivasiController() async {
    final motivasiController = Get.find<PengingatIdController>();
    subcategories.value = motivasiController.subcategories;
    debugPrint('✅ Subcategories berhasil diambil dari MotivasiController');
  }

  void _loadNextSubcategory(Subcategory currentSubcategory) {
    debugPrint(
        "Mencari subcategory berikutnya untuk subcategory ID: ${currentSubcategory.id}");
    final nextSubcategory = this.getNextSubcategory(currentSubcategory);

    if (nextSubcategory != null) {
      debugPrint(
          "Subcategory berikutnya ditemukan: ${nextSubcategory.id} - ${nextSubcategory.name}");
      debugPrint("Navigasi ke subcategory berikutnya...");
      Get.offNamed(Routes.motivationContents, arguments: nextSubcategory);
    } else {
      debugPrint("Tidak ada subcategory berikutnya");
      Get.snackbar('Info', 'Tidak ada subcategory berikutnya');
    }
  }
}
