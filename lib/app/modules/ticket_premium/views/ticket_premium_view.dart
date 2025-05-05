import 'package:ebookapp/app/routes/app_pages.dart';
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
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/Template.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
              child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logo_white.png',
                    width: 80,
                    height: 80,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Premium',
                    style: GoogleFonts.leagueSpartan(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Yahh, scroll gratisnya sudah habis…\nYuk, tingkatkan ke premium!',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.leagueSpartan(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Card(
                    color: Colors.transparent,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(
                        color: Colors.white.withValues(alpha: 0.5),
                        width: 1,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset(
                                'assets/images/hati_edge.png',
                                height: 30,
                                width: 30,
                              ),
                              const SizedBox(width: 12),
                              Text(
                                'Premium',
                                style: GoogleFonts.leagueSpartan(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Nikmati fitur baca tanpa batas',
                            style: GoogleFonts.leagueSpartan(
                                fontSize: 35,
                                color: Colors.white,
                                height: 1,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '• Semua halaman terbuka',
                            style: GoogleFonts.leagueSpartan(
                                fontSize: 14,
                                color: Colors.white.withValues(alpha: 0.8),
                                fontWeight: FontWeight.w300),
                          ),
                          const SizedBox(height: 25),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                    text: 'Hanya ',
                                    style: GoogleFonts.leagueSpartan(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  ),
                                  TextSpan(
                                    text: 'Rp29.900 ',
                                    style: GoogleFonts.leagueSpartan(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text: 'untuk selamanya!',
                                    style: GoogleFonts.leagueSpartan(
                                        color: Colors.white,
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
                  const SizedBox(height: 42),
                  Text(
                    'Belum tertarik?',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.leagueSpartan(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // WidgetsBinding.instance.addPostFrameCallback((_) {
                      //   Get.toNamed(Routes.home);
                      // });

                      Get.offAllNamed(Routes.home);
                    },
                    child: Text(
                      'Kembali ke halaman sebelumnya',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.leagueSpartan(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 26),
                  // Button yang dinamis
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.toNamed(Routes.accountStatus);
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
          ))),
    );
  }
}
