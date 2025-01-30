import 'dart:convert';
import 'package:ebookapp/core/utlis/api_endpoint.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  RxBool isHidden = true.obs;

  // Cek apakah pengguna sudah login
  RxBool isLoggedIn = false.obs;

  // Fungsi untuk login dengan email dan password
  Future<void> loginWithEmail() async {
    var headers = {'Content-Type': 'application/json'};

    try {
      var url = Uri.parse(ApiEndpoint.baseUrl + ApiEndpoint.authEndPoint.loginEmail);
      Map<String, String> body = {
        'email': emailController.text.trim(),
        'password': passController.text
      };

      // Kirim request POST ke server
      http.Response response = await http.post(url, body: jsonEncode(body), headers: headers);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        
        // Cek apakah login berhasil (code == 0)
        if (json['data'] != null && json['data']['token'] != null) {
          var token = json['data']['token'];
          
          // Simpan token ke SharedPreferences
          final SharedPreferences prefs = await _prefs;
          await prefs.setString('token', token);

          // Set status login berhasil
          isLoggedIn.value = true;

          // Navigasi ke HomePage
          Get.offAllNamed('/home');  // Menggunakan GetX untuk navigasi ke halaman Home
        } else {
          // Jika login gagal, beri pesan error
          Get.snackbar('Login Failed', 'Invalid credentials or server error');
        }
      } else {
        Get.snackbar('Login Failed', 'Error: ${response.statusCode}');
      }
    } catch (e) {
      // Tangani error seperti koneksi internet yang hilang
      Get.snackbar('Login Failed', 'An error occurred. Please try again.');
    }
  }
}
