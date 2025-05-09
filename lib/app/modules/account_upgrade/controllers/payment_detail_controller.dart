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

  List<PaymentInstruction>? getPaymentInstructions() {
    if (payment.value?.paymentMethod.type == PaymentMethodType.virtualAccount &&
        payment.value?.paymentMethod.virtualAccount != null) {
      if (payment.value?.paymentMethod.virtualAccount!.channelCode ==
          VirtualAccountChannel.bri) {
        return [
          PaymentInstruction(title: '1. Melalui ATM BRI:', instruction: [
            '- Masukan kartu ATM BRI dan PIN Anda.',
            '- Pilih menu "Transaksi Lain".',
            '- Pilih menu "Pembayaran".',
            '- Pilih menu "Lainnya".',
            '- Pilih menu "BRIVA".',
            '- Masukkan nomor Virtual Account (BRIVA).',
            '- Konfirmasi data pembayaran dan lanjutkan transaksi.'
          ]),
          PaymentInstruction(
              title: '2. Melalui BRImo (Mobile Banking):',
              instruction: [
                '- Login ke aplikasi BRImo.',
                '- Pilih menu "Pembayaran".',
                '- Pilih menu "BRIVA".',
                '- Masukkan nomor Virtual Account.',
                '- Konfirmasi transaksi dan bayar.'
              ]),
        ];
      }

      if (payment.value?.paymentMethod.virtualAccount!.channelCode ==
          VirtualAccountChannel.bni) {
        return [
          PaymentInstruction(title: '1. Melalui ATM BNI:', instruction: [
            '- Masukkan kartu ATM dan PIN Anda.',
            '- Pilih menu "Lainnya", lalu "Transfer".',
            '- Pilih jenis rekening yang akan digunakan (misalnya, Tabungan).',
            '- Pilih "Virtual Account Billing".',
            '- Masukkan nomor Virtual Account (VA).',
            '- Tagihan akan ditampilkan, konfirmasi jika sesuai dan lanjutkan transaksi.'
          ]),
          PaymentInstruction(
              title: '2. Melalui BNI Mobile Banking:',
              instruction: [
                '- Buka aplikasi BNI Mobile Banking dan login.',
                '- Pilih menu "Transfer", lalu "Virtual Account Billing".',
                '- Pilih rekening yang akan digunakan.',
                '- Masukkan nomor Virtual Account (VA).',
                '- Tagihan akan ditampilkan, konfirmasi jika sesuai dan masukkan PIN transaksi.'
              ]),
        ];
      }

      if (payment.value?.paymentMethod.virtualAccount!.channelCode ==
          VirtualAccountChannel.mandiri) {
        return [
          PaymentInstruction(title: '1. Melalui ATM Mandiri:', instruction: [
            '- Masukkan kartu ATM dan PIN Anda.',
            '- Pilih menu "Bayar/Beli".',
            '- Pilih "Multi Payment".',
            '- Masukkan nomor Virtual Account (VA).',
            '- Masukkan nominal pembayaran.',
            '- Konfirmasikan dan simpan struk.'
          ]),
          PaymentInstruction(
              title: '2. Melalui Livin\' by Mandiri:',
              instruction: [
                '- Login ke aplikasi Livin\' by Mandiri.',
                '- Pilih menu "Bayar/VA".',
                '- Masukkan nomor Virtual Account (VA).',
                '- Pilih sumber dana.',
                '- Konfirmasi dan masukkan PIN.'
              ]),
        ];
      }

      if (payment.value?.paymentMethod.virtualAccount!.channelCode ==
          VirtualAccountChannel.bsi) {
        return [
          PaymentInstruction(title: '1. Melalui ATM BSI:', instruction: [
            '- Masukkan kartu ATM dan PIN Anda.',
            '- Pilih menu "Transfer".',
            '- Pilih "Virtual Account Billing".',
            '- Masukkan nomor Virtual Account (VA).',
            '- Konfirmasi detail transaksi dan masukkan PIN.'
          ]),
          PaymentInstruction(title: '2. Melalui BSI Mobile:', instruction: [
            '- Buka aplikasi BSI Mobile dan login.',
            '- Pilih menu "Bayar".',
            '- Pilih "Akademik" (atau menu terkait, seperti "Institusi").',
            '- Masukkan kode institusi (jika ada).',
            '- Masukkan nomor VA tanpa kode institusi (jika ada).',
            '- Konfirmasi detail transaksi dan masukkan PIN.'
          ]),
        ];
      }

      if (payment.value?.paymentMethod.virtualAccount!.channelCode ==
          VirtualAccountChannel.bjb) {
        return [
          PaymentInstruction(
              title: '1. Melalui Aplikasi DIGI bank bjb:',
              instruction: [
                '- Login ke aplikasi DIGI bank bjb.',
                '- Pilih menu "Transfer".',
                '- Pilih "Virtual Account" atau "Transfer Antar Bank".',
                '- Masukkan nomor Virtual Account yang akan dibayarkan.',
                '- Konfirmasi pembayaran dan masukkan m-PIN.',
                '- Transaksi selesai.'
              ]),
          PaymentInstruction(title: '2. Melalui ATM Bank bjb:', instruction: [
            '- Masukkan kartu ATM dan PIN.',
            '- Pilih menu "Transaksi Lainnya" > "Virtual Account".',
            '- Pilih jenis rekening (Tabungan atau Giro).',
            '- Masukkan nomor Virtual Account.',
            '- Konfirmasi pembayaran dan pilih "Ya".',
            '- Struk pembayaran akan keluar.'
          ]),
        ];
      }

      if (payment.value?.paymentMethod.virtualAccount!.channelCode ==
          VirtualAccountChannel.cimb) {
        return [
          PaymentInstruction(title: '1. Melalui ATM CIMB Niaga:', instruction: [
            '- Masukkan kartu ATM CIMB Niaga dan PIN.',
            '- Pilih menu "Pembayaran" lalu "Virtual Account".',
            '- Masukkan nomor VA yang diberikan.',
            '- Konfirmasi data pembayaran, lalu pilih "Proses" atau "Lanjut".',
            '- Ambil bukti pembayaran.'
          ]),
          PaymentInstruction(
              title: '2. Melalui CIMB Clicks atau OCTO Mobile:',
              instruction: [
                '- Login ke CIMB Clicks atau OCTO Mobile.',
                '- Pilih menu "Transfer" atau "Bayar Tagihan" - lalu "Virtual Account".',
                '- Pilih rekening sumber dana.',
                '- Masukkan nomor VA dan jumlah pembayaran.',
                '- Konfirmasi data pembayaran, lalu masukkan mPIN atau PIN Mobile.',
                '- Pembayaran selesai, bukti pembayaran akan dikirim via SMS.'
              ]),
        ];
      }

      return [
        PaymentInstruction(title: '1. Melalui ATM:', instruction: [
          '- Masukkan kartu ATM dan PIN Anda.',
          '- Pilih menu "Transfer".',
          '- Pilih "Virtual Account".',
          '- Masukkan nomor Virtual Account (VA).',
          '- Konfirmasi pembayaran dan simpan struk.'
        ]),
        PaymentInstruction(title: '2. Melalui Mobile Banking:', instruction: [
          '- Buka aplikasi mobile banking dan login.',
          '- Pilih menu "Transfer".',
          '- Pilih menu "Virtual Account".',
          '- Masukkan nomor Virtual Account (VA).',
          '- Konfirmasi pembayaran dan masukkan PIN.'
        ])
      ];
    }

    if (payment.value?.paymentMethod.type == PaymentMethodType.qrCode &&
        payment.value?.paymentMethod.qrCode != null) {
      return [
        PaymentInstruction(title: null, instruction: [
          '- Screenshoot kode QR pada aplikasi.',
          '- Login ke aplikasi mobile banking atau dompet digital Anda.',
          '- Pilih menu QR.',
          '- Lalu upload hasil foto screenshoot dari aplikasi dan jumlah pembayaran (jika ada).',
          '- Masukan pin Anda.',
          '- Pembayaran selesai.'
        ])
      ];
    }

    return null;
  }
}

final class PaymentInstruction {
  String? title;
  List<String>? instruction;

  PaymentInstruction({this.title, this.instruction});
}
