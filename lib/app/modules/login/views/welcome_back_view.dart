import 'package:ebookapp/app/modules/splash_screen/controllers/background_audio_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeBackView extends GetView {
  const WelcomeBackView({super.key});

  @override
  Widget build(BuildContext context) {
    final audioCtrl = Get.find<BackgroundAudioController>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      audioCtrl.play();
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(children: [
        Image.asset(
          "assets/images/background.gif",
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
        Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                  ],
                ),
                Text(
                  "Selamat datang!",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  onPressed: () {
                    redirect().then((_) {
                      audioCtrl.pause();
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white.withValues(alpha: 0.3),
                  ),
                  child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 26),
                      child: Text(
                        "Kita mulai yuk...",
                        style: GoogleFonts.leagueSpartan(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                ),
              ],
            ))
      ]),
    );
  }

  Future<void> redirect() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Cek apakah ini adalah pengguna baru
    bool isNewUser = prefs.getBool('isNewUser') ?? true;

    if (isNewUser) {
      // Jika pengguna baru, arahkan ke wallpaper-music
      Get.offAllNamed('/wallpaper-music');
      // Set status pengguna baru menjadi false
      prefs.setBool('isNewUser', false);
    } else {
      // Jika bukan pengguna baru, arahkan ke halaman utama
      Get.offAllNamed('/home');
    }
  }
}
