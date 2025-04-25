import 'package:ebookapp/app/modules/settings/controllers/payment_detail_controller.dart';
import 'package:ebookapp/app/modules/settings/controllers/setting_theme_controller.dart';
import 'package:ebookapp/app/modules/settings/enums/payment.dart';
import 'package:ebookapp/app/routes/app_pages.dart';
import 'package:ebookapp/core/constants/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentDetail extends GetView<PaymentController> {
  const PaymentDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final PaymentController paymentController = Get.find<PaymentController>();
    final ThemeController themeController = Get.find<ThemeController>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Rincian',
          style: GoogleFonts.leagueSpartan(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 25,
          ),
        ),
        centerTitle: true,
        backgroundColor: themeController.currentColor, // Warna biru gelap
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/Watermark.png'),
            fit: BoxFit.cover, // Mengatur gambar agar menutupi seluruh area
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Rincian Produk
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withValues(alpha: 0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'assets/icons/payment_logo_icon.png', // Ganti dengan path gambar yang sesuai
                            width: 82,
                            height: 82,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/icons/crown_icon.png',
                                      width: 17,
                                      height: 17,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Premium',
                                      style: GoogleFonts.leagueSpartan(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  'Motivasi Penyejuk Hati\nDari Al-Qur\'an',
                                  style: GoogleFonts.leagueSpartan(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total',
                            style: GoogleFonts.leagueSpartan(
                              fontSize: 16,
                              color: Colors.black54,
                            ),
                          ),
                          Text(
                            'Rp 29.900,00',
                            style: GoogleFonts.leagueSpartan(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Metode Pembayaran
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withValues(alpha: 0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Metode Pembayaran',
                        style: GoogleFonts.leagueSpartan(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Pilih metode pembayaran',
                        style: GoogleFonts.leagueSpartan(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 16),
                      // ExpansionTile untuk kategori pembayaran
                      ExpansionTile(
                        title: Text(
                          paymentController.selectedChannelCode.value ??
                              'Pilih Metode Pembayaran',
                          style: GoogleFonts.leagueSpartan(
                            fontSize: 16,
                            color: Colors.black54,
                          ),
                        ),
                        children: PaymentType.values.map((paymentType) {
                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey.withValues(alpha: 0.3),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: ExpansionTile(
                              title: Text(
                                paymentType.label,
                                style: GoogleFonts.leagueSpartan(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              children: [
                                Container(
                                  constraints: BoxConstraints(
                                    maxHeight: 200, // Batas tinggi dropdown
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.grey.withValues(alpha: 0.1),
                                  ),
                                  child: Scrollbar(
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: paymentType.channels
                                            .map((channelCode) {
                                          return ListTile(
                                            title: Text(
                                              channelCode.label,
                                              style: GoogleFonts.leagueSpartan(
                                                fontSize: 16,
                                              ),
                                            ),
                                            onTap: () {
                                              paymentController
                                                  .selectedPaymentType
                                                  .value = paymentType.value;
                                              paymentController
                                                  .selectedChannelCode
                                                  .value = channelCode.value;
                                              Get.snackbar('Berhasil',
                                                  'Metode pembayaran dipilih: ${channelCode.label}',
                                                  isDismissible: true,
                                                  duration: const Duration(
                                                      seconds: 1));
                                              // Update UI
                                              Get.forceAppUpdate();
                                            },
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                              horizontal: 16,
                                              vertical: 8,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            tileColor: paymentController
                                                        .selectedChannelCode
                                                        .value ==
                                                    channelCode.value
                                                ? Colors.blue
                                                    .withValues(alpha: 0.1)
                                                : Colors.white,
                                            selected: paymentController
                                                    .selectedChannelCode
                                                    .value ==
                                                channelCode.value,
                                            selectedTileColor: Colors.blue
                                                .withValues(alpha: 0.1),
                                            selectedColor: Colors.blue,
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Rincian Pembelian
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withValues(alpha: 0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Rincian Pembelian',
                        style: GoogleFonts.leagueSpartan(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '1x Premium App',
                            style: GoogleFonts.leagueSpartan(
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            'Rp 29.900,00',
                            style: GoogleFonts.leagueSpartan(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Biaya Admin',
                            style: GoogleFonts.leagueSpartan(
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            'Rp 0,00',
                            style: GoogleFonts.leagueSpartan(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Divider(),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total',
                            style: GoogleFonts.leagueSpartan(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Rp 29.900,00',
                            style: GoogleFonts.leagueSpartan(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Tombol Lanjutkan Pembayaran
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      if (paymentController.selectedPaymentType.value == null ||
                          paymentController.selectedChannelCode.value == null) {
                        Get.snackbar(
                            'Gagal', 'Pilih metode pembayaran terlebih dahulu');
                      } else {
                        // Upgrade akun dan ambil paymentId
                        await controller.upgradeAccount(
                          paymentType:
                              paymentController.selectedPaymentType.value!,
                          channelCode:
                              paymentController.selectedChannelCode.value!,
                          phoneNumber: '+628888888888', // Nomor telepon default
                        );

                        // Debugging: Tampilkan nilai paymentId
                        debugPrint('Payment ID: ${controller.paymentId.value}');

                        // Tunggu hingga paymentId diatur
                        if (controller.paymentId.value == null) {
                          Get.snackbar('Gagal', 'Mohon di Tunggu');
                          return;
                        }

                        // Ambil informasi pembayaran
                        await controller
                            .fetchPaymentInfo(controller.paymentId.value!);

                        // Debugging: Tampilkan nilai virtualAccountNumber dan expiresAt
                        debugPrint(
                            'Virtual Account Number: ${controller.virtualAccountNumber.value}');
                        debugPrint('Expires At: ${controller.expiresAt.value}');

                        // Pastikan data tidak null sebelum navigasi
                        if (controller.virtualAccountNumber.value == null ||
                            controller.expiresAt.value == null) {
                          Get.snackbar(
                              'Gagal', 'Data pembayaran tidak ditemukan');
                          return;
                        }

                        // Kirim argument ke PaymentPage
                        Get.toNamed(Routes.paymentPage, arguments: {
                          'paymentId':
                              controller.paymentId.value, // Kirim paymentId
                          'virtualAccountNumber':
                              controller.virtualAccountNumber.value,
                          'expiresAt': controller.expiresAt.value,
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorBackground, // Warna tombol
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      'Lanjutkan Pembayaran',
                      style: GoogleFonts.leagueSpartan(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
