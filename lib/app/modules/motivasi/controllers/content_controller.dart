import 'dart:convert';
import 'dart:typed_data';
import 'package:ebookapp/app/data/models/content_model.dart';
import 'package:ebookapp/app/data/models/cursor_pagination_model.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image/image.dart' as img;
import '/../../../core/constants/constant.dart';

class ContentController extends GetxController {
  var contents = <Content>[].obs;
  var imageBytesList = <Rx<Uint8List?>>[].obs;
  var isLoading = false.obs;
  var nextCursor = RxnString();

  @override
  void onInit() {
    debugPrint("ContentController initialized");
    super.onInit();
  }

  @override
  void onClose() {
    debugPrint("ContentController closed");
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
        Get.snackbar('Error', 'User not authenticated!');
        return;
      }

      _logDebug('🔄 Fetching motivasi data for subcategoryId: $subcategoryId');
      _logDebug(
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

      await fetchImages(jsonResponse['data']);

      if (jsonResponse['meta'] != null) {
        nextCursor.value =
            CursorPagination.fromJson(jsonResponse['meta']).nextCursor;
      } else {
        nextCursor.value = null;
      }

      _logDebug('✅ Motivasi data fetched successfully');
    } catch (e) {
      Get.snackbar('Error', 'An error occurred while fetching motivasi.');
      _logDebug("Error fetching motivasi: $e");
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

      // Tambahkan konten baru ke dalam daftar yang sudah ada
      contents.add(content);
      imageBytesList.add(imageRx);

      downloadTasks.add(downloadAndConvertImage(imageUrl, imageRx));
    }

    await Future.wait(downloadTasks);
  }

  Future<void> downloadAndConvertImage(
      String imageUrl, Rx<Uint8List?> imageRx) async {
    if (imageUrl.isEmpty) {
      _logDebug("Invalid image URL: $imageUrl");
      imageRx.value = null;
      return;
    }

    final token = await getToken();
    if (token == null) {
      Get.snackbar('Error', 'User not authenticated!');
      return;
    }

    try {
      _logDebug("Downloading image: $imageUrl");

      final response = await http.get(
        Uri.parse(imageUrl),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200 && response.bodyBytes.isNotEmpty) {
        // Validasi gambar sebelum menyimpan
        final validatedImage =
            await _validateAndProcessImage(response.bodyBytes);

        if (validatedImage != null) {
          imageRx.value = validatedImage;
          _logDebug("✅ Image downloaded and validated successfully: $imageUrl");
        } else {
          imageRx.value = null;
          _logDebug("❌ Image validation failed: $imageUrl");
        }
      } else {
        imageRx.value = null;
        _logDebug(
            "❌ Failed to download image, Status Code: ${response.statusCode}");
      }
    } catch (e) {
      imageRx.value = null;
      _logDebug("⚠️ Error saat mengunduh gambar: $e");
    }
  }

  // Fungsi validasi dan pemrosesan gambar
  Future<Uint8List?> _validateAndProcessImage(Uint8List imageBytes) async {
    try {
      // Validasi header gambar
      if (!_isValidImageHeader(imageBytes)) {
        _logDebug('Invalid image header');
        return null;
      }

      // Coba decode gambar
      final image = img.decodeImage(imageBytes);
      if (image == null) {
        _logDebug('Failed to decode image');
        return null;
      }

      // Validasi dimensi gambar
      if (image.width <= 0 || image.height <= 0) {
        _logDebug('Invalid image dimensions');
        return null;
      }

      // Optional: Resize gambar jika terlalu besar
      if (image.width > 800 || image.height > 800) {
        final resizedImage = img.copyResize(image, width: 800);
        return Uint8List.fromList(img.encodePng(resizedImage));
      }

      return imageBytes;
    } catch (e) {
      _logDebug('Image processing error: $e');
      return null;
    }
  }

  // Fungsi untuk memeriksa header gambar
  bool _isValidImageHeader(Uint8List imageBytes) {
    if (imageBytes.length < 4) return false;

    // Tanda header untuk JPEG
    bool isJpeg =
        imageBytes[0] == 0xFF && imageBytes[1] == 0xD8 && imageBytes[2] == 0xFF;

    // Tanda header untuk PNG
    bool isPng = imageBytes[0] == 0x89 &&
        imageBytes[1] == 0x50 &&
        imageBytes[2] == 0x4E &&
        imageBytes[3] == 0x47;

    // Tanda header untuk WebP
    bool isWebp = imageBytes[0] == 0x52 && // 'R'
        imageBytes[1] == 0x49 && // 'I'
        imageBytes[2] == 0x46 && // 'F'
        imageBytes[3] == 0x46 && // 'F'
        imageBytes[8] == 0x57 && // 'W'
        imageBytes[9] == 0x45 && // 'E'
        imageBytes[10] == 0x42 && // 'B'
        imageBytes[11] == 0x50; // 'P'

    return isJpeg || isPng || isWebp;
  }

  // Fungsi debug yang dapat dikontrol
  void _logDebug(String message) {
    if (kDebugMode) {
      debugPrint(message);
    }
  }
}
