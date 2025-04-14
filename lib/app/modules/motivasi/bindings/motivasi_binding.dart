import 'package:ebookapp/app/modules/settings/controllers/setting_theme_controller.dart';
import 'package:get/get.dart';

import '../controllers/motivasi_controller.dart';

class MotivasiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MotivasiController>(
      () => MotivasiController(),
    );
    Get.lazyPut<ThemeController>(
      () => ThemeController(),
    );
  }
}
