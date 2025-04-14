import 'package:ebookapp/app/modules/settings/controllers/payment_detail_controller.dart';
import 'package:ebookapp/app/modules/settings/controllers/setting_theme_controller.dart';
import 'package:ebookapp/app/modules/settings/controllers/user_controller.dart';
import 'package:ebookapp/app/routes/app_pages.dart';
import 'package:ebookapp/core/constants/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class UpgradeAccount extends GetView<PaymentController> {
  const UpgradeAccount({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();
    final UserController userController = Get.find<UserController>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Tingkatkan Akun',
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
          child: Column(
            children: [
              Obx(() {
                // Cek apakah user sudah premium
                if (userController.isPremium.value) {
                  return Container(
                    padding: const EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              'assets/images/hati.png',
                              height: 72,
                              width: 72,
                            ),
                            Text(
                              'Premium',
                              style: GoogleFonts.leagueSpartan(
                                  fontSize: 14,
                                  color: colorBackground,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        Text(
                          'Akun Anda sudah \nPremium',
                          style: GoogleFonts.leagueSpartan(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            height: 1.1
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
                      ],
                    ),
                  );
                } else {
                  return Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
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
                              'assets/images/hati.png',
                              width: 52, // Ukuran lebar
                              height: 52, // Ukuran tinggi
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Upgrade to Premium',
                              style: GoogleFonts.leagueSpartan(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Nikmati fitur baca \ntanpa batas',
                          style: GoogleFonts.leagueSpartan(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Hanya Rp49.900 untuk selamanya!',
                          style: GoogleFonts.leagueSpartan(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '• Semua halaman terbuka',
                          style: GoogleFonts.leagueSpartan(
                            fontSize: 16,
                            color: Colors.black54,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: Obx(() {
                            // Gunakan paymentStatus dari controller
                            final paymentStatus = controller.paymentStatus.value;
        
                            // Tentukan teks dan aksi berdasarkan paymentStatus
                            final buttonText = paymentStatus == null
                                ? 'Dapatkan Sekarang!'
                                : paymentStatus == 'PENDING'
                                    ? 'Menunggu Konfirmasi Pembayaran'
                                    : 'Dapatkan Sekarang!';
        
                            final isDisabled = paymentStatus == 'PENDING';
        
                            return ElevatedButton(
                              onPressed: isDisabled
                                  ? null // Nonaktifkan tombol jika status PENDING
                                  : () {
                                      print('Navigating to payment detail...');
                                      Get.toNamed(Routes
                                          .paymentDetail); // Navigasi ke halaman detail pembayaran
                                    },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: isDisabled
                                    ? const Color(
                                        0xFFE2E2E2) // Warna abu-abu untuk PENDING
                                    : Colors
                                        .green, // Warna hijau untuk selain PENDING
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 40,
                                  vertical: 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: Text(
                                buttonText,
                                style: GoogleFonts.leagueSpartan(
                                  fontSize: 16,
                                  color:
                                      isDisabled ? Colors.black54 : Colors.white,
                                ),
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
