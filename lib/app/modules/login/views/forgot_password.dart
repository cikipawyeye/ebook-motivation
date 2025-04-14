import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ebookapp/app/modules/login/controllers/login_controller.dart';

class ForgotPassword extends GetView<LoginController> {
  ForgotPassword({super.key});

  final TextEditingController emailC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Menambahkan latar belakang putih
      body: Container(
        padding: EdgeInsets.all(20.w), // Padding responsif
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/Watermark.png'),
            fit: BoxFit.cover, // Mengatur gambar agar menutupi seluruh area
          ),
        ),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 50),
                // Judul
                Padding(
                  padding: EdgeInsets.only(bottom: 20.h, top: 50.h),
                  child: Text(
                    'Lupa kata Sandi',
                    style: GoogleFonts.leagueSpartan(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                // Deskripsi
                Padding(
                  padding: EdgeInsets.only(bottom: 30.h),
                  child: Text(
                    'Masukkan email yang terdaftar untuk melakukan reset kata sandi.',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.black54,
                    ),
                  ),
                ),
                // Email Input
                TextField(
                  controller: emailC,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.r),
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(height: 250.h), // Mengurangi jarak agar tombol mendekat
                // Tombol Selanjutnya
                ElevatedButton(
                  onPressed: () async {
                    String email = emailC.text.trim();
                    if (email.isNotEmpty) {
                      print(
                          'Mengirim permintaan reset kata sandi ke: $email'); // Debug
                      Get.snackbar('Info',
                          'Mengirim email untuk reset kata sandi...'); // Informasi

                      bool success = await controller.forgotPassword(email);
                      if (success) {
                        print(
                            'Email untuk reset kata sandi berhasil dikirim'); // Debug
                        Get.toNamed('/success-forgot');
                      } else {
                        print(
                            'Gagal mengirim email untuk reset kata sandi'); // Debug
                        Get.snackbar('Gagal',
                            'Gagal mengirim email, silakan coba lagi.');
                      }
                    } else {
                      print('Email tidak diisi'); // Debug
                      Get.snackbar(
                          'Gagal', 'Silakan masukkan email terlebih dahulu.');
                    }
                  },
                  child: Text(
                    'Selanjutnya',
                    style: GoogleFonts.leagueSpartan(
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity,
                        50.h), // Mengatur lebar tombol menjadi penuh
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    backgroundColor: Color(0xFF32497B),
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
