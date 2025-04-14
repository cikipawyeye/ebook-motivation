import 'package:ebookapp/app/modules/pengingat/controllers/pengingat_category_drop.dart';
import 'package:ebookapp/app/modules/pengingat/controllers/pengingat_controller_drop.dart';
import 'package:ebookapp/app/modules/settings/controllers/setting_theme_controller.dart';
import 'package:ebookapp/app/modules/settings/controllers/user_controller.dart';
import 'package:get/get.dart';


class PengingatBinding extends Bindings {  
  @override  
  void dependencies() {  
    Get.lazyPut<PengingatControllerDrop>(  
      () => PengingatControllerDrop(),  
    );  
    Get.lazyPut<PengingatIdControllerDrop>(  
      () => PengingatIdControllerDrop(),  
    );  
    Get.lazyPut<ThemeController>(
      () => ThemeController(),
    );
    Get.lazyPut<UserController>(
      () => UserController(),
    );
  }  
}  
