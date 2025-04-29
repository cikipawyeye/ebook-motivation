import 'package:ebookapp/app/modules/account_upgrade/models/account_status/account_status.dart';
import 'package:ebookapp/app/modules/account_upgrade/controllers/account_status_controller.dart';
import 'package:ebookapp/app/modules/settings/controllers/setting_theme_controller.dart';
import 'package:ebookapp/app/routes/app_pages.dart';
import 'package:ebookapp/core/constants/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AccountStatusView extends GetView<AccountStatusController> {
  const AccountStatusView({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();
    final AccountStatusController controller =
        Get.find<AccountStatusController>();

    return Obx(
      () => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'Coba Premium',
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
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Obx(() {
              if (controller.checkingAccountStatus.value) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              // Cek apakah user sudah premium
              if (controller.accountStatus.value != null &&
                  controller.accountStatus.value!.status ==
                      AccountUpgradeStatus.premium) {
                return Column(
                  children: [
                    SizedBox(
                      child: Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(
                            color: Colors.grey.withValues(alpha: 0.4),
                          ),
                        ),
                        elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    'assets/images/hati_edge.png',
                                    height: 30,
                                    width: 30,
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    'Premium',
                                    style: GoogleFonts.leagueSpartan(
                                        fontSize: 14,
                                        color: colorBackground,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              Text(
                                'Akun Anda sudah \nPremium',
                                style: GoogleFonts.leagueSpartan(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  height: 0.95,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Selamat menikmati fitur tanpa batas!',
                                style: GoogleFonts.leagueSpartan(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 8),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                );
              }

              // Non Premium User
              return Column(
                children: [
                  SizedBox(
                    child: Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(
                          color: Colors.grey.withValues(alpha: 0.4),
                        ),
                      ),
                      elevation: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image.asset(
                                  'assets/images/hati_edge.png',
                                  height: 30,
                                  width: 30,
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  'Premium',
                                  style: GoogleFonts.leagueSpartan(
                                      fontSize: 14,
                                      color: colorBackground,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(height: 25),
                            Text(
                              'Nikmati fitur baca\ntanpa batas',
                              style: GoogleFonts.leagueSpartan(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  height: 0.95),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Hanya Rp29.900 untuk selamanya!',
                              style: GoogleFonts.leagueSpartan(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              '• Semua halaman terbuka',
                              style: GoogleFonts.leagueSpartan(
                                fontSize: 16,
                                color: Colors.black54,
                              ),
                            ),
                            Text(
                              '• Tidak ada iklan',
                              style: GoogleFonts.leagueSpartan(
                                fontSize: 16,
                                color: Colors.black54,
                              ),
                            ),
                            const SizedBox(height: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Obx(() {
                                  if (controller.accountStatus.value == null ||
                                      controller.accountStatus.value!.status ==
                                          AccountUpgradeStatus.notPremium) {
                                    return ElevatedButton(
                                      onPressed: () {
                                        Get.toNamed(Routes.createPayment);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 30, vertical: 8),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                      ),
                                      child: Text(
                                        'Dapatkan Sekarang!',
                                        style: GoogleFonts.leagueSpartan(
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                    );
                                  }

                                  return ElevatedButton(
                                    onPressed: () {
                                      Get.offNamed(Routes.paymentInfo,
                                          arguments: {
                                            'paymentId': controller
                                                .accountStatus
                                                .value!
                                                .payment!
                                                .id,
                                          });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFFE2E2E2),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30, vertical: 8),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                    child: Text(
                                      'Lihat status pembayaran',
                                      style: GoogleFonts.leagueSpartan(
                                        fontSize: 16,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  );
                                })
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
