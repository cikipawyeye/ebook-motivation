import 'package:get/get.dart';

import '../controllers/motivation_detail_page_controller.dart';

class MotivationDetailPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MotivationDetailPageController>(
      () => MotivationDetailPageController(),
    );
  }
}
