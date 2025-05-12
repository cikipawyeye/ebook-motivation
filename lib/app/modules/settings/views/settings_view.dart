import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

// Import Controllers
import 'package:ebookapp/app/modules/settings/controllers/setting_theme_controller.dart';
import 'package:ebookapp/app/modules/settings/controllers/user_controller.dart';
import 'package:ebookapp/app/modules/settings/controllers/settings_controller.dart';

// Import Routes
import 'package:ebookapp/app/routes/app_pages.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({Key? key}) : super(key: key);

  // Method untuk encode query parameters email
  String? _encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  @override
  Widget build(BuildContext context) {
    Get.put(UserController()); // Pastikan UserController dikelola

    final ThemeController themeController = Get.put(ThemeController());
    return Obx(
      () => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'Pengaturan',
            style: GoogleFonts.leagueSpartan(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 25,
            ),
          ),
          centerTitle: true,
          backgroundColor: themeController.currentColor,
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/Template.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            children: [
              _buildSettingItem(
                image: 'assets/icons/user_icon.png',
                title: 'Akun Saya',
                onTap: () {
                  Get.toNamed(Routes.myAccount);
                },
              ),
              const SizedBox(height: 8),
              _buildSettingItem(
                image: 'assets/icons/pencil_icon.png',
                title: 'Ganti Wallpaper dan Audio',
                onTap: () {
                  Get.offNamed(Routes.wallpaperMusic);
                },
              ),
              const SizedBox(height: 8),
              _buildSettingItem(
                image: 'assets/icons/key_icon.png',
                title: 'Ganti Kata Sandi',
                onTap: () {
                  Get.toNamed(Routes.changePass);
                },
              ),
              const SizedBox(height: 8),
              _buildSettingItem(
                image: 'assets/icons/crown_icon.png',
                title: 'Tingkatkan Akun',
                onTap: () {
                  Get.toNamed(Routes.accountStatus);
                },
              ),
              const SizedBox(height: 8),
              _buildSettingItem(
                image: 'assets/icons/message.png',
                title: 'Pusat Bantuan',
                onTap: () async {
                  // URI untuk email
                  final Uri emailLaunchUri = Uri(
                    scheme: 'mailto',
                    path: 'motivasi.ph@gmail.com',
                    query: _encodeQueryParameters(<String, String>{
                      'subject': 'Permintaan Bantuan Aplikasi',
                      'body': 'Halo Tim Support,\n\n'
                          'Saya ingin mengajukan pertanyaan/bantuan mengenai:\n'
                          'Aplikasi: [Nama Aplikasi]\n'
                          'Versi Aplikasi: [Versi]\n'
                          'Perangkat: [Merk dan Model]\n\n'
                          'Deskripsi Masalah:\n'
                    }),
                  );

                  try {
                    // Langsung launch URL email
                    if (await canLaunchUrl(emailLaunchUri)) {
                      await launchUrl(emailLaunchUri,
                          mode: LaunchMode
                              .externalApplication // Membuka di aplikasi eksternal
                          );
                    } else {
                      // Fallback jika tidak bisa membuka email
                      Get.snackbar(
                        'Kesalahan',
                        'Tidak dapat membuka aplikasi email',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                      );
                    }
                  } catch (e) {
                    // Tangani error
                    Get.snackbar(
                      'Kesalahan',
                      'Terjadi masalah saat membuka email: $e',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                  }
                },
              ),
              const SizedBox(height: 8),
              _buildSettingItem(
                image: 'assets/icons/exit_icon.png',
                title: 'Keluar',
                onTap: () {
                  _showLogoutDialog(context);
                },
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingItem({
    required String image,
    required String title,
    required VoidCallback onTap,
  }) {
    return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white.withValues(alpha: 0.3),
              Colors.white.withValues(alpha: 0.3)
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.black.withValues(alpha: 0.3),
            width: 1.5,
          ),
        ),
        child: ListTile(
          leading: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: Color(0xFFE9E9E9).withValues(alpha: 0.8),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: SizedBox(
                width: 18,
                height: 18,
                child: Image.asset(
                  image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          title: Text(
            title,
            style: GoogleFonts.leagueSpartan(
                fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
          ),
          onTap: onTap,
        ));
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.black.withValues(alpha: 0.8),
          insetPadding: EdgeInsets.all(18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconButton(
                icon: Icon(
                  Icons.close,
                  color: Colors.white.withValues(alpha: 0.7),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              Container(
                padding: const EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  bottom: 16.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(height: 18),
                        Expanded(
                          child: Text(
                            'Keluar dari akun',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.leagueSpartan(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Kamu yakin ingin keluar dari akunmu untuk sementara?',
                      style: GoogleFonts.leagueSpartan(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          final prefs = await SharedPreferences.getInstance();
                          final userController = Get.find<UserController>();

                          final int? storedUserId = prefs.getInt('userId');
                          final int? currentUserId =
                              userController.userId.value;

                          if (storedUserId != currentUserId) {
                            await prefs.setInt('userId', currentUserId ?? 0);
                            debugPrint(
                                "SharedPreferences diperbarui dengan userId baru: $currentUserId");
                          } else {
                            debugPrint(
                                "UserId sama, memuat kembali data SharedPreferences");
                          }

                          await userController.logout();
                          Get.offAllNamed(Routes.login);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE33535),
                        ),
                        child: Text(
                          'Keluar',
                          style: GoogleFonts.leagueSpartan(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
