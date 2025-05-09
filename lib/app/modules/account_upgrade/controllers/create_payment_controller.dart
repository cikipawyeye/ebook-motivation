import 'dart:convert';
import 'package:ebookapp/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ebookapp/core/constants/constant.dart';

class CreatePaymentController extends GetxController {
  final selectedPaymentType = Rxn<String>();
  final selectedChannelCode = Rxn<String>();
  final isProcessing = RxBool(false);
  final ovoPhoneNumber = RxnString();

  // Helper method to get token from SharedPreferences
  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  void _handleApiError(String message, dynamic error) {
    Get.snackbar(errorTitle, errorDescription);
    debugPrint("Kesalahan API: $error");
  }

  // Upgrade account
  Future<void> upgradeAccount() async {
    debugPrint(
        '🔄 Meng-upgrade akun dengan tipe: ${selectedPaymentType.value} dan channel: ${selectedChannelCode.value}');

    if (isProcessing.value) return;
    isProcessing.value = true;

    try {
      final token = await _getToken();
      if (token == null) {
        _handleApiError('Pengguna tidak terautentikasi!', null);
        isProcessing.value = false;
        return;
      }

      debugPrint('🔄 Meng-upgrade akun');
      final response = await http.post(
        Uri.parse('$baseUrl/api/v1/upgrade'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode({
          'payment_type': selectedPaymentType.value,
          'channel_code': selectedChannelCode.value,
          'phone_number': ovoPhoneNumber.value,
        }),
      );

      if (response.statusCode != 200) {
        _handleApiError('Gagal untuk meng-upgrade akun', response.body);
        isProcessing.value = false;
        return;
      }

      final jsonResponse = json.decode(response.body);
      if (jsonResponse['data'] == null) {
        _handleApiError(
            'Gagal untuk meng-upgrade akun: ${jsonResponse['message']}', null);
        isProcessing.value = false;
        return;
      }

      debugPrint(response.body);

      Get.offNamed(Routes.paymentInfo, arguments: {
        'paymentId': jsonResponse['data']['payment_id'],
      });
    } catch (e) {
      _handleApiError('Terjadi kesalahan saat meng-upgrade akun.', e);
    } finally {
      isProcessing.value = false;
    }
  }
}
