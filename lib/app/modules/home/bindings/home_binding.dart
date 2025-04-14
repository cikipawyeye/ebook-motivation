import 'package:ebookapp/app/modules/motivasi/controllers/content_controller.dart';
import 'package:ebookapp/app/modules/motivasi/controllers/motivasi_controller.dart';
import 'package:ebookapp/app/modules/pengingat/controllers/pengingat_category_controller.dart';
import 'package:ebookapp/app/modules/pengingat/controllers/pengingat_controller.dart';
import 'package:ebookapp/app/modules/settings/controllers/payment_detail_controller.dart';
import 'package:ebookapp/app/modules/settings/controllers/setting_theme_controller.dart';
import 'package:ebookapp/app/modules/settings/controllers/user_controller.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<UserController>(
      () => UserController(),
    );
    Get.lazyPut<ThemeController>(
      () => ThemeController(),
    );
    Get.lazyPut<PaymentController>(
      () => PaymentController(),
    );
    Get.lazyPut<ContentController>(
      () => ContentController(),
    );
    Get.lazyPut<MotivasiController>(
      () => MotivasiController(),
    );
    Get.lazyPut<PengingatController>(  
      () => PengingatController(),  
    );  
    Get.lazyPut<PengingatIdController>(  
      () => PengingatIdController(),  
    );  
  }
}
