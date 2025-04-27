import 'package:ebookapp/app/modules/settings/controllers/setting_theme_controller.dart';
import 'package:ebookapp/app/modules/settings/controllers/user_controller.dart';
import 'package:get/get.dart';

import 'package:ebookapp/app/modules/content/controllers/audio_controller.dart';
import 'package:ebookapp/app/modules/content/controllers/live_controller.dart';
import 'package:ebookapp/app/modules/content/controllers/content_controller.dart';

class ContentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ContentController>(
      () => ContentController(),
    );
    Get.lazyPut<ThemeController>(
      () => ThemeController(),
    );
    Get.lazyPut<AudioController>(
      () => AudioController(),
    );
    Get.lazyPut<UserController>(
      () => UserController(),
    );
    Get.lazyPut<LiveWallpaperController>(
      () => LiveWallpaperController(),
    );
  }
}
