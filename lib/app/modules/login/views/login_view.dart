import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts package
import '../controllers/login_controller.dart';
import 'package:flutter/foundation.dart';

class LoginView extends GetView<LoginController> {
  LoginView({super.key});

  final TextEditingController emailC = TextEditingController();
  final TextEditingController passC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      emailC.text = 'user@example.com';
      passC.text = 'password';
    }

    return Scaffold(
      backgroundColor: Colors.white, // Menambahkan latar belakang putih
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Logo
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Image.asset(
                  'assets/images/hati.png'), // Ganti dengan asset logo yang sesuai
            ),
          ),
          // Judul
          Center(
            child: Text(
              'Sejukkan hatimu dengan ayat-ayat Al-Qur\'an',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 40),

          // Email Input with border and label inside
          TextField(
            autocorrect: false,
            controller: emailC,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'Email', // Menampilkan teks label di dalam border
              labelStyle: TextStyle(color: Colors.grey),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide:
                    BorderSide(color: Colors.grey), // Border berwarna abu-abu
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Password Input with border and label inside
          Obx(
            () => TextField(
              autocorrect: false,
              controller: passC,
              keyboardType: TextInputType.text,
              obscureText: controller.isHidden.value,
              decoration: InputDecoration(
                labelText:
                    'Kata sandi', // Menampilkan teks label di dalam border
                labelStyle: TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.white,
                suffixIcon: IconButton(
                  onPressed: () {
                    controller.isHidden.value = !controller.isHidden.value;
                  },
                  icon: Icon(controller.isHidden.value
                      ? Icons.visibility
                      : Icons.visibility_off),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide:
                      BorderSide(color: Colors.grey), // Border berwarna abu-abu
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Login Button with #32497B color and white text using League Spartan font
          ElevatedButton(
            onPressed: () async {
              controller.emailController.text = emailC.text;
              controller.passController.text = passC.text;
              await controller.loginWithEmail();
            },
            child: Text(
              'Masuk',
              style: GoogleFonts.leagueSpartan(
                textStyle: TextStyle(
                  color: Colors.white, // Text color white
                  fontSize: 16, // You can adjust the font size
                ),
              ),
            ),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              backgroundColor: Color(0xFF32497B), // Menggunakan warna #32497B
            ),
          ),
          const SizedBox(
              height:
                  40), // Menambah jarak lebih besar antara login dan link lainnya

          // Forgot Password moved to the bottom
          TextButton(
            onPressed: () {
              // Tindakan jika lupa password
            },
            child: Text('Lupa kata sandi?'),
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              foregroundColor: Colors.blue,
            ),
          ),

          // Register Button moved to the bottom
          const SizedBox(
              height:
                  10), // Menambah jarak antara lupa kata sandi dan pendaftaran
          Center(
            child: TextButton(
              onPressed: () {
                // Navigasi ke RegisterView ketika menekan "Belum punya akun? Daftar sekarang"
                Get.toNamed(
                    '/register'); // Pastikan route '/register' diarahkan ke RegisterView
              },
              child: Text(
                'Belum punya akun? Daftar sekarang',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
