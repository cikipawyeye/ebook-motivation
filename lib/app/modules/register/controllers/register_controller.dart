import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterController extends GetxController {
  // Controller untuk form input
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController jobController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  RxString selectedDomisili = ''.obs;
  RxList<Map<String, dynamic>> domisiliList = <Map<String, dynamic>>[].obs;
  RxBool isLoading = false.obs;

  // Fungsi untuk mengambil data kota berdasarkan query search
  Future<void> fetchCities(String searchQuery) async {
    if (searchQuery.isEmpty) {
      domisiliList.clear();
      return;
    }

    isLoading.value = true; // Set loading state
    var url = Uri.parse(
        'https://ebook.dev.whatthefun.id/api/v1/register/cities?search=$searchQuery');

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> cities = jsonDecode(response.body)['data'];

        // Menyaring dan mengambil nama kota (id dan name)
        domisiliList.value = cities.map((city) {
          return {
            'id': city['id'], // id kota
            'name': city['name'], // nama kota
          };
        }).toList();
      } else {
        Get.snackbar('Error', 'Failed to load cities');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred while fetching cities');
    } finally {
      isLoading.value = false; // Set loading selesai
    }
  }

  // Fungsi untuk validasi form pertama (Buat Akun)
  bool validateForm1() {
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        phoneController.text.isEmpty ||
        selectedDomisili.value.isEmpty ||
        jobController.text.isEmpty ||
        dobController.text.isEmpty) {
      return false;
    }
    return true;
  }

  // Fungsi untuk validasi form kedua (Kata Sandi)
  bool validateForm2() {
    if (passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      return false;
    }
    if (passwordController.text != confirmPasswordController.text) {
      return false;
    }
    return true;
  }

  // Fungsi untuk melakukan registrasi
  Future<void> register() async {
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    var url = Uri.parse('https://ebook.dev.whatthefun.id/api/v1/register');

    var body = {
      'name': nameController.text,
      'email': emailController.text,
      'phone_number': phoneController.text,
      'job': jobController.text,
      'birth_date': dobController.text,
      'gender': 'M',
      'city_code': selectedDomisili.value,
      'password': passwordController.text,
      'password_confirmation': confirmPasswordController.text,
    };

    try {
      http.Response response = await http.post(
        url,
        body: jsonEncode(body),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        await saveUserData(jsonResponse);
        Get.snackbar('Success', 'User registered successfully');
        Get.offAllNamed('/home');
      } else {
        Get.snackbar('Error', 'Failed to register user');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred. Please try again.');
    }
  }

  // Fungsi untuk menyimpan data user ke SharedPreferences setelah registrasi
  Future<void> saveUserData(Map<String, dynamic> jsonResponse) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', jsonResponse['data']['token']);
  }
}
