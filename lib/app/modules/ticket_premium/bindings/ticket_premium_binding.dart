import 'package:get/get.dart';

import '../controllers/ticket_premium_controller.dart';

class TicketPremiumBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TicketPremiumController>(
      () => TicketPremiumController(),
    );
  }
}
