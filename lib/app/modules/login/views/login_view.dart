// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts package
// import '../controllers/login_controller.dart';

// class LoginView extends GetView<LoginController> {
//   LoginView({super.key});

//   final TextEditingController emailC = TextEditingController();
//   final TextEditingController passC = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white, // Menambahkan latar belakang putih
//       body: Container(
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage('assets/images/Watermark.png'),
//             fit: BoxFit.cover, // Mengatur gambar agar menutupi seluruh area
//           ),
//         ),
//         child: ListView(
//           padding: const EdgeInsets.all(20),
//           children: [
//             SizedBox(height: 100,),
//             // Logo
//             Center(
//               child: Padding(
//                 padding: const EdgeInsets.only(bottom: 20),
//                 child: Image.asset(
//                     'assets/images/hati.png'), // Ganti dengan asset logo yang sesuai
//               ),
//             ),
//             // Judul
//             Center(
//               child: Text(
//                 'Sejukkan hatimu dengan ayat-ayat Al-Qur\'an',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w500,
//                   color: Colors.black,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 40),

//             // Email Input with border and label inside
//             Obx(
//               () => Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   TextField(
//                     autocorrect: false,
//                     controller: emailC,
//                     keyboardType: TextInputType.emailAddress,
//                     onChanged: (value) {
//                       controller
//                           .resetErrorState(); // Reset error state saat mengetik
//                     },
//                     decoration: InputDecoration(
//                       labelText: 'Email',
//                       labelStyle: TextStyle(color: Colors.grey),
//                       filled: true,
//                       fillColor: Colors.white,
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(20),
//                         borderSide: BorderSide(
//                           color: controller.isEmailError.value
//                               ? Colors.red.withOpacity(0.5) // Merah transparan
//                               : Colors.grey,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 20),

//             // Password Input with border and label inside
//             Obx(
//               () => Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   TextField(
//                     autocorrect: false,
//                     controller: passC,
//                     keyboardType: TextInputType.text,
//                     obscureText: controller.isHidden.value,
//                     onChanged: (value) {
//                       controller
//                           .resetErrorState(); // Reset error state saat mengetik
//                     },
//                     decoration: InputDecoration(
//                       labelText: 'Kata sandi',
//                       labelStyle: TextStyle(color: Colors.grey),
//                       filled: true,
//                       fillColor: Colors.white,
//                       suffixIcon: IconButton(
//                         onPressed: () {
//                           controller.isHidden.value =
//                               !controller.isHidden.value;
//                         },
//                         icon: Icon(controller.isHidden.value
//                             ? Icons.visibility
//                             : Icons.visibility_off),
//                       ),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(20),
//                         borderSide: BorderSide(
//                           color: controller.isPasswordError.value
//                               ? Colors.red.withOpacity(0.5) // Merah transparan
//                               : Colors.grey,
//                         ),
//                       ),
//                     ),
//                   ),
//                   if (controller.isPasswordError.value)
//                     Padding(
//                       padding: const EdgeInsets.only(top: 5),
//                       child: Text(
//                         controller.errorMessage.value,
//                         style: TextStyle(color: Colors.red, fontSize: 12),
//                       ),
//                     ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 20),

//             // Login Button
//             ElevatedButton(
//               onPressed: () async {
//                 controller.emailController.text = emailC.text;
//                 controller.passController.text = passC.text;
//                 bool success = await controller.loginWithEmail();
//                 if (!success) {
//                   controller
//                       .setErrorState(); // Set error state jika login gagal
//                 }
//               },
//               child: Text(
//                 'Masuk',
//                 style: GoogleFonts.leagueSpartan(
//                   textStyle: TextStyle(
//                     color: Colors.white,
//                     fontSize: 16,
//                   ),
//                 ),
//               ),
//               style: ElevatedButton.styleFrom(
//                 padding: EdgeInsets.symmetric(vertical: 15),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 backgroundColor: Color(0xFF32497B),
//               ),
//             ),
//             const SizedBox(height: 90),

//             // Forgot Password
//             TextButton(
//               onPressed: () {
//                 Get.toNamed('/forgot-password');
//               },
//               child: Text(
//                 'Lupa kata sandi?',
//                 style: GoogleFonts.leagueSpartan(color: Colors.black),
//               ),
//             ),

//             // Register Button
//             Center(
//               child: TextButton(
//                 onPressed: () {
//                   Get.toNamed('/register');
//                 },
//                 child: RichText(
//                     text: TextSpan(children: [
//                   TextSpan(
//                     text: 'Belum punya akun? ',
//                     style: GoogleFonts.leagueSpartan(color: Colors.black87),
//                   ),
//                   TextSpan(
//                       text: 'Daftar sekarang',
//                       style: GoogleFonts.leagueSpartan(color: Colors.blue))
//                 ])),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

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
            SizedBox(height: 100),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Image.asset('assets/images/hati.png'),
              ),
            ),
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

            // Input Email
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
                      labelText: 'Email',
                      labelStyle: TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: controller.isEmailError.value
                              ? Colors.red.withOpacity(0.5)
                              : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Input Password
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
                      labelText: 'Kata sandi',
                      labelStyle: TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: Colors.white,
                      suffixIcon: IconButton(
                        onPressed: () {
                          controller.isHidden.value =
                              !controller.isHidden.value;
                        },
                        icon: Icon(controller.isHidden.value
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: controller.isPasswordError.value
                              ? Colors.red.withOpacity(0.5)
                              : Colors.grey,
                        ),
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
            const SizedBox(height: 20),

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
              child: Text(
                'Masuk',
                style: GoogleFonts.leagueSpartan(
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                backgroundColor: Color(0xFF32497B),
              ),
            ),
            const SizedBox(height: 90),

            // Link Lupa Kata Sandi
            TextButton(
              onPressed: () {
                Get.toNamed('/forgot-password');
              },
              child: Text(
                'Lupa kata sandi?',
                style: GoogleFonts.leagueSpartan(color: Colors.black),
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
