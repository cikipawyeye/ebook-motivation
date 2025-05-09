import 'dart:convert';
import 'package:ebookapp/app/data/models/user_model.dart';
import 'package:ebookapp/core/constants/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  final ScrollController scrollController = ScrollController();

  var canScrollUp = false.obs;
  var canScrollDown = false.obs;

  var isLoading = false.obs;
  var userResponse = Rxn<UserResponse>();

  @override
  void onInit() {
    fetchUserProfile();
    super.onInit();

    scrollController.addListener(_scrollListener);
  }

  void determineIsCanScroll() {
    canScrollUp.value = false;
    canScrollDown.value = false;
    _scrollListener();
  }

  void _scrollListener() {
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.offset;
    final minScroll = scrollController.position.minScrollExtent;

    canScrollUp.value = currentScroll > minScroll;
    canScrollDown.value = currentScroll < maxScroll;
  }

  @override
  void onClose() {
    userResponse.value = null;
    isLoading.value = false;
    scrollController.dispose();
    super.onClose();
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<void> fetchUserProfile() async {
    if (isLoading.value) return;
    isLoading.value = true;

    try {
      final token = await getToken();
      if (token == null) {
        Get.snackbar('Kesalahan', 'Pengguna tidak terautentikasi!');
        isLoading.value = false;
        return;
      }

      // curl -H "Authorization: Bearer 578|aXDY6OPmcDijsKUYlkqkRcpucHLfxP0MdhbBRpV63de2eba1" \
      //      -H "Content-Type: application/json" \
      //      -H "Accept: application/json" \
      //      https://motivasiislami.com/api/v1/profile
      final response = await http.get(
        Uri.parse('$baseUrl/api/v1/profile'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse['data'] != null) {
          userResponse.value = UserResponse.fromJson(jsonResponse);
          _saveIsPremium(userResponse.value!.user.isPremium).then((_) => {});
        } else {
          Get.snackbar('Kesalahan', 'Data profil pengguna tidak ditemukan.');
        }
      } else {
        Get.snackbar('Kesalahan', 'Gagal memuat profil pengguna');
      }
    } catch (e) {
      Get.snackbar(
          'Kesalahan', 'Terjadi kesalahan saat mengambil profil pengguna.');
      debugPrint(
          "[home_controller] Kesalahan saat mengambil profil pengguna: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _saveIsPremium(bool isPremium) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isPremium', isPremium);
  }
}
