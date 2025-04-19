import 'package:ebookapp/app/modules/motivasi/controllers/audio_controller.dart';
import 'package:ebookapp/app/modules/motivasi/controllers/live_controller.dart';
import 'package:ebookapp/app/modules/settings/controllers/setting_theme_controller.dart';
import 'package:ebookapp/app/modules/settings/controllers/user_controller.dart';
import 'package:ebookapp/app/modules/wallpaper_music/controllers/wallpaper_music_controller.dart';
import 'package:get/get.dart';

import '../controllers/content_controller.dart';

class ContentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ContentController>(
      () => ContentController(),
      fenix: true,
    );
    Get.lazyPut<ThemeController>(
      () => ThemeController(),
      fenix: true,
    );
    Get.lazyPut<UserController>(
      () => UserController(),
      fenix: true,
    );
    Get.lazyPut<AudioController>(
      () => AudioController(),
      fenix: true,
    );
    Get.lazyPut<LiveWallpaperController>(
      () => LiveWallpaperController(),
      fenix: true,
    );
    Get.lazyPut<WallpaperMusicController>(
      () => WallpaperMusicController(),
      fenix: true,
    );
  }
}
