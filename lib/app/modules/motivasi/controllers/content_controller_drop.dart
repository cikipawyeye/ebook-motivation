import 'dart:convert';
import 'dart:typed_data';
import 'package:ebookapp/app/data/models/content_model.dart';
import 'package:ebookapp/app/data/models/cursor_pagination_model.dart';
import 'package:ebookapp/core/constants/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ContentControllerDrop extends GetxController {
  var contents = <Content>[].obs;
  var imageBytesList = <Rx<Uint8List?>>[].obs;
  var isLoading = false.obs;
  var nextCursor = RxnString();
  var subcategoryId = 0.obs; // Tambahkan properti ini

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

    try {
      final token = await getToken();
      if (token == null) {
        Get.snackbar('Error', 'User not authenticated!');
        return;
      }

      debugPrint('🔄 Fetching motivasi data for subcategoryId: $subcategoryId');
      debugPrint(
          '🔄 $baseUrl/api/v1/contents?subcategory_id=$subcategoryId&cursor=${nextCursor.value ?? ''}&limit=3');

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
        Get.snackbar('Error', 'Failed to load motivasi');
        return;
      }

      final jsonResponse = json.decode(response.body);

      if (jsonResponse['data'] == null || jsonResponse['data'].isEmpty) {
        Get.snackbar('No Data', 'Data motivasi tidak ditemukan.');
        return;
      }

      // Reset lists if this is the first fetch
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

      debugPrint('✅ Motivasi data fetched successfully');
      debugPrint('Total items fetched: ${contents.length}');
      debugPrint('Next cursor: ${nextCursor.value}');
    } catch (e) {
      Get.snackbar('Error', 'An error occurred while fetching motivasi.');
      debugPrint("Error fetching motivasi: $e");
    } finally {
      isLoading.value = false;
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
      debugPrint("Invalid image URL: $imageUrl");
      imageRx.value = null;
      return;
    }

    final token = await getToken();
    if (token == null) {
      Get.snackbar('Error', 'User not authenticated!');
      return;
    }

    try {
      debugPrint("Downloading image: $imageUrl");

      final response = await http.get(
        Uri.parse(imageUrl),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200 && response.bodyBytes.isNotEmpty) {
        imageRx.value = response.bodyBytes;
        debugPrint("✅ Image downloaded successfully: $imageUrl");
      } else {
        imageRx.value = null;
        debugPrint(
            "❌ Failed to download image, Status Code: ${response.statusCode}");
      }
    } catch (e) {
      imageRx.value = null;
      debugPrint("⚠️ Error saat mengunduh gambar: $e");
    }
  }
}
