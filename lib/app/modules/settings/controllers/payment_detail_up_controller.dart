import 'package:ebookapp/app/modules/settings/controllers/payment_detail_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class PaymentDetailController extends GetxController {
  final PaymentController paymentController = Get.find<PaymentController>();

  final paymentType = 'VIRTUAL_ACCOUNT'.obs;
  final channelCode = 'BCA'.obs;
  final phoneNumber = ''.obs;

  Future<void> processPayment() async {
    if (phoneNumber.value.isEmpty) {
      Get.snackbar('Gagal', 'Nomor telepon harus diisi');
      return;
    }

    // Hapus data pembayaran sebelumnya

    // Mulai proses pembayaran baru
    await paymentController.upgradeAccount(
      paymentType: paymentType.value,
      channelCode: channelCode.value,
      phoneNumber: phoneNumber.value,
    );
  }
}
