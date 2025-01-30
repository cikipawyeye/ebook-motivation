import 'package:get/get.dart';

import '../controllers/pengingat_controller.dart';

class PengingatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PengingatController>(
      () => PengingatController(),
    );
  }
}
