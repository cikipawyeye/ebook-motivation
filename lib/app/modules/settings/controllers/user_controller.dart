import 'dart:convert';
import 'package:ebookapp/app/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ebookapp/core/constants/constant.dart';

class UserController extends GetxController {
  var isLoading = false.obs; // Untuk menandai proses loading
  var userResponse = Rxn<UserResponse>(); // Menyimpan data UserResponse
  var isPremium = false.obs; // Menyimpan status premium user
  var userId = Rxn<int>();
  var phoneNumber = ''.obs;
  final isScrollLimitReached = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserProfile(); // Ambil data profil user saat controller diinisialisasi
    _loadIsPremium(); // Muat isPremium dari SharedPreferences saat controller diinisialisasi
  }

  @override
  void onClose() {
    userResponse.value = null; // Bersihkan data saat controller ditutup
    isLoading.value = false; // Reset status loading
    userId.value = null;
    super.onClose();
  }

  // Method untuk mengambil token dari SharedPreferences
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  // Method untuk menyimpan isPremium ke SharedPreferences
  Future<void> _saveIsPremium(bool isPremium) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isPremium', isPremium);
    debugPrint('✅ Disimpan isPremium: $isPremium');
  }

  // Method untuk memuat isPremium dari SharedPreferences
  Future<void> _loadIsPremium() async {
    final prefs = await SharedPreferences.getInstance();
    isPremium.value = prefs.getBool('isPremium') ?? false;
    debugPrint('✅ Dimuat isPremium: ${isPremium.value}');
  }

  // Method untuk mengambil data profil user dari API
  Future<void> fetchUserProfile() async {
    if (isLoading.value) return;
    isLoading.value = true;

    try {
      final token = await getToken();
      if (token == null) {
        Get.snackbar('Kesalahan', 'Pengguna tidak terautentikasi!');
        return;
      }

      debugPrint('🔄 Mengambil data profil pengguna');
      debugPrint('🔄 $baseUrl/api/v1/profile');

      final response = await http.get(
        Uri.parse('$baseUrl/api/v1/profile'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode != 200) {
        Get.snackbar('Kesalahan', 'Gagal memuat profil pengguna');
        debugPrint('Respon kesalahan: ${response.body}');
        return;
      }

      final jsonResponse = json.decode(response.body);
      debugPrint('Respon API: $jsonResponse'); // Cetak respons API

      if (jsonResponse['data'] == null) {
        Get.snackbar('Tidak Ada Data', 'Data profil pengguna tidak ditemukan.');
        return;
      }

      // Parsing data ke dalam model UserResponse
      userResponse.value = UserResponse.fromJson(jsonResponse);

      // Set ID user
      userId.value = userResponse.value?.user.id;

      // Simpan isPremium ke SharedPreferences
      if (userResponse.value?.user.isPremium != null) {
        await _saveIsPremium(userResponse.value!.user.isPremium);
        isPremium.value = userResponse.value!.user.isPremium;
        debugPrint('✅ Diperbarui isPremium: ${isPremium.value}');
      }

      debugPrint('✅ Data profil pengguna berhasil diambil');
    } catch (e) {
      Get.snackbar(
          'Kesalahan', 'Terjadi kesalahan saat mengambil profil pengguna.');
      debugPrint("Kesalahan saat mengambil profil pengguna: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // Method untuk memperbarui profil user
  Future<void> updateUserProfile(Map<String, dynamic> data) async {
    if (isLoading.value) return;
    isLoading.value = true;

    try {
      final token = await getToken();
      if (token == null) {
        Get.snackbar('Kesalahan',
            'Pengguna tidak terautentikasi!'); // Diterjemahkan ke Bahasa Indonesia
        return;
      }

      debugPrint('🔄 Memperbarui data profil pengguna');
      debugPrint('🔄 $baseUrl/api/v1/profile');

      // Kirim data ke server dengan format yang sesuai
      final response = await http.post(
        Uri.parse('$baseUrl/api/v1/profile'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode({
          'name': data['name'],
          'email': data['email'],
          'birth_date': data['birth_date'],
          'city_code': data['city_code'],
          'job_type': data['job_type'],
          'job': data['job'],
          'phone_number': data['phone_number'],
          'gender': data['gender'],
        }),
      );

      if (response.statusCode != 200) {
        Get.snackbar('Gagal', 'Gagal untuk memperbarui');
        debugPrint('Respon gagal: ${response.body}');
        return;
      }

      final jsonResponse = json.decode(response.body);
      if (jsonResponse['data'] == null) {
        Get.snackbar(
            'Gagal', 'Untuk memperbarui profil: ${jsonResponse['message']}');
        return;
      }

      // Update userResponse dengan data terbaru
      userResponse.value = UserResponse.fromJson(jsonResponse);
      phoneNumber.value = data['phone_number'] ?? phoneNumber.value;

      Get.snackbar('Berhasil!', 'Update berhasil');
      debugPrint('✅ Update Berhasil: ${userResponse.value}');
    } catch (e) {
      Get.snackbar('Gagal', 'Terjadi kesalahan.');
      debugPrint("Gagal memperbarui profil: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // Method untuk mencari kota berdasarkan query
  Future<List<Map<String, dynamic>>> searchCities(String query) async {
    try {
      final token = await getToken();
      if (token == null) {
        Get.snackbar('Kesalahan', 'Pengguna tidak terautentikasi!');
        return [];
      }

      debugPrint('🔄 Mencari kota dengan query: $query');
      debugPrint('🔄 $baseUrl/api/v1/register/cities?search=$query');

      final response = await http.get(
        Uri.parse('$baseUrl/api/v1/register/cities?search=$query'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode != 200) {
        Get.snackbar('Kesalahan', 'Gagal mencari kota');
        debugPrint('Respon kesalahan: ${response.body}');
        return [];
      }

      final jsonResponse = json.decode(response.body);
      if (jsonResponse['data'] == null) {
        Get.snackbar('Tidak Ada Data', 'Tidak ada kota ditemukan.');
        return [];
      }

      // Parsing data kota
      final List<Map<String, dynamic>> cities = [];
      for (var city in jsonResponse['data']) {
        cities.add({
          'name': city['name'],
          'code': city['code'],
        });
      }

      debugPrint('✅ Kota berhasil diambil: $cities');
      return cities;
    } catch (e) {
      Get.snackbar('Kesalahan', 'Terjadi kesalahan saat mencari kota.');
      debugPrint("Kesalahan saat mencari kota: $e");
      return [];
    }
  }

  Future<void> logout() async {
    if (isLoading.value) return;
    isLoading.value = true;

    try {
      final token = await getToken();
      if (token == null) {
        Get.snackbar('Kesalahan', 'Pengguna tidak terautentikasi!');
        return;
      }

      debugPrint('🔄 Keluar');
      debugPrint('🔄 $baseUrl/api/v1/logout');

      http.post(
        Uri.parse('$baseUrl/api/v1/logout'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      // Hapus token dan semua data pembayaran dari SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('token');

      // Reset nilai di controller
      userId.value = null;

      Get.snackbar('Sukses', 'Berhasil keluar');
      debugPrint('✅ Berhasil keluar');
    } catch (e) {
      Get.snackbar('Kesalahan', 'Terjadi kesalahan saat keluar.');
      debugPrint("Kesalahan saat keluar: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
