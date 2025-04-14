import 'package:ebookapp/app/modules/login/controllers/login_controller.dart';
import 'package:ebookapp/app/routes/app_pages.dart';
import 'package:ebookapp/core/constants/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SuccessPassword extends GetView<LoginController> {
  const SuccessPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/Watermark.png'),
            fit: BoxFit.cover, // Mengatur gambar agar menutupi seluruh area
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon check
              Container(
                padding: const EdgeInsets.all(16.0),
                child: Image.asset(
                  'assets/images/shield_check.png',
                  height: 64,
                  width: 64,
                ),
              ),
              const SizedBox(height: 20),
              // Teks "Akun Berhasil Dibuat"
              Text(
                'Email terkirim',
                style: GoogleFonts.leagueSpartan(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              // Teks "Lakukan masuk kembali"
              Text(
                'Cek email terbaru anda untuk melakukan\nreset kata sandi',
                style: GoogleFonts.leagueSpartan(
                  fontSize: 16,
                  color: Colors.black54,
                ), textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              // Tombol "Kembali ke Masuk"
              ElevatedButton(
                onPressed: () {
                  // Navigasi ke halaman login
                  Get.offNamed(Routes.login); // Ganti dengan rute yang sesuai
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      colorBackground, // Warna latar belakang tombol
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'Kembali ke Masuk',
                  style: GoogleFonts.leagueSpartan(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
