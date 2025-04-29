import 'package:ebookapp/app/modules/account_upgrade/controllers/payment_detail_controller.dart';
import 'package:get/get.dart';

class PaymentDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentDetailController>(
      () => PaymentDetailController(),
    );
  }
}
