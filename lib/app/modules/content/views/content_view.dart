import 'dart:async';

import 'package:ebookapp/app/data/models/motivasi_model.dart';
import 'package:ebookapp/app/modules/content/controllers/audio_controller.dart';
import 'package:ebookapp/app/modules/content/controllers/content_controller.dart';
import 'package:ebookapp/app/modules/content/controllers/live_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContentView extends GetView<ContentController> {
  final PageController _pageController = PageController();

  ContentView({super.key});

  @override
  Widget build(BuildContext context) {
    final Subcategory? subcategory = Get.arguments as Subcategory?;

    if (subcategory == null) {
      return const Scaffold(
        body: Center(child: Text("Subcategory tidak ditemukan")),
      );
    }

    controller.fetchImages(subcategoryId: subcategory.id, reset: true);

    final liveWallpaperController = Get.find<LiveWallpaperController>();
    final audioController = Get.find<AudioController>();

    return Scaffold(
      backgroundColor: Colors.black,
      body: Obx(() {
        if (controller.isLoading.value ||
            (controller.isFetchingData.value && controller.images.isEmpty)) {
          return Center(child: CircularProgressIndicator());
        }

        return Stack(
          children: [
            //  Background wallpaper
            Positioned.fill(
              child: liveWallpaperController.isWallpaperVisible
                  ? liveWallpaperController.renderWallpaper()
                  : const SizedBox.shrink(),
            ),
            // Konten utama
            GestureDetector(
                onTap: audioController.togglePlayPause,
                onLongPress: liveWallpaperController.toggleWallpaperVisibility,
                child: PageView.builder(
                  controller: _pageController,
                  scrollDirection: Axis.vertical,
                  itemCount: subcategory.contentsCount + 1,
                  onPageChanged: (index) {
                    controller.handlePageChanged(subcategory.id, index);

                    // Loop ke awal jika sudah di akhir dan nextCursor == null
                    if (index >= controller.images.length &&
                        controller.nextCursor == null) {
                      Future.delayed(Duration(milliseconds: 230), () {
                        _pageController.jumpToPage(0);
                      });
                    }
                  },
                  itemBuilder: (context, index) => _buildContentItem(index),
                )),
            // Wallpaper & audio controls
            _buildWallpaperControls(liveWallpaperController, audioController),
          ],
        );
      }),
    );
  }

  Widget _buildWallpaperControls(
      LiveWallpaperController liveWallpaperController,
      AudioController audioController) {
    return Positioned(
      top: 40,
      right: 20,
      child: Row(
        children: [
          Obx(() => IconButton(
                icon: Icon(
                  audioController.isPlaying.value
                      ? Icons.pause
                      : Icons.play_arrow,
                  color: Colors.white,
                ),
                onPressed: () => audioController.togglePlayPause(),
              )),
          Obx(() => IconButton(
                icon: Icon(
                  liveWallpaperController.isWallpaperVisible
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: Colors.white,
                ),
                onPressed: () =>
                    liveWallpaperController.toggleWallpaperVisibility(),
              )),
          Obx(() => SizedBox(
                width: 100,
                child: Slider(
                  value: liveWallpaperController.wallpaperOpacity,
                  onChanged: (value) =>
                      liveWallpaperController.setWallpaperOpacity(value),
                  min: 0.0,
                  max: 1.0,
                  activeColor: Colors.white,
                  inactiveColor: Colors.white54,
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildContentItem(int pageIndex) {
    if (pageIndex >= controller.images.length) {
      return SizedBox.shrink();
    }

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Gambar utama
          Container(
            constraints: BoxConstraints(
              maxHeight: Get.height * 0.65,
              maxWidth: double.infinity,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                  controller.images[pageIndex].imageUrls.optimized,
                  headers: {
                    'Content-Type': 'application/json',
                    'Accept': 'application/json',
                    'Authorization': 'Bearer ${controller.token.value}',
                  },
                  fit: BoxFit.contain,
                  height: Get.height * 0.65,
                  loadingBuilder: (context, child, loadingProgress) =>
                      loadingProgress == null
                          ? child
                          : Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        (loadingProgress.expectedTotalBytes ??
                                            1)
                                    : null,
                              ),
                            ),
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: Icon(
                        Icons.error,
                        color: Colors.red,
                        size: 50,
                      ),
                    );
                  }),
            ),
          ),

          // Watermark di bawah gambar utama
          Image.asset(
            'assets/images/watermark_icon.png', // Path gambar watermark
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return const SizedBox.shrink();
            },
          )
        ],
      ),
    );
  }
}
