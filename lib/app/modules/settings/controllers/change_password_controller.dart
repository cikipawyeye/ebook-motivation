import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '/../../../core/constants/constant.dart';

class ChangePasswordController extends GetxController {
  var isLoading = false.obs;
  var message = ''.obs;

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<void> changePassword(String currentPassword, String newPassword,
      String confirmPassword) async {
    if (isLoading.value) return;
    isLoading.value = true;

    try {
      final token = await getToken();
      if (token == null) {
        Get.snackbar('Kesalahan', 'Pengguna tidak terautentikasi!');
        return;
      }

      debugPrint('🔄 Mengubah kata sandi');
      debugPrint('🔄 ${baseUrl}/api/v1/change-password');

      final response = await http.post(
        Uri.parse('${baseUrl}/api/v1/change-password'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode({
          'current_password': currentPassword,
          'password': newPassword,
          'password_confirmation': confirmPassword, 
        }),
      );

      if (response.statusCode != 200) {
        final jsonResponse = json.decode(response.body);
        Get.snackbar('Kesalahan',
            jsonResponse['message'] ?? 'Gagal mengubah kata sandi');
        debugPrint('Response kesalahan: ${response.body}');
        return;
      }

      message.value = 'Kata sandi berhasil diubah.';
      Get.snackbar('Sukses', message.value); 
      debugPrint('✅ Kata sandi berhasil diubah');
    } catch (e) {
      Get.snackbar('Kesalahan', 'Terjadi kesalahan saat mengubah kata sandi.');
      debugPrint("Kesalahan saat mengubah kata sandi: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
