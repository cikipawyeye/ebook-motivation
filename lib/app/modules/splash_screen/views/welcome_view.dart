import 'package:ebookapp/app/modules/splash_screen/controllers/background_audio_controller.dart';
import 'package:ebookapp/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeView extends GetView {
  const WelcomeView({super.key});

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
            padding: EdgeInsets.all(36),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Assalamualaikum...\nSelamat datang di aplikasi ini.",
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
                ElevatedButton(
                  onPressed: () {
                    Get.offNamed(Routes.register);
                    audioCtrl.pause();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white.withValues(alpha: 0.3),
                  ),
                  child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 26),
                      child: Text(
                        "Sebelum memulai, kita kenalan dulu yuk...",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.leagueSpartan(
                          fontSize: 17,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
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
