import 'package:ebookapp/app/modules/account_upgrade/controllers/account_status_controller.dart';
import 'package:ebookapp/app/modules/settings/controllers/setting_theme_controller.dart';
import 'package:get/get.dart';

class AccountStatusBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ThemeController>(
      () => ThemeController(),
    );
    Get.lazyPut<AccountStatusController>(
      () => AccountStatusController(),
    );
  }
}
