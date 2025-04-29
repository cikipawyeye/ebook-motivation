import 'package:ebookapp/app/modules/account_upgrade/controllers/create_payment_controller.dart';
import 'package:ebookapp/app/modules/settings/controllers/setting_theme_controller.dart';
import 'package:get/get.dart';

class CreatePaymentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ThemeController>(
      () => ThemeController(),
    );
    Get.lazyPut<CreatePaymentController>(
      () => CreatePaymentController(),
    );
  }
}
