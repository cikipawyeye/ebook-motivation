import 'package:ebookapp/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  static const Color appBarColor = Color(0xFF32497B);

  // Fungsi untuk styling text
  TextStyle _getTextStyle(
      {double fontSize = 20,
      Color color = Colors.black,
      List<Shadow>? shadows}) {
    return GoogleFonts.leagueSpartan(
      fontSize: fontSize,
      color: color,
      fontWeight: FontWeight.bold,
      shadows: shadows ?? [],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
          style: _getTextStyle(color: Colors.white),
        ),
        backgroundColor: appBarColor,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () {
              // Aksi untuk membuka pengaturan
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        children: [
          // Greeting message
          RichText(
            textAlign: TextAlign.left,
            text: TextSpan(
              text: 'Assalamualaikum, Agil!\n\n',
              style: _getTextStyle(fontSize: 24, color: Colors.black),
              children: <TextSpan>[
                TextSpan(
                  text:
                      'Terima kasih sudah mendaftar kesini.\nOya, buku ini berisi motivasi yang menyejukkan hati, serta pengingat yang berpedoman kepada Al-Qur\'an. Semoga dapat bermanfaat dan menambah semangat dalam kehidupan sehari-hari ya.... Aamiin Ya Robbal Alamin.',
                  style: _getTextStyle(fontSize: 13, color: Colors.black54),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Motivasi Card
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: () {
                // Navigasi ke halaman Motivasi dengan GetX
                Get.toNamed(Routes.motivasi);  // Pastikan menggunakan Routes yang benar
              },
              child: Stack(
                children: [
                  Image.asset(
                    'assets/images/Motivasi1.png',
                    height: 220,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    left: 16,
                    bottom: 16,
                    child: Text(
                      'Motivasi',
                      style: _getTextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            blurRadius: 5.0,
                            color: Colors.black.withOpacity(0.7),
                            offset: const Offset(2, 2),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    right: 16,
                    bottom: 16,
                    child: Text(
                      '>',
                      style: _getTextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Pengingat Card
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: () => Get.toNamed(
                  Routes.pengingat), // Ganti dengan route yang sesuai
              child: Stack(
                children: [
                  Image.asset(
                    'assets/images/Pengingat1.png',
                    height: 220,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    left: 16,
                    bottom: 10,
                    child: Text(
                      'Pengingat',
                      style: _getTextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            blurRadius: 5.0,
                            color: Colors.black.withOpacity(0.7),
                            offset: const Offset(2, 2),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    right: 16,
                    bottom: 16,
                    child: Text(
                      '>',
                      style: _getTextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Premium Button
          Row(
            children: [
              OutlinedButton.icon(
                onPressed: () {
                  // Update the premium status
                },
                icon: Image.asset(
                  'assets/images/crown.png',
                  width: 20,
                  height: 20,
                ),
                label: Text(
                  'Coba Premium!',
                  style: _getTextStyle(
                    fontSize: 16,
                    color: appBarColor,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  side: const BorderSide(color: appBarColor, width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
