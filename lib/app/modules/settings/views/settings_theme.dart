import 'package:ebookapp/app/modules/settings/controllers/setting_theme_controller.dart';
import 'package:ebookapp/app/modules/settings/controllers/settings_controller.dart';
import 'package:ebookapp/core/constants/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsTheme extends GetView<SettingsController> {
  const SettingsTheme({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.put(ThemeController());

    return Obx(() => Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(
              'Sunting Tema',
              style: GoogleFonts.leagueSpartan(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 25,
              ),
            ),
            centerTitle: true,
            backgroundColor:
                themeController.currentColor, // Menggunakan warna yang dipilih
          ),
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/Watermark.png'),
                fit: BoxFit.cover, // Mengatur gambar agar menutupi seluruh area
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'Ubah tema sesuai dengan \nwarna kesukaanmu!',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.leagueSpartan(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 36),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _colorOption(themeController, Color(0xFF8D986A)),
                      _colorOption(themeController, Color(0xFFFEB62B)),
                      _colorOption(themeController, Color(0xFFEC4B31)),
                      _colorOption(themeController, Color(0xFFFD9BCF)),
                      _colorOption(themeController, Color(0xFF386EFB)),
                    ],
                  ),
                  const SizedBox(height: 450),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        themeController.resetColor(); // Reset warna ke default
                        Get.snackbar('Reset', 'Tema telah direset ke default.');
                      },
                      child: Text(
                        'Reset Tema',
                        style: GoogleFonts.leagueSpartan(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Center(
                    child: Obx(() => ElevatedButton(
                          onPressed: () {
                            // Logic untuk menyimpan tema
                            Get.snackbar('Simpan', 'Tema berhasil disimpan.');
                          },
                          child: Text(
                            'Simpan',
                            style: GoogleFonts.leagueSpartan(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(344, 50),
                            backgroundColor: themeController
                                .currentColor, // Menggunakan warna yang dipilih
                          ),
                        )),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Widget _colorOption(ThemeController themeController, Color color) {
    return GestureDetector(
      onTap: () {
        themeController.selectColor(color); // Memilih warna
      },
      child: Obx(() => Container(
            width: 61,
            height: 61,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              border: Border.all(
                color: themeController.currentColor == color
                    ? Colors.black
                    : Colors.transparent,
                width: 3,
              ),
            ),
          )),
    );
  }
}
