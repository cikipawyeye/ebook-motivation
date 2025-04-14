import 'package:ebookapp/app/modules/motivasi/controllers/audio_controller.dart';
import 'package:ebookapp/app/modules/motivasi/controllers/live_controller.dart';
import 'package:ebookapp/app/modules/motivasi/controllers/motivasi_controller.dart';
import 'package:ebookapp/app/modules/pengingat/controllers/pengingat_category_controller.dart';
import 'package:ebookapp/app/modules/settings/controllers/setting_theme_controller.dart';
import 'package:ebookapp/app/modules/settings/controllers/user_controller.dart';
import 'package:ebookapp/app/modules/wallpaper_music/controllers/wallpaper_music_controller.dart';
import 'package:get/get.dart';

import '../controllers/pengingat_controller.dart';

class PengingatBinding extends Bindings {  
  @override  
  void dependencies() {  
    Get.lazyPut<PengingatController>(  
      () => PengingatController(),  
    );  
    Get.lazyPut<PengingatIdController>(  
      () => PengingatIdController(),  
    );  
    Get.lazyPut<ThemeController>(
      () => ThemeController(),
    );
    Get.lazyPut<UserController>(
      () => UserController(),
    );
    Get.lazyPut<MotivasiController>(
      () => MotivasiController(),
    );
    Get.lazyPut<AudioController>(() => AudioController());
    Get.lazyPut<LiveWallpaperController>(
      () => LiveWallpaperController(),
    );
    Get.lazyPut<WallpaperMusicController>(
      () => WallpaperMusicController(),
    );
  }  
}  
