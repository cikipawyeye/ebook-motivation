import 'dart:async';
import 'package:ebookapp/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ebookapp/app/modules/settings/controllers/payment_detail_controller.dart';

class PaymentPage extends GetView<PaymentController> {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Terima argument
    final arguments = Get.arguments as Map<String, dynamic>?;
    final paymentId = arguments?['paymentId'] as int?;

    // Panggil fetchPaymentInfo untuk mengambil data pembayaran
    if (paymentId != null) {
      controller.fetchPaymentInfo(paymentId);
    }

    // Panggil loadSavedData untuk mengambil data dari SharedPreferences
    controller.loadSavedData();

    // Hitung waktu countdown
    final DateTime now = DateTime.now();
    final DateTime targetTime = now.add(const Duration(days: 1));
    final Duration remainingTime = targetTime.difference(now);

    // Gunakan Rx untuk menyimpan waktu countdown
    final Rx<Duration> countdown = remainingTime.obs;

    // Timer untuk memperbarui countdown setiap detik
    Timer.periodic(const Duration(seconds: 1), (timer) {
      final Duration newRemainingTime = targetTime.difference(DateTime.now());
      if (newRemainingTime.inSeconds <= 0) {
        timer.cancel(); // Hentikan timer jika waktu habis
      }
      countdown.value = newRemainingTime;
    });

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
              image: AssetImage('assets/images/Watermark.png'),
              fit: BoxFit.cover, // Mengatur gambar agar menutupi seluruh area
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Rincian Pembelian
                  Container(
                    width: 372,
                    height: 206,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withValues(alpha: 0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.receipt, color: Color(0xFF32497B)),
                            const SizedBox(width: 8),
                            Text(
                              'Rincian Pembelian',
                              style: GoogleFonts.leagueSpartan(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '1x Premium App',
                              style: GoogleFonts.leagueSpartan(fontSize: 16),
                            ),
                            Text(
                              'Rp 29.000,00',
                              style: GoogleFonts.leagueSpartan(fontSize: 16),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Biaya Admin',
                              style: GoogleFonts.leagueSpartan(fontSize: 16),
                            ),
                            Text(
                              'Rp 0,00',
                              style: GoogleFonts.leagueSpartan(fontSize: 16),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        const Divider(),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total',
                              style: GoogleFonts.leagueSpartan(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Rp 29.000,00',
                              style: GoogleFonts.leagueSpartan(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14), // Margin antar card

                  // Bayar Dalam Card
                  Container(
                    width: 372,
                    height: 103,
                    child: Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(18),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Bayar Dalam',
                              style: GoogleFonts.leagueSpartan(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Obx(() {
                              final Duration remaining = countdown.value;
                              final String hours =
                                  remaining.inHours.toString().padLeft(2, '0');
                              final String minutes = (remaining.inMinutes % 60)
                                  .toString()
                                  .padLeft(2, '0');
                              final String seconds = (remaining.inSeconds % 60)
                                  .toString()
                                  .padLeft(2, '0');
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '$hours jam $minutes menit $seconds detik',
                                    style:
                                        GoogleFonts.leagueSpartan(fontSize: 16),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    controller.expiresAt.value ?? "",
                                    style:
                                        GoogleFonts.leagueSpartan(fontSize: 16),
                                  ),
                                ],
                              );
                            }),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14), // Margin antar card

                  // Bank BCA Card
                  Container(
                    width: 372,
                    height: 178,
                    child: Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Bank ${controller.channelCode.value ?? ""}',
                              style: GoogleFonts.leagueSpartan(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'No Virtual Account',
                              style: GoogleFonts.leagueSpartan(fontSize: 16),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              width: 330,
                              height: 50,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.grey.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    controller.virtualAccountNumber.value ?? "",
                                    style:
                                        GoogleFonts.leagueSpartan(fontSize: 16),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // Salin nomor virtual account ke clipboard
                                      Clipboard.setData(ClipboardData(
                                          text: controller
                                                  .virtualAccountNumber.value ??
                                              ""));
                                      // Tampilkan snackbar sebagai feedback
                                      Get.snackbar(
                                        'Berhasil',
                                        'Nomor Virtual Account disalin',
                                        snackPosition: SnackPosition.BOTTOM,
                                        duration: const Duration(seconds: 2),
                                      );
                                    },
                                    child: Text(
                                      'Salin',
                                      style: GoogleFonts.leagueSpartan(
                                        fontSize: 16,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14), // Margin antar card

                  // Petunjuk Pembayaran Dropdown
                  Container(
                    width: 372,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withValues(alpha: 0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ExpansionTile(
                      title: Text(
                        'Petunjuk Pembayaran',
                        style: GoogleFonts.leagueSpartan(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: Obx(() => Icon(
                            controller.isExpanded.value
                                ? Icons.arrow_drop_up
                                : Icons.arrow_drop_down,
                            color: Colors.black,
                          )),
                      onExpansionChanged: (expanded) {
                        controller.isExpanded.value = expanded;
                      },
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '1. Pilih m-Transfer > BCA Virtual Account',
                                style: GoogleFonts.leagueSpartan(fontSize: 14),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '2. Masukkan nomor Virtual Account ${controller.virtualAccountNumber.value ?? ""} dan pilih send.',
                                style: GoogleFonts.leagueSpartan(fontSize: 14),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '3. Periksa informasi yang tertera di layar. Pastikan tagihan dan merchant sudah sesuai.',
                                style: GoogleFonts.leagueSpartan(fontSize: 14),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '4. Masukkan pin-BCA anda dan klik OK.',
                                style: GoogleFonts.leagueSpartan(fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 34), // Margin antar card

                  // Tombol Konfirmasi Pembayaran
                  Center(
                    child: Container(
                      width: 400,
                      child: ElevatedButton(
                        onPressed: () {
                          // Cek status pembayaran
                          if (controller.paymentStatus.value == 'PENDING') {
                            Get.snackbar(
                              'Konfirmasi',
                              'Sedang menunggu konfirmasi Pembayaran',
                              snackPosition: SnackPosition.BOTTOM,
                              duration: const Duration(seconds: 2),
                            );
                          } else if (controller.paymentStatus.value ==
                              'SELESAI') {
                            Get.snackbar(
                              'Konfirmasi',
                              'Pembayaran berhasil dikonfirmasi',
                              snackPosition: SnackPosition.BOTTOM,
                              duration: const Duration(seconds: 2),
                            );
                          }

                          // Kembali ke halaman Upgrade Akun setelah snackbar ditampilkan
                          Future.delayed(const Duration(seconds: 2), () {
                            Get.offNamed(Routes
                                .upgradeAccount); // Ganti dengan route yang sesuai
                          });
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
                          'Konfirmasi Pembayaran',
                          style: GoogleFonts.leagueSpartan(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                      height: 20), // Tambahkan padding di bawah tombol
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
