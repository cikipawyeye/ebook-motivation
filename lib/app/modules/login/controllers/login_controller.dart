import 'dart:convert';
import 'package:ebookapp/core/utlis/api_endpoint.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:ebookapp/core/constants/constant.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  RxBool isHidden = true.obs;
  RxBool isLoggedIn = false.obs;
  final emailError = RxnString();
  final passwordError = RxnString();

  LoginController() {
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final SharedPreferences prefs = await _prefs;
    String? token = prefs.getString('token');
    if (token != null) {
      isLoggedIn.value = true;
      Get.offAllNamed('/home');
    }
  }

  Future<bool> loginWithEmail() async {
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };

    try {
      var url =
          Uri.parse(ApiEndpoint.baseUrl + ApiEndpoint.authEndPoint.loginEmail);
      Map<String, String> body = {
        'email': emailController.text.trim(),
        'password': passController.text,
      };

      http.Response response =
          await http.post(url, body: jsonEncode(body), headers: headers);

      debugPrint('Response: ${response.body}');
      final json = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (json['data'] != null && json['data']['token'] != null) {
          var token = json['data']['token'];
          final SharedPreferences prefs = await _prefs;
          await prefs.setString('token', token);
          isLoggedIn.value = true;
          return true;
        } else {
          Get.snackbar(
              'Login Gagal', 'Email atau kata sandi yang dimasukkan salah');
          return false;
        }
      } else {
        if (json['message'] != null) {
          Get.snackbar('Login Gagal', json['message']);
        } else {
          Get.snackbar('Login Gagal', 'Terjadi kesalahan, silakan coba lagi.');
        }

        if (json['errors'] != null) {
          if (json['errors']['email'] != null) {
            setErrorState(email: json['errors']['email'][0]);
          }
          if (json['errors']['password'] != null) {
            setErrorState(password: json['errors']['password'][0]);
          }
        } else {
          setErrorState();
        }

        return false;
      }
    } catch (e) {
      debugPrint('$e');
      setErrorState();
      Get.snackbar(errorTitle, errorDescription);
      return false;
    }
  }

  Future<bool> forgotPassword(String email) async {
    Get.offAllNamed('/success-forgot');
    var headers = {'Content-Type': 'application/json'};

    try {
      var url = Uri.parse('$baseUrl/api/v1/forgot-password');
      Map<String, String> body = {
        'email': email.trim(),
      };

      http.Response response =
          await http.post(url, body: jsonEncode(body), headers: headers);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        Get.snackbar('Berhasil', json['message']);
      } else {
        final json = jsonDecode(response.body);
        Get.snackbar('Gagal',
            json['message'] ?? 'Gagal mengirim email untuk reset kata sandi.');
      }
    } catch (e) {
      Get.snackbar('Gagal', 'Terjadi kesalahan, silakan coba lagi.');
    }

    return true;
  }

  void setErrorState({String? email, String? password}) {
    emailError.value = email;
    passwordError.value = password;
  }

  void resetErrorState() {
    emailError.value = null;
    passwordError.value = null;
  }
}
