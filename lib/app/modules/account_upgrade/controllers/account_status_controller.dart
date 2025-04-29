import 'dart:convert';
import 'package:ebookapp/app/modules/account_upgrade/models/account_status/account_status.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ebookapp/core/constants/constant.dart';

class AccountStatusController extends GetxController {
  final checkingAccountStatus = RxBool(false);
  final accountStatus = Rxn<AccountStatus>();

  @override
  onInit() {
    super.onInit();
    checkAccountStatus();
  }

  Future<String?> _getToken() async =>
      (await SharedPreferences.getInstance()).getString('token');

  void _handleApiError(String message, dynamic error) {
    Get.snackbar(errorTitle, errorDescription);
    debugPrint("Kesalahan: $error");
  }

  Future<void> checkAccountStatus() async {
    checkingAccountStatus.value = true;
    try {
      final token = await _getToken();
      if (token == null) {
        _handleApiError('Pengguna tidak terautentikasi!', null);
        checkingAccountStatus.value = false;
      }

      final response = await http.get(
        Uri.parse('$baseUrl/api/v1/upgrade/status'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      debugPrint(response.body);

      if (response.statusCode != 200) {
        _handleApiError('Gagal mengambil status pembayaran', response.body);
        checkingAccountStatus.value = false;
        return;
      }

      final jsonResponse = json.decode(response.body);
      accountStatus.value = AccountStatus.fromJson(jsonResponse['data']);
    } catch (e) {
      _handleApiError('Terjadi kesalahan saat memeriksa status akun.', e);
    } finally {
      checkingAccountStatus.value = false;
    }
  }
}
