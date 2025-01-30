import 'package:get/get.dart';

import '../controllers/motivasi_controller.dart';

class MotivasiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MotivasiController>(
      () => MotivasiController(),
    );
  }
}
