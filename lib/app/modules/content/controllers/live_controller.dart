import 'dart:io';
import 'dart:convert';
import 'package:ebookapp/core/constants/constant.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LiveWallpaperController extends GetxController {
  // Observable untuk wallpaper saat ini
  final _videoController = Rxn<VideoPlayerController>();
  final wallpaperImagePath = RxnString();
  final RxDouble _wallpaperOpacity = RxDouble(0.5);
  final RxBool _isWallpaperVisible = RxBool(true);

  bool get isWallpaperVisible => _isWallpaperVisible.value;
  double get wallpaperOpacity => _wallpaperOpacity.value;
  VideoPlayerController? get videoController => _videoController.value;

  @override
  void onInit() {
    super.onInit();

    if (_videoController.value != null) {
      _videoController.value!.dispose();
      _videoController.value = null;
    }

    _getWallpaperData().then((wallpaperData) async {
      if (wallpaperData.wallpaperType == 'video') {
        debugPrint('Video wallpaper detected');
        wallpaperImagePath.value = null;
        await _initializeVideoController(wallpaperData.wallpaperId!);
      } else {
        debugPrint('image wallpaper detected');

        if (_videoController.value != null) {
          _videoController.value!.dispose();
          _videoController.value = null;
        }
        await _initializeWallpaperImage(wallpaperData.wallpaperId!);
      }

      update();
    });
  }

  Future<SelectedWallpaperData> _getWallpaperData() async {
    final prefs = await SharedPreferences.getInstance();
    return SelectedWallpaperData(
      wallpaperId: prefs.getInt('selectedWallpaperId'),
      wallpaperType: prefs.getString('selectedWallpaperType'),
    );
  }

  Future<void> _initializeVideoController(int wallpaperId) async {
    final permDir = await getApplicationDocumentsDirectory();

    try {
      final permFile = File('${permDir.path}/wallpapers/$wallpaperId.mp4');

      if (!(await permFile.exists())) {
        debugPrint('File tidak ditemukan, mendownload wallpaper...');
        await _downloadWallpaper(wallpaperId, permFile);
      }

      _videoController.value = VideoPlayerController.file(permFile);
      _videoController.value!.initialize().then((_) {
        _videoController.value!.setLooping(true);
        _videoController.value!.setVolume(0);
        _videoController.value!.play();
      });
    } catch (e) {
      debugPrint('Error inisialisasi video: $e');
    }
  }

  Future<void> _initializeWallpaperImage(int wallpaperId) async {
    final permDir = await getApplicationDocumentsDirectory();
    final permFile = File('${permDir.path}/wallpapers/$wallpaperId.jpg');

    try {
      if (!(await permFile.exists())) {
        debugPrint('File tidak ditemukan, mendownload wallpaper...');
        await _downloadWallpaper(wallpaperId, permFile);
      }

      wallpaperImagePath.value = permFile.path;
    } catch (e) {
      debugPrint('Error inisialisasi image: $e');
    }
  }

  Future<void> _downloadWallpaper(int id, File saveAs) async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token')!;

    final response = await http.get(
      Uri.parse('$baseUrl/api/v1/wallpapers/$id'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      debugPrint('Error downloading wallpaper: ${response.statusCode}');
      return;
    }

    debugPrint('Response: ${response.body}');
    final jsonResponse = json.decode(response.body);

    final dio = Dio();
    await dio.download(
      jsonResponse['file_url'],
      saveAs.path,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ),
    );
    debugPrint('File berhasil didownload ke: ${saveAs.path}');
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

    // Render video
    if (_videoController.value != null) {
      return _renderVideoWallpaper();
    }

    // Render video
    if (wallpaperImagePath.value != null) {
      // Render gambar
      return _renderImageWallpaper(wallpaperImagePath.value!);
    }

    debugPrint('No selected wallpaper found');
    return const SizedBox.shrink();
  }

  Widget _renderVideoWallpaper() {
    // Pastikan videoController diinisialisasi dan sudah ada
    if (_videoController.value != null) {
      return Opacity(
        opacity: _wallpaperOpacity.value,
        child: VideoPlayer(_videoController.value!),
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
      child: Image.file(
        File(imagePath),
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

class SelectedWallpaperData {
  final int? wallpaperId;
  final String? wallpaperType;

  SelectedWallpaperData({this.wallpaperId, this.wallpaperType});
}

// Dalam ContentView
