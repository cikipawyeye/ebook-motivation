import 'package:ebookapp/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    // Gunakan Future.delayed untuk menunda navigasi selama 2 detik
    Future.delayed(const Duration(seconds: 2), () {
      // Navigasi ke halaman berikutnya setelah 2 detik
      Get.offNamed(Routes.login); // Contoh navigasi ke halaman login
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          'assets/images/screen_news.png', // Pastikan path ini benar
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return const Text(
              'Gagal memuat gambar',
              style: TextStyle(color: Colors.red),
            ); // Tampilkan pesan jika gambar gagal dimuat
          },
        ),
      ),
    );
  }
}
