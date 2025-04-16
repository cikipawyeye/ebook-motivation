// import 'package:ebookapp/app/modules/wallpaper_music/controllers/wallpaper_music_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class LiveWallpaperController extends GetxController {
//   final WallpaperMusicController wallpaperMusicController = Get.find<WallpaperMusicController>();

//   // Visibilitas wallpaper
//   final RxBool _isWallpaperVisible = true.obs;

//   // Opacity wallpaper
//   final RxDouble _wallpaperOpacity = 0.5.obs;

//   // Daftar wallpaper default
//   final RxList<String> _defaultWallpapers = [
//     'assets/gif/ocean-diver.gif',
//     'assets/gif/mountain-landscape.gif',
//     'assets/gif/space-animation.gif',
//   ].obs;

//   // Daftar wallpaper kustom
//   final RxList<String> _customWallpapers = <String>[].obs;

//   // Index wallpaper saat ini
//   final RxInt _currentWallpaperIndex = 0.obs;

//   // Getter untuk visibilitas wallpaper
//   bool get isWallpaperVisible => _isWallpaperVisible.value;

//   // Getter untuk opacity wallpaper
//   double get wallpaperOpacity => _wallpaperOpacity.value;

//   // Getter untuk wallpaper saat ini dengan fallback
//   String get currentWallpaper {
//     // Prioritaskan wallpaper yang dipilih dari WallpaperMusicController
//     final selectedWallpaper = wallpaperMusicController.selectedWallpaper.value;

//     if (selectedWallpaper.isNotEmpty) {
//       return selectedWallpaper;
//     }

//     // Jika tidak ada wallpaper yang dipilih, gunakan dari daftar
//     final combinedWallpapers = [..._defaultWallpapers, ..._customWallpapers];

//     if (combinedWallpapers.isEmpty) {
//       return 'assets/gif/ocean-diver.gif'; // Fallback terakhir
//     }

//     return combinedWallpapers[_currentWallpaperIndex.value % combinedWallpapers.length];
//   }

//   // Getter untuk mendapatkan semua wallpaper
//   List<String> get allWallpapers => [..._defaultWallpapers, ..._customWallpapers];

//   @override
//   void onInit() {
//     super.onInit();
//     // Tambahkan listener untuk perubahan wallpaper di WallpaperMusicController
//     ever(wallpaperMusicController.selectedWallpaper, (wallpaper) {
//       if (wallpaper.isNotEmpty) {
//         update(); // Trigger rebuild jika wallpaper berubah
//       }
//     });
//   }

//   // Toggle visibilitas wallpaper
//   void toggleWallpaperVisibility() {
//     _isWallpaperVisible.value = !_isWallpaperVisible.value;
//     update();
//   }

//   // Set opacity wallpaper
//   void setWallpaperOpacity(double opacity) {
//     _wallpaperOpacity.value = opacity.clamp(0.0, 1.0);
//     update();
//   }

//   // Ganti ke wallpaper selanjutnya
//   void nextWallpaper() {
//     final combinedWallpapers = [..._defaultWallpapers, ..._customWallpapers];

//     if (combinedWallpapers.isNotEmpty) {
//       _currentWallpaperIndex.value =
//         (_currentWallpaperIndex.value + 1) % combinedWallpapers.length;

//       // Perbarui wallpaper yang dipilih di WallpaperMusicController
//       wallpaperMusicController.selectWallpaper(currentWallpaper);

//       update();
//     }
//   }

//   // Tambah wallpaper kustom baru
//   void addCustomWallpaper(String wallpaperPath) {
//     if (!_customWallpapers.contains(wallpaperPath)) {
//       _customWallpapers.add(wallpaperPath);
//       update();
//     }
//   }

//   // Hapus wallpaper kustom
//   void removeCustomWallpaper(String wallpaperPath) {
//     _customWallpapers.remove(wallpaperPath);

//     // Sesuaikan index jika wallpaper yang dihapus adalah wallpaper saat ini
//     final combinedWallpapers = [..._defaultWallpapers, ..._customWallpapers];

//     if (_currentWallpaperIndex.value >= combinedWallpapers.length) {
//       _currentWallpaperIndex.value = combinedWallpapers.length - 1;
//     }

//     update();
//   }

//   // Reset ke wallpaper default
//   void resetToDefaultWallpapers() {
//     _customWallpapers.clear();
//     _currentWallpaperIndex.value = 0;

//     // Reset wallpaper yang dipilih di WallpaperMusicController
//     wallpaperMusicController.selectWallpaper(_defaultWallpapers.first);

//     update();
//   }

//   // Metode untuk mendapatkan widget wallpaper
//   Widget renderWallpaper() {
//     if (!isWallpaperVisible) return const SizedBox.shrink();

//     return Opacity(
//       opacity: wallpaperOpacity,
//       child: Image.asset(
//         currentWallpaper,
//         fit: BoxFit.cover,
//         width: double.infinity,
//         height: double.infinity,
//         errorBuilder: (context, error, stackTrace) {
//           // Fallback jika gambar tidak dapat dimuat
//           return Container(
//             color: Colors.black,
//             child: const Center(
//               child: Icon(
//                 Icons.broken_image,
//                 color: Colors.white,
//                 size: 50,
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// import 'dart:io';
// import 'package:ebookapp/app/modules/wallpaper_music/controllers/wallpaper_music_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:video_player/video_player.dart';
// import 'package:ebookapp/core/constants/constant.dart'; // Import AssetPaths

// class LiveWallpaperController extends GetxController {
//   // Controller untuk wallpaper dan musik
//   final WallpaperMusicController wallpaperMusicController =
//       Get.find<WallpaperMusicController>();

//   // Observable untuk wallpaper saat ini
//   final Rx<VideoPlayerController?> _videoController =
//       Rx<VideoPlayerController?>(null);
//   final RxDouble _wallpaperOpacity = RxDouble(0.5);
//   final RxBool _isWallpaperVisible = RxBool(true);

//   // Getter
//   String get currentWallpaper =>
//       wallpaperMusicController.selectedWallpaper.value.isNotEmpty
//           ? wallpaperMusicController.selectedWallpaper.value
//           : AssetPaths.wallpapers.first;

//   bool get isWallpaperVisible => _isWallpaperVisible.value;
//   double get wallpaperOpacity => _wallpaperOpacity.value;

//   @override
//   void onInit() {
//     super.onInit();

//     // Listen to changes in selected wallpaper
//     ever(wallpaperMusicController.selectedWallpaper, (_) {
//       _initializeWallpaper();
//     });

//     // Inisialisasi wallpaper pertama kali
//     _initializeWallpaper();
//   }

//   void _initializeWallpaper() {
//     // Dispose controller video lama
//     _videoController.value?.dispose();
//     _videoController.value = null;

//     final selectedWallpaper = currentWallpaper;

//     // Inisialisasi video jika perlu
//     if (selectedWallpaper.toLowerCase().endsWith('.mp4')) {
//       _initializeVideoController(selectedWallpaper);
//     }

//     // Perbarui UI
//     update();
//   }

//   void _initializeVideoController(String videoPath) async {
//     try {
//       // Cari controller yang sudah diinisialisasi di WallpaperMusicController
//       final existingController =
//           wallpaperMusicController.getVideoController(videoPath);

//       if (existingController != null) {
//         _videoController.value = existingController;
//         existingController.play();
//       } else {
//         // Jika belum diinisialisasi, muat dari asset
//         final controller = VideoPlayerController.asset(videoPath);
//         await controller.initialize();
//         controller.setLooping(true);
//         controller.play();

//         _videoController.value = controller;
//       }
//     } catch (e) {
//       debugPrint('Error inisialisasi video: $e');
//     }
//   }

//   void toggleWallpaperVisibility() {
//     _isWallpaperVisible.value = !_isWallpaperVisible.value;
//     update();
//   }

//   void setWallpaperOpacity(double opacity) {
//     _wallpaperOpacity.value = opacity.clamp(0.0, 1.0);
//     update();
//   }

//   Widget renderWallpaper() {
//     // Jika wallpaper tidak terlihat
//     if (!_isWallpaperVisible.value) return const SizedBox.shrink();

//     final selectedWallpaper = currentWallpaper;

//     // Render video
//     if (selectedWallpaper.toLowerCase().endsWith('.mp4')) {
//       return _renderVideoWallpaper();
//     }

//     // Render gambar
//     return _renderImageWallpaper(selectedWallpaper);
//   }

//   Widget _renderVideoWallpaper() {
//     final videoController = _videoController.value;

//     return videoController != null && videoController.value.isInitialized
//         ? Opacity(
//             opacity: _wallpaperOpacity.value,
//             child: AspectRatio(
//               aspectRatio: videoController.value.aspectRatio,
//               child: VideoPlayer(videoController),
//             ),
//           )
//         : Container(
//             color: Colors.black,
//             child: const Center(child: CircularProgressIndicator()),
//           );
//   }

//   Widget _renderImageWallpaper(String imagePath) {
//     return Opacity(
//       opacity: _wallpaperOpacity.value,
//       child: Image.asset(
//         imagePath,
//         fit: BoxFit.cover,
//         width: double.infinity,
//         height: double.infinity,
//         errorBuilder: (context, error, stackTrace) {
//           // Fallback ke gambar default jika gagal
//           return Image.asset(
//             AssetPaths.wallpapers.first,
//             fit: BoxFit.cover,
//             width: double.infinity,
//             height: double.infinity,
//           );
//         },
//       ),
//     );
//   }

//   @override
//   void onClose() {
//     _videoController.value?.dispose();
//     super.onClose();
//   }
// }

// // Dalam ContentView
// class ContentView extends StatelessWidget {
//   const ContentView({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // Dapatkan controller
//     final liveWallpaperController = Get.find<LiveWallpaperController>();
//     final wallpaperMusicController = Get.find<WallpaperMusicController>();

//     return Scaffold(
//       body: Stack(
//         children: [
//           // Wallpaper dinamis
//           Obx(() {
//             // Gunakan selectedWallpaper dari WallpaperMusicController
//             final selectedWallpaper =
//                 wallpaperMusicController.selectedWallpaper.value;

//             // Pastikan wallpaper valid
//             if (selectedWallpaper.isEmpty) {
//               return const SizedBox.shrink();
//             }

//             // Render wallpaper
//             return Positioned.fill(
//               child: liveWallpaperController.renderWallpaper(),
//             );
//           }),

//           // Kontrol Wallpaper
//           Positioned(
//             top: 40,
//             right: 20,
//             child: Row(
//               children: [
//                 // Tombol Visibilitas Wallpaper
//                 Obx(() => IconButton(
//                       icon: Icon(
//                         liveWallpaperController.isWallpaperVisible
//                             ? Icons.visibility
//                             : Icons.visibility_off,
//                         color: Colors.white,
//                       ),
//                       onPressed: () =>
//                           liveWallpaperController.toggleWallpaperVisibility(),
//                     )),

//                 // Slider Opacity
//                 Obx(() => SizedBox(
//                       width: 100,
//                       child: Slider(
//                         value: liveWallpaperController.wallpaperOpacity,
//                         onChanged: (value) =>
//                             liveWallpaperController.setWallpaperOpacity(value),
//                         min: 0.0,
//                         max: 1.0,
//                         activeColor: Colors.white,
//                         inactiveColor: Colors.white54,
//                       ),
//                     )),
//               ],
//             ),
//           ),

//           // Konten utama Anda
//           // ...
//         ],
//       ),
//     );
//   }
// }

// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:ebookapp/core/constants/constant.dart';
//
// class LiveWallpaperController extends GetxController {
//   // Observable Variables
//   final RxDouble _wallpaperOpacity = RxDouble(0.5);
//   final RxBool _isWallpaperVisible = RxBool(true);
//   final RxInt _currentWallpaperIndex = RxInt(0);
//   final RxString _selectedWallpaper = RxString('');
//
//   // Wallpaper Lists
//   final RxList<String> _defaultWallpapers = [
//     'assets/gif/ocean-diver.gif',
//     'assets/gif/mountain-landscape.gif',
//     'assets/gif/space-animation.gif',
//     'assets/pictures/Wallpaper_img_01.jpg',
//     'assets/pictures/Wallpaper_img_02.jpg',
//   ].obs;
//
//   final RxList<String> _customWallpapers = <String>[].obs;
//
//   // Getters
//   String get currentWallpaper {
//     // Prioritaskan wallpaper yang dipilih
//     if (_selectedWallpaper.value.isNotEmpty) {
//       return _selectedWallpaper.value;
//     }
//
//     // Gunakan dari daftar wallpaper
//     final combinedWallpapers = [..._defaultWallpapers, ..._customWallpapers];
//
//     if (combinedWallpapers.isEmpty) {
//       return _defaultWallpapers.first; // Fallback
//     }
//
//     return combinedWallpapers[_currentWallpaperIndex.value % combinedWallpapers.length];
//   }
//
//   bool get isWallpaperVisible => _isWallpaperVisible.value;
//   double get wallpaperOpacity => _wallpaperOpacity.value;
//   List<String> get allWallpapers => [..._defaultWallpapers, ..._customWallpapers];
//
//   // Metode Utama
//   void selectWallpaper(String wallpaperPath) {
//     _selectedWallpaper.value = wallpaperPath;
//     update();
//   }
//
//   void toggleWallpaperVisibility() {
//     _isWallpaperVisible.value = !_isWallpaperVisible.value;
//     update();
//   }
//
//   void setWallpaperOpacity(double opacity) {
//     _wallpaperOpacity.value = opacity.clamp(0.0, 1.0);
//     update();
//   }
//
//   void nextWallpaper() {
//     final combinedWallpapers = [..._defaultWallpapers, ..._customWallpapers];
//
//     if (combinedWallpapers.isNotEmpty) {
//       _currentWallpaperIndex.value =
//           (_currentWallpaperIndex.value + 1) % combinedWallpapers.length;
//
//       // Pilih wallpaper berikutnya
//       _selectedWallpaper.value = combinedWallpapers[_currentWallpaperIndex.value];
//       update();
//     }
//   }
//
//   void addCustomWallpaper(String wallpaperPath) {
//     if (!_customWallpapers.contains(wallpaperPath)) {
//       _customWallpapers.add(wallpaperPath);
//       update();
//     }
//   }
//
//   void removeCustomWallpaper(String wallpaperPath) {
//     _customWallpapers.remove(wallpaperPath);
//
//     // Sesuaikan index jika perlu
//     final combinedWallpapers = [..._defaultWallpapers, ..._customWallpapers];
//     if (_currentWallpaperIndex.value >= combinedWallpapers.length) {
//       _currentWallpaperIndex.value = combinedWallpapers.length - 1;
//     }
//
//     update();
//   }
//
//   void resetToDefaultWallpapers() {
//     _customWallpapers.clear();
//     _currentWallpaperIndex.value = 0;
//     _selectedWallpaper.value = _defaultWallpapers.first;
//     update();
//   }
//
//   // Render Wallpaper
//   Widget renderWallpaper() {
//     // Jika wallpaper tidak terlihat
//     if (!_isWallpaperVisible.value) return const SizedBox.shrink();
//
//     final wallpaperPath = currentWallpaper;
//
//     return Opacity(
//       opacity: _wallpaperOpacity.value,
//       child: _buildWallpaperImage(wallpaperPath),
//     );
//   }
//
//   Widget _buildWallpaperImage(String wallpaperPath) {
//     return Image.asset(
//       wallpaperPath,
//       fit: BoxFit.cover,
//       width: double.infinity,
//       height: double.infinity,
//       errorBuilder: (context, error, stackTrace) {
//         // Fallback ke gambar default jika gagal
//         return Image.asset(
//           _defaultWallpapers.first,
//           fit: BoxFit.cover,
//           width: double.infinity,
//           height: double.infinity,
//         );
//       },
//     );
//   }
// }

import 'dart:io';
import 'package:ebookapp/app/modules/wallpaper_music/controllers/wallpaper_music_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ebookapp/core/constants/constant.dart';
import 'package:video_player/video_player.dart'; // Import AssetPaths
import 'package:shared_preferences/shared_preferences.dart';

class LiveWallpaperController extends GetxController {
  // Controller untuk wallpaper dan musik
  final WallpaperMusicController wallpaperMusicController =
      Get.find<WallpaperMusicController>();

  // Observable untuk wallpaper saat ini
  final Rx<VideoPlayerController?> _videoController =
      Rx<VideoPlayerController?>(null);
  final RxDouble _wallpaperOpacity = RxDouble(0.5);
  final RxBool _isWallpaperVisible = RxBool(true);

  // Getter
  String get currentWallpaper =>
      wallpaperMusicController.selectedWallpaper.value.isNotEmpty
          ? wallpaperMusicController.selectedWallpaper.value
          : AssetPaths.wallpapers.first;

  bool get isWallpaperVisible => _isWallpaperVisible.value;
  double get wallpaperOpacity => _wallpaperOpacity.value;

  @override
  void onInit() {
    super.onInit();

    // Listen to changes in selected wallpaper
    ever(wallpaperMusicController.selectedWallpaper, (_) {
      _initializeWallpaper();
    });

    // Inisialisasi wallpaper pertama kali
    _initializeWallpaper();
  }

  void _initializeWallpaper() {
    // Dispose controller video lama
    _videoController.value?.dispose();
    _videoController.value = null;

    final selectedWallpaper = currentWallpaper;

    // Inisialisasi video jika perlu
    if (selectedWallpaper.toLowerCase().endsWith('.mp4')) {
      _initializeVideoController(selectedWallpaper);
    }

    // Perbarui UI
    update();
  }

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  void _initializeVideoController(String videoPath) async {
    try {
      // Cari controller yang sudah diinisialisasi di WallpaperMusicController
      final existingController =
          wallpaperMusicController.getVideoController(videoPath);

      if (existingController != null) {
        _videoController.value = existingController;
        existingController.play();
      } else {
        final token = await _getToken();

        final controller = VideoPlayerController.networkUrl(
          Uri(
              host: baseUrl,
              path: '/api/v1/wallpapers/1/file',
              queryParameters: {
                'expires': '1744394187',
                'signature':
                    '02330dad3ad946cae063d24809ba3adfec74b73c407ee923890c7603f7982ab5'
              }),
          httpHeaders: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        );

        _videoController.value = controller;
      }
    } catch (e) {
      debugPrint('Error inisialisasi video: $e');
    }
  }

  void toggleWallpaperVisibility() {
    _isWallpaperVisible.value = !_isWallpaperVisible.value;
    update();
  }

  void setWallpaperOpacity(double opacity) {
    _wallpaperOpacity.value = opacity.clamp(0.0, 1.0);
    update();
  }

  Widget renderWallpaper() {
    // Jika wallpaper tidak terlihat
    if (!_isWallpaperVisible.value) return const SizedBox.shrink();

    final selectedWallpaper = currentWallpaper;

    // Render video
    if (selectedWallpaper.toLowerCase().endsWith('.mp4')) {
      return _renderVideoWallpaper();
    }

    // Render gambar
    return _renderImageWallpaper(selectedWallpaper);
  }

  Widget _renderVideoWallpaper() {
    final videoController = _videoController.value;

    // Pastikan videoController diinisialisasi dan sudah ada
    if (videoController != null) {
      return Opacity(
        opacity: _wallpaperOpacity.value,
        child: VideoPlayer(videoController),
      );
    } else {
      return Container(
        color: Colors.black,
        child: const Center(child: CircularProgressIndicator()),
      );
    }
  }

  Widget _renderImageWallpaper(String imagePath) {
    return Opacity(
      opacity: _wallpaperOpacity.value,
      child: Image.asset(
        imagePath,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        errorBuilder: (context, error, stackTrace) {
          // Fallback ke gambar default jika gagal
          return Image.asset(
            AssetPaths.wallpapers.first,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          );
        },
      ),
    );
  }

  @override
  void onClose() {
    _videoController.value?.dispose();
    super.onClose();
  }
}  

// Dalam ContentView  
