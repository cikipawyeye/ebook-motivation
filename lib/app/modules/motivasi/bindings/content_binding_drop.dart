import 'package:ebookapp/app/modules/motivasi/controllers/content_controller_drop.dart';
import 'package:ebookapp/app/modules/motivasi/controllers/motivasi_controller_drop.dart';
import 'package:ebookapp/app/modules/settings/controllers/setting_theme_controller.dart';
import 'package:ebookapp/app/modules/settings/controllers/user_controller.dart';
import 'package:get/get.dart';


class ContentBindingDrop extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ContentControllerDrop>(
      () => ContentControllerDrop(),
    );
    Get.lazyPut<MotivasiControllerDrop>(
      () => MotivasiControllerDrop(),
    );
    Get.lazyPut<ThemeController>(
      () => ThemeController(),
    );
    Get.lazyPut<UserController>(
      () => UserController(),
    );
  }
}