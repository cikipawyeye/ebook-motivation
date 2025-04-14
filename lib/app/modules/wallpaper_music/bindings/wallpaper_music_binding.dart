import 'package:get/get.dart';

import '../controllers/wallpaper_music_controller.dart';

class WallpaperMusicBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WallpaperMusicController>(
      () => WallpaperMusicController(),
    );
  }
}
