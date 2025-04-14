import 'dart:typed_data';
import 'package:ebookapp/app/data/models/motivasi_model.dart';
import 'package:ebookapp/app/modules/motivasi/controllers/content_controller.dart';
import 'package:ebookapp/app/modules/motivasi/controllers/content_controller_drop.dart';
import 'package:ebookapp/app/modules/settings/controllers/setting_theme_controller.dart';
import 'package:ebookapp/app/modules/settings/controllers/user_controller.dart';
import 'package:ebookapp/app/routes/app_pages.dart';
import 'package:ebookapp/core/constants/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ContentViewPush extends GetView<ContentControllerDrop> {
  const ContentViewPush({super.key});

  @override
  Widget build(BuildContext context) {
    // Periksa apakah Get.arguments tidak null
    final Subcategory? subcategory = Get.arguments as Subcategory?;

    // Jika subcategory null, tampilkan pesan kesalahan
    if (subcategory == null) {
      return Scaffold(
        body: Center(child: Text("Subcategory tidak ditemukan")),
      );
    }

    final ThemeController themeController = Get.find<ThemeController>();
    final UserController userController = Get.find<UserController>();

    // Pastikan userController sudah diinisialisasi
    if (userController.isPremium.value == null) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: _buildBody(subcategory, themeController, userController),
    );
  }

  Widget _buildBody(Subcategory subcategory, ThemeController themeController,
      UserController userController) {
    final ScrollController scrollController = ScrollController();
    bool isAppBarVisible = true;

    return GetBuilder<ContentController>(
      initState: (_) => controller.fetchContents(subcategoryId: subcategory.id),
      builder: (controller) {
        if (controller.isLoading.value && controller.imageBytesList.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.imageBytesList.isEmpty) {
          return const Center(child: Text("No images available"));
        }

        return NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            // Jika isPremium = false dan pengguna mencoba scroll ke halaman ke-4
            if (!userController.isPremium.value &&
                controller.imageBytesList.length >= 3 &&
                scrollInfo.metrics.pixels >
                    scrollInfo.metrics.maxScrollExtent * 0.75) {
              Get.toNamed(
                  Routes.ticketPremium); // Navigasi ke halaman ticketPremium
              return true; // Hentikan scroll
            }

            // Sembunyikan AppBar saat scroll ke bawah
            if (scrollInfo.metrics.pixels > 100 && isAppBarVisible) {
              isAppBarVisible = false;
              Get.find<ContentController>().update();
            }
            // Tampilkan AppBar saat scroll ke atas
            else if (scrollInfo.metrics.pixels <= 100 && !isAppBarVisible) {
              isAppBarVisible = true;
              Get.find<ContentController>().update();
            }

            // Pagination saat mencapai akhir scroll
            if (scrollInfo.metrics.pixels ==
                    scrollInfo.metrics.maxScrollExtent &&
                controller.nextCursor.value != null) {
              controller.fetchContents(subcategoryId: subcategory.id);
            }
            return true;
          },
          child: Stack(
            children: [
              PageView.builder(
                scrollDirection: Axis.vertical,
                itemCount: userController.isPremium.value
                    ? controller.imageBytesList.length +
                        (controller.nextCursor.value != null ? 1 : 0)
                    : (controller.imageBytesList.length > 3
                        ? 3
                        : controller.imageBytesList.length),
                itemBuilder: (context, index) {
                  // Pastikan index tidak melebihi panjang list
                  if (index >= controller.imageBytesList.length) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  // Pastikan value tidak null sebelum mengaksesnya
                  final imageBytes = controller.imageBytesList[index].value;
                  if (imageBytes == null) {
                    return const Center(child: Text("Image data is null"));
                  }

                  return _buildPageItem(index, imageBytes);
                },
              ),
              // AppBar yang bisa hide/show
              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                top: isAppBarVisible ? 0 : -kToolbarHeight,
                left: 0,
                right: 0,
                child: _buildAppBar(subcategory, themeController),
              ),
            ],
          ),
        );
      },
    );
  }

  AppBar _buildAppBar(
      Subcategory subcategory, ThemeController themeController) {
    return AppBar(
      title: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: 'Motivasi',
          style: GoogleFonts.leagueSpartan(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
          children: [
            TextSpan(
              text: '\n${subcategory.id}. ${subcategory.name}',
              style: GoogleFonts.leagueSpartan(
                color: Colors.white,
                fontWeight: FontWeight.normal,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: themeController.currentColor,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Get.back(),
      ),
      actions: [
        GestureDetector(
          onTap: () {
            debugPrint('Image clicked');
            Get.toNamed(Routes.motivationContentsDrop, arguments: subcategory);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/images/caret.png', // Ganti dengan path gambar Anda
              width: 24,
              height: 24,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPageItem(int index, Uint8List imageBytes) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.memory(
            imageBytes,
            fit: BoxFit.contain,
          ),
        ),
        Positioned(
          bottom: 100,
          left: 20,
          right: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              Text(
                "(${index + 1})",
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
