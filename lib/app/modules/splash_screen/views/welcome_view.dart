import 'package:ebookapp/app/modules/splash_screen/controllers/background_audio_controller.dart';
import 'package:ebookapp/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum NextScreen {
  home,
  register,
  login,
}

class WelcomeView extends GetView {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final NextScreen nextScreen = Get.arguments as NextScreen;
    final audioCtrl = Get.find<BackgroundAudioController>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 2), () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();

        String? token = prefs.getString('token');
        if (token != null) {
          Get.offNamed(Routes.home);
          return;
        }

        final nextRoute = nextScreen == NextScreen.register
            ? Routes.register
            : nextScreen == NextScreen.login
                ? Routes.login
                : Routes.home;

        Get.offNamed(nextRoute);
      });

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
            padding: EdgeInsets.all(36),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Assalamualaikum...\nSelamat datang di aplikasi ini!",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.leagueSpartan(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "Aplikasi ini berisi motivasi yang menyejukkan hati, serta pengingat yang berpedoman pada Al-Qur'an. Semoga bermanfaat dan menambah semangat dalam kehidupan sehari-hari ya..., Aamiin Ya Rabbal Alamin.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.leagueSpartan(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  nextScreen == NextScreen.register
                      ? "Sebelum memulai, kita kenalan dulu yuk..."
                      : 'Kita mulai lagi yuk...',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.leagueSpartan(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
                Row(
                  children: [
                    const SizedBox(
                      height: 80,
                    ),
                  ],
                ),
              ],
            ))
      ]),
    );
  }
}
