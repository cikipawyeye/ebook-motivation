import 'package:ebookapp/app/routes/app_pages.dart';
import 'package:ebookapp/core/constants/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/ticket_premium_controller.dart';

class TicketPremiumView extends GetView<TicketPremiumController> {
  const TicketPremiumView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/hati.png',
                width: 92,
                height: 92,
              ),
              const SizedBox(height: 16),
              Text(
                'Premium',
                style: GoogleFonts.leagueSpartan(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: colorBackground,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Yahh, scroll gratismu sudah habis!\nWaktunya untuk tingkatkan ke premium!',
                textAlign: TextAlign.center,
                style: GoogleFonts.leagueSpartan(fontSize: 20),
              ),
              const SizedBox(height: 32),
              Card(
                color: Colors.white,
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Premium',
                        style: GoogleFonts.leagueSpartan(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: colorBackground,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Nikmati fitur baca tanpa batas',
                        style: GoogleFonts.leagueSpartan(
                            fontSize: 35, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '• Semua halaman terbuka',
                        style: GoogleFonts.leagueSpartan(
                            fontSize: 14, fontWeight: FontWeight.w300),
                      ),
                      const SizedBox(height: 16),
                      // Mengatur RichText ke kanan
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                text: 'Hanya ',
                                style: GoogleFonts.leagueSpartan(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                              ),
                              TextSpan(
                                text: 'Rp29.900 ',
                                style: GoogleFonts.leagueSpartan(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              ),
                              TextSpan(
                                text: 'untuk selamanya!',
                                style: GoogleFonts.leagueSpartan(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                              ),
                            ]),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32), // Mengurangi jarak untuk responsif
              Text(
                'Belum tertarik?',
                textAlign: TextAlign.center,
                style: GoogleFonts.leagueSpartan(
                  fontSize: 15,
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Menunda navigasi hingga fase build selesai
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Get.toNamed(Routes.home); // Navigasi ke halaman home
                  });
                },
                child: Text(
                  'Kembali ke halaman sebelumnya',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.leagueSpartan(),
                ),
              ),
              const SizedBox(height: 16),
              // Button yang dinamis
              Container(
                width:
                    MediaQuery.of(context).size.width * 0.9, // 90% lebar layar
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Get.toNamed(Routes.paymentDetail);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 12),
                    backgroundColor: const Color(0xFF4AB57A),
                  ),
                  child: Text(
                    'Tingkatkan sekarang!',
                    style: GoogleFonts.leagueSpartan(
                        fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
