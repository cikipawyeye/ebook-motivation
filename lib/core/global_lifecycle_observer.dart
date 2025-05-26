import 'package:ebookapp/app/modules/content/controllers/audio_controller.dart';
import 'package:ebookapp/app/modules/splash_screen/controllers/background_audio_controller.dart';
import 'package:ebookapp/app/modules/wallpaper_music/controllers/wallpaper_music_controller.dart';
import 'package:ebookapp/app/routes/app_pages.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class GlobalLifecycleObserver extends WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        if (Get.currentRoute == Routes.contents) {
          (Get.find<AudioController>()).pauseByApp();
          return;
        }

        if (Get.currentRoute == Routes.wallpaperMusic) {
          (Get.find<WallpaperMusicController>()).pauseAudio();
          return;
        }

        (Get.find<BackgroundAudioController>()).pause();
        break;
      case AppLifecycleState.resumed:
        if (Get.currentRoute == Routes.contents) {
          final AudioController audioController = Get.find<AudioController>();
          if (audioController.isPlaying.value) {
            audioController.play();
          }
          return;
        }

        if (Get.currentRoute == Routes.wallpaperMusic) {
          return;
        }

        (Get.find<BackgroundAudioController>()).resume();
        break;
      default:
        break;
    }
  }
}
