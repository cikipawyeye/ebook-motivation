import 'package:ebookapp/app/modules/account_upgrade/widgets/qr_code_payment.dart';
import 'package:ebookapp/app/modules/account_upgrade/widgets/virtual_account_payment.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:ebookapp/app/modules/account_upgrade/controllers/payment_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentDetailView extends GetView<PaymentDetailController> {
  const PaymentDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    // Terima argument
    final arguments = Get.arguments as Map<String, dynamic>?;
    final paymentId = arguments?['paymentId'] as int?;

    initializeDateFormatting('id_ID', null);

    // Panggil fetchPaymentInfo untuk mengambil data pembayaran
    if (paymentId != null) {
      controller.fetchPaymentInfo(paymentId);
    }

    return Obx(
      () => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'Pembayaran',
            style: GoogleFonts.leagueSpartan(
                color: Colors.white, fontWeight: FontWeight.w500),
          ),
          backgroundColor: const Color(0xFF32497B),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Get.back(),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/Template.png'),
              fit: BoxFit.cover, // Mengatur gambar agar menutupi seluruh area
            ),
          ),
          child: Center(
            child: controller.isLoading.value
                ? CircularProgressIndicator()
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Rincian Pembelian
                          SizedBox(
                            child: Card(
                              color: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                                side: BorderSide(
                                  color: Colors.grey.withValues(alpha: 0.4),
                                ),
                              ),
                              elevation: 0,
                              child: Padding(
                                  padding: const EdgeInsets.all(18),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.paid,
                                            color: Colors.white,
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            'Rincian Pembelian',
                                            style: GoogleFonts.leagueSpartan(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 16),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '1x Premium App',
                                            style: GoogleFonts.leagueSpartan(
                                              fontSize: 16,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            'Rp 29.000,00',
                                            style: GoogleFonts.leagueSpartan(
                                              fontSize: 16,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Biaya Admin',
                                            style: GoogleFonts.leagueSpartan(
                                              color: Colors.white,
                                              fontSize: 16,
                                            ),
                                          ),
                                          Text(
                                            'Rp 0,00',
                                            style: GoogleFonts.leagueSpartan(
                                              color: Colors.white,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 16),
                                      const Divider(),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Total',
                                            style: GoogleFonts.leagueSpartan(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            'Rp 29.000,00',
                                            style: GoogleFonts.leagueSpartan(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                            ),
                          ),
                          const SizedBox(height: 14), // Margin antar card

                          // Bayar Dalam Card
                          if (controller.expiresAt.value != null)
                            SizedBox(
                              child: Card(
                                color: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  side: BorderSide(
                                    color: Colors.grey.withValues(alpha: 0.4),
                                  ),
                                ),
                                elevation: 0,
                                child: Padding(
                                    padding: const EdgeInsets.all(18),
                                    child: Column(
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Bayar Dalam',
                                              style: GoogleFonts.leagueSpartan(
                                                fontSize: 16,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Obx(() {
                                              final Duration? remaining =
                                                  controller.countdown.value;
                                              final String hours = remaining
                                                      ?.inHours
                                                      .toString()
                                                      .padLeft(2, '0') ??
                                                  '0';
                                              final String minutes =
                                                  ((remaining?.inMinutes ??
                                                              60) %
                                                          60)
                                                      .toString()
                                                      .padLeft(2, '0');
                                              final String seconds =
                                                  ((remaining?.inSeconds ??
                                                              60) %
                                                          60)
                                                      .toString()
                                                      .padLeft(2, '0');
                                              return Text(
                                                '$hours jam $minutes menit $seconds detik',
                                                style:
                                                    GoogleFonts.leagueSpartan(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                  color: Colors.white,
                                                ),
                                              );
                                            }),
                                          ],
                                        ),
                                        SizedBox(height: 8),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: <Widget>[
                                            Text(
                                              'Jatuh tempo ${controller.expiresAt.value != null ? DateFormat("dd MMM yyyy, HH:mm", "id_ID").format(controller.expiresAt.value!.toLocal()) : "-"}',
                                              style: GoogleFonts.leagueSpartan(
                                                fontSize: 14,
                                                color: Colors.white
                                                    .withValues(alpha: 0.8),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    )),
                              ),
                            ),
                          if (controller.expiresAt.value != null)
                            const SizedBox(height: 14), // Margin antar card

                          // Virtual Account Card
                          if (controller.virtualAccount.value != null)
                            VirtualAccountPayment(
                              va: controller.virtualAccount.value!,
                            ),
                          if (controller.qrCode.value != null)
                            QRCodePayment(
                              qrCode: controller.qrCode.value!,
                            ),
                          const SizedBox(height: 14), // Margin antar card

                          // Petunjuk Pembayaran Dropdown
                          SizedBox(
                            child: Card(
                              color: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                                side: BorderSide(
                                  color: Colors.grey.withValues(alpha: 0.4),
                                ),
                              ),
                              elevation: 0,
                              child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 18),
                                  child: ExpansionTile(
                                    tilePadding: const EdgeInsets.all(0),
                                    title: Text(
                                      'Petunjuk Pembayaran',
                                      style: GoogleFonts.leagueSpartan(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    trailing: Obx(() => Icon(
                                          controller.isExpanded.value
                                              ? Icons.arrow_drop_up
                                              : Icons.arrow_drop_down,
                                          color: Colors.white,
                                        )),
                                    onExpansionChanged: (expanded) {
                                      controller.isExpanded.value = expanded;
                                    },
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 16.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: controller
                                                  .getPaymentInstructions()
                                                  ?.expand((instruction) {
                                                return [
                                                  // Title
                                                  if (instruction.title != null)
                                                    Text(
                                                      instruction.title!,
                                                      style: GoogleFonts
                                                          .leagueSpartan(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  const SizedBox(height: 8),
                                                  // Instruction list
                                                  ...?instruction.instruction
                                                      ?.map((text) => Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                text,
                                                                style: GoogleFonts
                                                                    .leagueSpartan(
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                  height: 8),
                                                            ],
                                                          )),
                                                  const SizedBox(height: 16),
                                                ];
                                              }).toList() ??
                                              [
                                                Center(
                                                    child:
                                                        CircularProgressIndicator())
                                              ],
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                          ),
                          const SizedBox(height: 20), // Margin antar card

                          // Tombol Konfirmasi Pembayaran
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    controller.refreshPayment(paymentId!);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color(0xFF32497B), // Warna tombol
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 44,
                                      vertical: 12,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                  child: Text(
                                    'Cek Status Pembayaran',
                                    style: GoogleFonts.leagueSpartan(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                              height: 10), // Tambahkan padding di bawah tombol
                        ],
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
