import 'dart:async';
import 'dart:convert';
import 'package:ebookapp/app/modules/account_upgrade/models/payment/payment.dart';
import 'package:ebookapp/app/modules/account_upgrade/models/payment/payment_method.dart';
import 'package:ebookapp/app/modules/account_upgrade/models/payment/qr_code.dart';
import 'package:ebookapp/app/modules/account_upgrade/models/payment/virtual_account.dart';
import 'package:ebookapp/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ebookapp/core/constants/constant.dart';

class PaymentDetailController extends GetxController {
  final isLoading = RxBool(false);
  final isExpanded = RxBool(false);
  final payment = Rxn<Payment>();
  final paymentType = Rxn<PaymentMethodType>();
  final qrCode = Rxn<QRCode>();
  final virtualAccount = Rxn<VirtualAccount>();
  final countdown = Rxn<Duration>();
  final expiresAt = Rxn<DateTime>();

  // Helper method to get token from SharedPreferences
  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  void _handleApiError(String message, dynamic error) {
    Get.snackbar(errorTitle, errorDescription);
    debugPrint("Kesalahan API: $error");
  }

  void updateCountdown() {}

  // Fetch payment info
  Future<void> fetchPaymentInfo(int paymentId) async {
    if (isLoading.value) return;
    isLoading.value = true;

    try {
      final token = await _getToken();
      if (token == null) {
        _handleApiError('Pengguna tidak terautentikasi!', null);
        isLoading.value = false;
        return;
      }

      debugPrint('🔄 Mengambil informasi pembayaran untuk ID: $paymentId');
      final response = await http.get(
        Uri.parse('$baseUrl/api/v1/payments/$paymentId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode != 200) {
        _handleApiError('Gagal mengambil informasi pembayaran', response.body);
        isLoading.value = false;
        return;
      }

      final jsonResponse = json.decode(response.body);
      debugPrint('Respon API: $jsonResponse');

      payment.value =
          Payment.fromJson(jsonResponse['data'] as Map<String, dynamic>);
      paymentType.value = payment.value?.paymentMethod.type;

      // Set for virtual account
      if (payment.value?.paymentMethod.type ==
              PaymentMethodType.virtualAccount &&
          payment.value?.paymentMethod.virtualAccount != null) {
        expiresAt.value = payment
            .value!.paymentMethod.virtualAccount!.channelProperties.expiresAt;

        virtualAccount.value = payment.value?.paymentMethod.virtualAccount;
        qrCode.value = null;

        Timer.periodic(const Duration(seconds: 1), (timer) {
          final Duration newRemainingTime =
              expiresAt.value!.difference(DateTime.now());
          if (newRemainingTime.inSeconds <= 0) {
            timer.cancel();
          }
          countdown.value = newRemainingTime;
        });
      } else if (payment.value?.paymentMethod.type ==
              PaymentMethodType.qrCode &&
          payment.value?.paymentMethod.qrCode != null) {
        // Set for QR Code
        qrCode.value = payment.value?.paymentMethod.qrCode;
        virtualAccount.value = null;

        expiresAt.value =
            payment.value!.paymentMethod.qrCode!.channelProperties.expiresAt;

        if (expiresAt.value != null) {
          Timer.periodic(const Duration(seconds: 1), (timer) {
            final Duration newRemainingTime =
                expiresAt.value!.difference(DateTime.now());
            if (newRemainingTime.inSeconds <= 0) {
              timer.cancel();
            }
            countdown.value = newRemainingTime;
          });
        }
      }
    } catch (e) {
      _handleApiError(
          'Terjadi kesalahan saat mengambil informasi pembayaran.', e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshPayment(int paymentId) async {
    await fetchPaymentInfo(paymentId).then((value) {
      if (payment.value?.status == PaymentStatus.expired ||
          payment.value?.status == PaymentStatus.failed ||
          payment.value?.status == PaymentStatus.canceled) {
        Get.snackbar(
          payment.value!.status == PaymentStatus.expired
              ? 'Metode Pembayaran Kadaluarsa'
              : 'Pembayaran Gagal',
          'Silakan buat metode pembayaran baru!',
        );
        Get.offAllNamed(Routes.createPayment);
      } else if (payment.value?.status == PaymentStatus.succeeded) {
        Get.snackbar(
            'Pembayaran Berhasil', 'Terima kasih telah melakukan pembayaran!');
        Get.offAllNamed(Routes.home);
      }
    });
  }
}
