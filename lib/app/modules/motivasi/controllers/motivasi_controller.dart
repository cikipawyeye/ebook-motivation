import 'dart:convert';
import 'dart:typed_data';
import 'package:ebookapp/app/data/models/motivasi_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MotivasiController extends GetxController {
  var motivasiList = <Motivasi>[].obs;
  var motivasiDetail = Rxn<Motivasi>();
  var imageBytesList = <Rx<Uint8List?>>[].obs;
  var isLoading = false.obs;

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<void> fetchMotivasiData({required int subcategoryId}) async {
    if (isLoading.value) return;
    isLoading.value = true;
    update();

    try {
      final token = await getToken();
      if (token == null) {
        Get.snackbar('Error', 'User not authenticated!');
        return;
      }

      final response = await http.get(
        Uri.parse(
            'https://ebook.dev.whatthefun.id/api/v1/contents?subcategory_id=$subcategoryId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      print("API Response Status: ${response.statusCode}");
      print("API Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse['data'] != null && jsonResponse['data'].isNotEmpty) {
          motivasiList.value = (jsonResponse['data'] as List)
              .map((item) => Motivasi.fromJson(item))
              .toList();

          print("Motivasi List: ${motivasiList.value}");

          imageBytesList.clear();

          await Future.wait(motivasiList.map((motivasi) async {
            Rx<Uint8List?> imageRx = Rx<Uint8List?>(null);
            String imageToDownload = motivasi.imageUrls.optimized.isNotEmpty
                ? motivasi.imageUrls.optimized
                : motivasi.imageUrls.original;

            if (imageToDownload.isNotEmpty) {
              await downloadAndConvertImage(imageToDownload, imageRx);
            }
            imageBytesList.add(imageRx);
          }));
        } else {
          Get.snackbar('No Data', 'Data motivasi tidak ditemukan.');
        }
      } else {
        Get.snackbar('Error', 'Failed to load motivasi');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred while ');
    } finally {
      isLoading.value = false;
      update();
    }
  }

  Future<void> downloadAndConvertImage(String imageUrl, Rx<Uint8List?> imageRx) async {
    if (imageUrl.isEmpty) {
      imageBytesList.clear();
      return;
    }

    try {
      final response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode == 200 && response.bodyBytes.isNotEmpty) {
        imageBytesList.clear();
        imageBytesList.add(Rx<Uint8List?>(response.bodyBytes));
      } else {
        imageBytesList.clear();
      }
    } catch (e) {
      imageBytesList.clear();
    }
  }
}
// class MotivasiController extends GetxController {
//   var motivasiList = <Motivasi>[].obs;
//   var motivasiDetail = Rxn<Motivasi>(); // Detail motivasi
//   var subcategories = <Subcategory>[].obs; // Data subkategori
//   var imageBytesList = <Rx<Uint8List?>>[].obs; // Menyimpan gambar
//   var currentPage = 1.obs;
//   var totalPages = 1.obs;
//   var isLoading = false.obs; // Pakai RxBool agar bisa di-update

//   // Fungsi untuk mendapatkan token
//   Future<String?> getToken() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString('token');
//   }

//   // Fetch subcategories
//   Future<void> fetchSubcategories() async {
//     try {
//       final token = await getToken();
//       if (token == null) {
//         Get.snackbar('Error', 'User not authenticated!');
//         return;
//       }

//       debugPrint('🔄 Fetching subcategories...');
//       final response = await http.get(
//         Uri.parse('https://ebook.dev.whatthefun.id/api/v1/0/subcategories'),
//         headers: {
//           'Authorization': 'Bearer $token',
//           'Content-Type': 'application/json',
//           'Accept': 'application/json',
//         },
//       );

//       if (response.statusCode == 200) {
//         final jsonResponse = json.decode(response.body);
//         if (jsonResponse['data'] != null) {
//           subcategories.value = (jsonResponse['data'] as List)
//               .map((item) => Subcategory.fromJson(item))
//               .toList();
//           debugPrint('✅ Subcategories fetched successfully');
//         }
//       } else {
//         Get.snackbar('Error', 'Failed to fetch subcategories');
//       }
//     } catch (e) {
//       Get.snackbar('Error', 'An error occurred while fetching subcategories.');
//       debugPrint("Error: $e");
//     }
//   }

//   // Fetch motivasi berdasarkan subcategoryId
//   Future<void> fetchMotivasiData({required int subcategoryId}) async {
//     if (isLoading.value) return;
//     isLoading.value = true;
//     update();

//     try {
//       final token = await getToken();
//       if (token == null) {
//         Get.snackbar('Error', 'User not authenticated!');
//         return;
//       }

//       debugPrint('🔄 Fetching motivasi data for subcategoryId: $subcategoryId');
//       final response = await http.get(
//         Uri.parse(
//             'https://ebook.dev.whatthefun.id/api/v1/contents?subcategory_id=$subcategoryId'),
//         headers: {
//           'Authorization': 'Bearer $token',
//           'Content-Type': 'application/json',
//           'Accept': 'application/json',
//         },
//       );

//       if (response.statusCode == 200) {
//         final jsonResponse = json.decode(response.body);
//         if (jsonResponse['data'] != null && jsonResponse['data'].isNotEmpty) {
//           motivasiList.value = (jsonResponse['data'] as List)
//               .map((item) => Motivasi.fromJson(item))
//               .toList();

//           debugPrint('✅ Motivasi data fetched successfully');

//           // Unduh semua gambar sekaligus
//           imageBytesList.clear();
//           await Future.wait(motivasiList.map((motivasi) async {
//             Rx<Uint8List?> imageRx = Rx<Uint8List?>(null);
//             String imageToDownload = motivasi.imageUrls.original.isNotEmpty
//                 ? motivasi.imageUrls.original
//                 : motivasi.imageUrls.optimized;

//             if (imageToDownload.isNotEmpty) {
//               await downloadAndConvertImage(imageToDownload, imageRx);
//             }
//             imageBytesList.add(imageRx);
//           }));
//         } else {
//           Get.snackbar('No Data', 'Data motivasi tidak ditemukan.');
//         }
//       } else {
//         Get.snackbar('Error', 'Failed to load motivasi');
//       }
//     } catch (e) {
//       Get.snackbar('Error', 'An error occurred while fetching motivasi.');
//       debugPrint("Error fetching motivasi: $e");
//     } finally {
//       isLoading.value = false;
//       update();
//     }
//   }

//   // Fungsi untuk mengunduh gambar dan menyimpannya sebagai Uint8List
//   Future<void> downloadAndConvertImage(
//       String imageUrl, Rx<Uint8List?> imageRx) async {
//     if (imageUrl.isEmpty) {
//       debugPrint("Invalid image URL: $imageUrl");
//       imageRx.value = null;
//       return;
//     }

//     try {
//       debugPrint("Downloading image: $imageUrl");
//       final response = await http.get(Uri.parse(imageUrl));

//       if (response.statusCode == 200 && response.bodyBytes.isNotEmpty) {
//         imageRx.value = response.bodyBytes;
//         debugPrint("✅ Image downloaded successfully: $imageUrl");
//       } else {
//         imageRx.value = null;
//         debugPrint(
//             "❌ Failed to download image, Status Code: ${response.statusCode}");
//       }
//     } catch (e) {
//       imageRx.value = null;
//       debugPrint("⚠️ Error saat mengunduh gambar: $e");
//     }
//   }

//   // Fetch detail motivasi berdasarkan ID konten
//   Future<void> fetchMotivasiDetail(int contentId) async {
//     try {
//       debugPrint('=== START FETCHING MOTIVASI DETAIL ===');
//       final token = await getToken();
//       if (token == null) {
//         debugPrint('Token not found');
//         Get.snackbar('Error', 'User not authenticated!');
//         return;
//       }
//       debugPrint(
//           'Token found: ${token.substring(0, 10)}...'); // Hanya tampilkan sebagian token

//       final url = 'https://ebook.dev.whatthefun.id/api/v1/contents/$contentId';
//       debugPrint('Making request to: $url');

//       final response = await http.get(
//         Uri.parse(url),
//         headers: {
//           'Authorization': 'Bearer $token',
//           'Content-Type': 'application/json',
//           'Accept': 'application/json',
//         },
//       );

//       debugPrint('Response status code: ${response.statusCode}');
//       debugPrint('Response headers: ${response.headers}');
//       debugPrint('Response body: ${response.body}');

//       if (response.statusCode == 200) {
//         final jsonData = jsonDecode(response.body);
//         debugPrint('JSON decoded successfully');

//         if (jsonData['data'] != null) {
//           debugPrint('Data found in response');
//           try {
//             motivasiDetail.value = Motivasi.fromJson(jsonData['data']);
//             debugPrint(
//                 'Motivasi detail parsed: ${motivasiDetail.value?.title}');

//             if (motivasiDetail.value != null) {
//               debugPrint(
//                   'Successfully loaded motivasi with ID: ${motivasiDetail.value?.id}');
//               update(); // Memastikan UI diupdate
//             } else {
//               debugPrint(' Motivasi detail is null after parsing');
//             }
//           } catch (parseError) {
//             debugPrint(' Error parsing JSON: $parseError');
//             Get.snackbar('Error', 'Gagal memproses data');
//           }
//         } else {
//           debugPrint('No data found in response');
//           Get.snackbar('Error', 'Data tidak ditemukan');
//         }
//       } else {
//         debugPrint('Bad response: ${response.statusCode}');
//         debugPrint(' Response body: ${response.body}');
//         Get.snackbar('Error', 'Gagal memuat detail (${response.statusCode})');
//       }
//     } catch (e, stackTrace) {
//       debugPrint('Error fetching motivasi detail: $e');
//       debugPrint('Stack trace: $stackTrace');
//       Get.snackbar('Error', 'Terjadi kesalahan saat memuat detail');
//     } finally {
//       debugPrint('=== END FETCHING MOTIVASI DETAIL ===');
//     }
//   }

//   Future<void> fetchImageBytes(String imageUrl) async {
//     try {
//       debugPrint('🖼 Fetching image bytes for: $imageUrl');

//       var response = await http.get(Uri.parse(imageUrl));

//       if (response.statusCode == 200) {
//         imageBytesList.clear();
//         imageBytesList.add(Rx(response.bodyBytes));

//         debugPrint('✅ Image bytes fetched successfully!');
//         update(); // 🔥 Memastikan UI di-refresh
//       } else {
//         debugPrint('❌ Failed to fetch image bytes: ${response.statusCode}');
//       }
//     } catch (e) {
//       debugPrint('⚠️ Error fetching image bytes: $e');
//     }
//   }

//   @override
//   void onInit() {
//     super.onInit();
//     fetchSubcategories();
//   }
// }
