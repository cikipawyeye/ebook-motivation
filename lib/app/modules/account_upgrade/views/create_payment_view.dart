import 'package:ebookapp/app/modules/account_upgrade/controllers/create_payment_controller.dart';
import 'package:ebookapp/app/modules/account_upgrade/models/payment/payment_method.dart';
import 'package:ebookapp/app/modules/settings/controllers/setting_theme_controller.dart';
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
        backgroundColor: themeController.currentColor,
        iconTheme: const IconThemeData(
          color: Colors.white, // Warna ikon di AppBar
        ),
        leading: IconButton(
          icon: Image.asset(
            'assets/icons/arrow_left.png',
            fit: BoxFit.contain,
            width: 24,
            height: 24,
          ),
          onPressed: () => Get.back(),
        ),
      ),
      body: Stack(
        children: [
          Image.asset(
            "assets/images/Template.png",
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Rincian Produk
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.grey.withValues(alpha: 0.4),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8, right: 8),
                              child: Image.asset(
                                'assets/images/logo_white.png',
                                width: 73,
                                height: 73,
                              ),
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
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    'Motivasi Penyejuk Hati\nDari Al-Qur\'an',
                                    style: GoogleFonts.leagueSpartan(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
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
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'Rp 29.900,00',
                              style: GoogleFonts.leagueSpartan(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
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
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.grey.withValues(alpha: 0.4),
                        width: 1,
                      ),
                    ),
                    child: Obx(() => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Metode Pembayaran',
                              style: GoogleFonts.leagueSpartan(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Pilih metode pembayaran',
                              style: GoogleFonts.leagueSpartan(
                                fontSize: 16,
                                color: Colors.white.withValues(alpha: 0.8),
                              ),
                            ),
                            const SizedBox(height: 16),
                            // ExpansionTile untuk kategori pembayaran
                            ExpansionTile(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: Colors.transparent,
                                  // width: 0,
                                ),
                              ),
                              iconColor: Colors.white,
                              collapsedIconColor: Colors.white,
                              title: Text(
                                controller.selectedChannelCode.value ??
                                    'Pilih Metode Pembayaran',
                                style: GoogleFonts.leagueSpartan(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                              children: PaymentMethodType.values
                                  .where(
                                      (val) => val != PaymentMethodType.ewallet)
                                  .map((PaymentMethodType paymentType) {
                                return Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 4),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey.withValues(alpha: 0.3),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: ExpansionTile(
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        color: Colors.transparent,
                                        // width: 0,
                                      ),
                                    ),
                                    iconColor: Colors.white,
                                    collapsedIconColor: Colors.white,
                                    title: Text(
                                      paymentType.label,
                                      style: GoogleFonts.leagueSpartan(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    children: [
                                      Container(
                                        constraints: BoxConstraints(
                                          maxHeight:
                                              200, // Batas tinggi dropdown
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: Colors.grey
                                              .withValues(alpha: 0.1),
                                        ),
                                        child: Scrollbar(
                                          child: SingleChildScrollView(
                                            child: Column(
                                              children: paymentType.channels
                                                  .map((channelCode) {
                                                return ListTile(
                                                  tileColor: Colors.transparent,
                                                  title: Text(
                                                    channelCode.label,
                                                    style: GoogleFonts
                                                        .leagueSpartan(
                                                      fontSize: 16,
                                                      color: controller
                                                                  .selectedChannelCode
                                                                  .value ==
                                                              channelCode.value
                                                          ? Colors.white
                                                          : Colors.white
                                                              .withValues(
                                                                  alpha: 0.8),
                                                      fontWeight: controller
                                                                  .selectedChannelCode
                                                                  .value ==
                                                              channelCode.value
                                                          ? FontWeight.bold
                                                          : FontWeight.normal,
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    controller
                                                            .selectedPaymentType
                                                            .value =
                                                        paymentType.value;
                                                    controller
                                                            .selectedChannelCode
                                                            .value =
                                                        channelCode.value;
                                                    Get.snackbar('Berhasil',
                                                        'Metode pembayaran dipilih: ${channelCode.label}',
                                                        isDismissible: true,
                                                        duration:
                                                            const Duration(
                                                                seconds: 1));
                                                  },
                                                  contentPadding:
                                                      const EdgeInsets
                                                          .symmetric(
                                                    horizontal: 16,
                                                    vertical: 8,
                                                  ),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  selected: controller
                                                          .selectedChannelCode
                                                          .value ==
                                                      channelCode.value,
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
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.grey.withValues(alpha: 0.4),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Rincian Pembelian',
                          style: GoogleFonts.leagueSpartan(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
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
                                color: Colors.white.withValues(alpha: 0.8),
                              ),
                            ),
                            Text(
                              'Rp 29.900,00',
                              style: GoogleFonts.leagueSpartan(
                                fontSize: 16,
                                color: Colors.white,
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
                                color: Colors.white.withValues(alpha: 0.8),
                              ),
                            ),
                            Text(
                              'Rp 0,00',
                              style: GoogleFonts.leagueSpartan(
                                fontSize: 16,
                                color: Colors.white,
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
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'Rp 29.900,00',
                              style: GoogleFonts.leagueSpartan(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
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
        ],
      ),
    );
  }
}
