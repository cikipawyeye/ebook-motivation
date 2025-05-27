import 'package:ebookapp/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Gunakan Future.delayed untuk menunda navigasi selama 2 detik
      Future.delayed(const Duration(seconds: 2), () {
        _redirect();
      });
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

  Future<void> _redirect() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString('token');
    if (token != null) {
      Get.offNamed(Routes.home);
      return;
    }

    bool? hasAccount = prefs.getBool('hasAccount') ?? false;

    if (hasAccount) {
      Get.offNamed(Routes.login);
    } else {
      Get.offNamed(Routes.welcomeSplash);
    }
  }
}
