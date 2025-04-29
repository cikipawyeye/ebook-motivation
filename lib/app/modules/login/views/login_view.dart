import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import SharedPreferences
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  LoginView({super.key});

  final TextEditingController emailC = TextEditingController();
  final TextEditingController passC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/Watermark.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            SizedBox(height: 50),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Image.asset(
                  'assets/images/hati.png',
                  width: 120,
                ),
              ),
            ),
            Center(
              child: Text(
                'Sejukkan hatimu\ndengan ayat-ayat Al-Qur\'an',
                textAlign: TextAlign.center,
                style: GoogleFonts.leagueSpartan(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 40),

            // Input Email
            Text(
              'Email',
              style: GoogleFonts.leagueSpartan(
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),
            SizedBox(height: 5),
            Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    autocorrect: false,
                    controller: emailC,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      controller.resetErrorState();
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 18),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      labelText: 'Email',
                      labelStyle: TextStyle(
                          fontSize: 12,
                          color: Colors.black.withValues(alpha: 0.3)),
                      errorText: controller.isEmailError.value
                          ? 'Kredensial tidak valid'
                          : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                            color: Colors.black.withValues(alpha: 0.3),
                            width: 1),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),

            // Input Password
            Text(
              'Password',
              style: GoogleFonts.leagueSpartan(
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),
            SizedBox(height: 5),
            Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    autocorrect: false,
                    controller: passC,
                    keyboardType: TextInputType.text,
                    obscureText: controller.isHidden.value,
                    onChanged: (value) {
                      controller.resetErrorState();
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 18),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      labelText: 'Kata sandi',
                      labelStyle: TextStyle(
                          fontSize: 12,
                          color: Colors.black.withValues(alpha: 0.3)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                            color: Colors.black.withValues(alpha: 0.3),
                            width: 1),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          controller.isHidden.value =
                              !controller.isHidden.value;
                        },
                        icon: Icon(controller.isHidden.value
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                    ),
                  ),
                  if (controller.isPasswordError.value)
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(
                        controller.errorMessage.value,
                        style: TextStyle(color: Colors.red, fontSize: 12),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 40),

            // Login Button
            ElevatedButton(
              onPressed: () async {
                // Update controller values
                controller.emailController.text = emailC.text;
                controller.passController.text = passC.text;

                // Authenticate user
                bool success = await controller.loginWithEmail();
                if (success) {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  // Cek apakah ini adalah pengguna baru
                  bool isNewUser = prefs.getBool('isNewUser') ?? true;

                  if (isNewUser) {
                    // Jika pengguna baru, arahkan ke wallpaper-music
                    Get.offNamed('/wallpaper-music');
                    // Set status pengguna baru menjadi false
                    prefs.setBool('isNewUser', false);
                  } else {
                    // Jika bukan pengguna baru, arahkan ke halaman utama
                    Get.offNamed('/home');
                  }
                } else {
                  controller.setErrorState();
                }
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                backgroundColor: Color(0xFF32497B),
              ),
              child: Text(
                'Masuk',
                style: GoogleFonts.leagueSpartan(
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50),

            // Link Lupa Kata Sandi
            TextButton(
              onPressed: () {
                Get.toNamed('/forgot-password');
              },
              child: Text(
                'Lupa kata sandi?',
                style: GoogleFonts.leagueSpartan(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),

            // Link Daftar
            Center(
              child: TextButton(
                onPressed: () {
                  Get.toNamed('/register');
                },
                child: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: 'Belum punya akun? ',
                      style: GoogleFonts.leagueSpartan(color: Colors.black87),
                    ),
                    TextSpan(
                      text: 'Daftar sekarang',
                      style: GoogleFonts.leagueSpartan(color: Colors.blue),
                    ),
                  ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
