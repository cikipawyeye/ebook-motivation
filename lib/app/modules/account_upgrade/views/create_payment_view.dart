import 'package:ebookapp/app/modules/account_upgrade/controllers/create_payment_controller.dart';
import 'package:ebookapp/app/modules/settings/controllers/setting_theme_controller.dart';
import 'package:ebookapp/app/modules/settings/enums/payment.dart';
import 'package:ebookapp/core/constants/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CreatePaymentView extends GetView<CreatePaymentController> {
  const CreatePaymentView({super.key});

  @override
  Widget build(BuildContext context) {
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
                  child: Obx(() => Column(
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
                              controller.selectedChannelCode.value ??
                                  'Pilih Metode Pembayaran',
                              style: GoogleFonts.leagueSpartan(
                                fontSize: 16,
                                color: Colors.black54,
                              ),
                            ),
                            children: PaymentType.values
                                .where((val) => val != PaymentType.ewallet)
                                .map((paymentType) {
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
                                        color:
                                            Colors.grey.withValues(alpha: 0.1),
                                      ),
                                      child: Scrollbar(
                                        child: SingleChildScrollView(
                                          child: Column(
                                            children: paymentType.channels
                                                .map((channelCode) {
                                              return ListTile(
                                                title: Text(
                                                  channelCode.label,
                                                  style:
                                                      GoogleFonts.leagueSpartan(
                                                    fontSize: 16,
                                                  ),
                                                ),
                                                onTap: () {
                                                  controller.selectedPaymentType
                                                          .value =
                                                      paymentType.value;
                                                  controller.selectedChannelCode
                                                          .value =
                                                      channelCode.value;
                                                  Get.snackbar('Berhasil',
                                                      'Metode pembayaran dipilih: ${channelCode.label}',
                                                      isDismissible: true,
                                                      duration: const Duration(
                                                          seconds: 1));
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
                                                tileColor: controller
                                                            .selectedChannelCode
                                                            .value ==
                                                        channelCode.value
                                                    ? Colors.blue
                                                        .withValues(alpha: 0.1)
                                                    : Colors.white,
                                                selected: controller
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
                      )),
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
                  child: Obx(() => ElevatedButton(
                        onPressed: () {
                          if (controller.isProcessing.value) {
                            return;
                          }

                          if (controller.selectedPaymentType.value == null ||
                              controller.selectedChannelCode.value == null) {
                            Get.snackbar('Oops..',
                                'Pilih metode pembayaran terlebih dahulu');
                            return;
                          }

                          // Upgrade akun dan ambil paymentId
                          controller.upgradeAccount();
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
                          controller.isProcessing.value
                              ? 'Memproses...'
                              : 'Lanjutkan Pembayaran',
                          style: GoogleFonts.leagueSpartan(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
