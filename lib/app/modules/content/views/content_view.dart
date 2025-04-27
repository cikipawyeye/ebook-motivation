import 'dart:typed_data';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ebookapp/app/modules/content/controllers/audio_controller.dart';
import 'package:ebookapp/app/modules/content/controllers/live_controller.dart';
import 'package:ebookapp/app/modules/content/controllers/content_controller.dart';
import 'package:ebookapp/app/modules/settings/controllers/setting_theme_controller.dart';
import 'package:ebookapp/app/modules/settings/controllers/user_controller.dart';
import 'package:ebookapp/app/data/models/motivasi_model.dart';
import 'package:ebookapp/app/routes/app_pages.dart';

class ContentView extends GetView<ContentController> {
  const ContentView({super.key});

  @override
  Widget build(BuildContext context) {
    final Subcategory? subcategory = Get.arguments as Subcategory?;

    if (subcategory == null) {
      return const Scaffold(
        body: Center(child: Text("Subcategory tidak ditemukan")),
      );
    }

    final liveWallpaperController = Get.find<LiveWallpaperController>();
    final audioController = Get.find<AudioController>();
    final themeController = Get.find<ThemeController>();
    final userController = Get.find<UserController>();

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Obx(() {
            return Positioned.fill(
              child: liveWallpaperController.isWallpaperVisible
                  ? liveWallpaperController.renderWallpaper()
                  : const SizedBox.shrink(),
            );
          }),
          Positioned.fill(
            child: _buildBody(
              subcategory,
              themeController,
              userController,
              audioController,
              liveWallpaperController,
            ),
          ),
          _buildWallpaperControls(liveWallpaperController, audioController),
        ],
      ),
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

  Widget _buildBody(
    Subcategory subcategory,
    ThemeController themeController,
    UserController userController,
    AudioController audioController,
    LiveWallpaperController liveWallpaperController,
  ) {
    final slideCount = 0.obs;
    final pageController = PageController(keepPage: true);

    return GetBuilder<ContentController>(
      initState: (_) => controller.fetchContents(subcategoryId: subcategory.id),
      builder: (controller) {
        if (controller.isLoading.value && controller.imageBytesList.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue)),
          );
        }

        if (controller.imageBytesList.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.image_not_supported,
                    size: 80, color: Colors.grey),
                const SizedBox(height: 16),
                Text("Tidak ada gambar tersedia",
                    style: Get.textTheme.titleMedium
                        ?.copyWith(color: Colors.grey)),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () =>
                      controller.fetchContents(subcategoryId: subcategory.id),
                  child: const Text("Muat Ulang"),
                ),
              ],
            ),
          );
        }

        return FutureBuilder(
          future: SharedPreferences.getInstance(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            return _buildContentView(
              context,
              snapshot.data as SharedPreferences,
              subcategory,
              userController,
              audioController,
              liveWallpaperController,
              slideCount,
              pageController,
              controller,
            );
          },
        );
      },
    );
  }

  Widget _buildContentView(
    BuildContext context,
    SharedPreferences prefs,
    Subcategory subcategory,
    UserController userController,
    AudioController audioController,
    LiveWallpaperController liveWallpaperController,
    RxInt slideCount,
    PageController pageController,
    ContentController contentController,
  ) {
    final int? storedUserId = prefs.getInt('userId');
    final int? currentUserId = userController.userId.value;

    if (storedUserId != currentUserId) {
      prefs.remove('slideCount');
      prefs.remove('isScrollLimitReached');
      prefs.setInt('userId', currentUserId ?? 0);
    }

    bool isScrollLimitReached = prefs.getBool('isScrollLimitReached') ?? false;

    if (isScrollLimitReached && !userController.isPremium.value) {
      Future.microtask(() => Get.offNamed(Routes.ticketPremium));
      return const SizedBox.shrink();
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return GestureDetector(
          onTap: audioController.togglePlayPause,
          onLongPress: liveWallpaperController.toggleWallpaperVisibility,
          child: NotificationListener<ScrollNotification>(
            onNotification: (scrollInfo) {
              return _handleScrollNotification(
                scrollInfo,
                slideCount,
                prefs,
                userController,
                contentController,
                subcategory,
              );
            },
            child: _buildPageView(
              pageController,
              userController,
              contentController,
            ),
          ),
        );
      },
    );
  }

  Widget _buildPageView(
    PageController pageController,
    UserController userController,
    ContentController contentController,
  ) {
    return PageView.builder(
      controller: pageController,
      scrollDirection: Axis.vertical,
      itemCount: _calculateItemCount(userController, contentController),
      itemBuilder: (context, index) {
        if (index >= contentController.imageBytesList.length) {
          return const Center(child: CircularProgressIndicator());
        }

        final imageBytes = contentController.imageBytesList[index].value;
        if (imageBytes == null) {
          return _buildErrorItem();
        }

        return _buildPageItem(index, imageBytes);
      },
    );
  }

  int _calculateItemCount(
    UserController userController,
    ContentController contentController,
  ) {
    return userController.isPremium.value
        ? contentController.imageBytesList.length +
            (contentController.nextCursor.value != null ? 1 : 0)
        : (contentController.imageBytesList.length > 3
            ? 3
            : contentController.imageBytesList.length);
  }

  bool _handleScrollNotification(
    ScrollNotification scrollInfo,
    RxInt slideCount,
    SharedPreferences prefs,
    UserController userController,
    ContentController contentController,
    Subcategory subcategory,
  ) {
    if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
      slideCount.value++;
      debugPrint("Slide count: ${slideCount.value}");

      if (!userController.isPremium.value && slideCount.value >= 2) {
        prefs.setBool('isScrollLimitReached', true);
        Future.microtask(() => Get.offNamed(Routes.ticketPremium));
      }

      contentController.fetchContents(subcategoryId: subcategory.id);
    }
    return true;
  }

  Widget _buildPageItem(int index, Uint8List imageBytes) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min, // Menyesuaikan ukuran kolom
        children: [
          // Gambar utama
          Container(
            constraints: BoxConstraints(
              maxWidth: double.infinity, // Mengikuti lebar maksimal
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: _buildImageWithErrorHandling(imageBytes),
            ),
          ),

          // Watermark di bawah gambar utama
          FutureBuilder<Size>(
            future: _getImageSize(
                'assets/images/watermark_icon.png'), // Path gambar watermark
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SizedBox(); // Tampilkan nothing sementara menunggu
              }

              final imageSize = snapshot.data;

              return SizedBox(
                width: imageSize?.width ??
                    100, // Mengatur lebar watermark mengikuti ukuran gambar
                height: imageSize?.height ?? 100, // Mengatur tinggi watermark
                child: Image.asset(
                  'assets/images/watermark_icon.png', // Path gambar watermark
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: Text(
                        "Gambar tidak ditemukan",
                        style: TextStyle(color: Colors.red),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // Fungsi untuk mendapatkan ukuran gambar dari asset
  Future<Size> _getImageSize(String assetPath) async {
    final Completer<Size> completer = Completer();

    // Memuat gambar untuk mendapatkan ukuran
    final Image image = Image.asset(assetPath);
    image.image
        .resolve(const ImageConfiguration())
        .addListener(ImageStreamListener(
          (ImageInfo info, bool sync) {
            completer.complete(Size(
                info.image.width.toDouble(), info.image.height.toDouble()));
          },
          onError: (exception, stackTrace) {
            completer.complete(Size(
                100, 100)); // Kembalikan ukuran default jika terjadi kesalahan
          },
        ));

    return completer.future;
  }

  Widget _buildErrorItem() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, color: Colors.red, size: 50),
          SizedBox(height: 10),
          Text(
            "Gagal memuat gambar",
            style: TextStyle(color: Colors.red),
          ),
        ],
      ),
    );
  }

  Widget _buildImageWithErrorHandling(Uint8List imageBytes) {
    return Image.memory(
      imageBytes,
      fit: BoxFit.cover,
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded) return child;
        return frame == null
            ? const Center(child: CircularProgressIndicator())
            : child;
      },
      errorBuilder: (context, error, stackTrace) {
        debugPrint('Image load error: $error');
        return _buildErrorPlaceholder();
      },
    );
  }

  Widget _buildErrorPlaceholder() {
    return Container(
      color: Colors.grey[300],
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.broken_image_outlined, color: Colors.grey, size: 50),
            SizedBox(height: 10),
            Text("Gambar tidak tersedia", style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
