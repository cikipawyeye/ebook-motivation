import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:better_player/better_player.dart'; 
import '/../../../core/constants/constant.dart';

import '../model/music_track.dart';
import '../model/wallpaper_model.dart'; 

class WallpaperMusicController extends GetxController {
  static const int VIDEO_LOAD_TIMEOUT = 10;

  final selectedWallpaper = RxString('');
  final selectedMusic = RxString('');
  final wallpaperStatus = Rx<WallpaperStatus>(WallpaperStatus.idle);
  final musicStatus = Rx<WallpaperStatus>(WallpaperStatus.idle);
  final audioPlayer = AudioPlayer();
  final audioVolume = RxDouble(0.5);
  final errorMessage = RxString('');

  final musicPlaylist = RxList<MusicTrack>([]);
  final wallpapers = RxList<Wallpaper>([]);

  late BetterPlayerController
      _controller; // Ganti VideoPlayerController dengan BetterPlayerController

  // Menambahkan Map untuk menyimpan video controllers
  final Map<String, BetterPlayerController> videoControllers = {};

  @override
  void onInit() {
    super.onInit();
    _initializeVideoPlayback();
    _initializeServices();
  }

  Future<void> _initializeVideoPlayback() async {
    try {
      final token = await _getToken();
      debugPrint('🔄 Mengambil video dari URL...');

      // Initialize BetterPlayerController
      BetterPlayerDataSource dataSource = BetterPlayerDataSource(
        BetterPlayerDataSourceType.network,
        '${baseUrl}/api/v1/wallpapers/1/file?expires=1744394187&signature=02330dad3ad946cae063d24809ba3adfec74b73c407ee923890c7603f7982ab5',
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      _controller = BetterPlayerController(
        BetterPlayerConfiguration(
          autoPlay: true,
          looping: true,
          controlsConfiguration: BetterPlayerControlsConfiguration(
            showControls: true,
          ),
        ),
      )..setupDataSource(dataSource);

      // Memulai pemutaran
      _controller.play();
      debugPrint('Controller video baru diinisialisasi');
    } catch (e) {
      debugPrint('Kesalahan saat menginisialisasi video: $e');
      errorMessage.value = 'Gagal menginisialisasi video: ${e.toString()}';
      wallpaperStatus.value = WallpaperStatus.error; // Set status error
    }
  }

  Future<void> _initializeServices() async {
    try {
      await loadSelections();
      audioPlayer.onPlayerStateChanged.listen(_handleAudioStateChange);
      audioPlayer.onPlayerComplete.listen((_) => _handleMusicCompletion());
      await _fetchWallpapers();
      await _fetchMusic();
    } catch (e) {
      _handleInitializationError(e);
    }
  }

  Future<void> saveSelections() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedWallpaper', selectedWallpaper.value);
    await prefs.setString('selectedMusic', selectedMusic.value);
    debugPrint(
        'Disimpan - Wallpaper: ${selectedWallpaper.value}, Musik: ${selectedMusic.value}');
  }

  Future<void> loadSelections() async {
    final prefs = await SharedPreferences.getInstance();
    selectedWallpaper.value = prefs.getString('selectedWallpaper') ?? '';
    selectedMusic.value = prefs.getString('selectedMusic') ?? '';
    debugPrint(
        'Dimuat - Wallpaper: ${selectedWallpaper.value}, Musik: ${selectedMusic.value}');
  }

  Future<void> _fetchWallpapers() async {
    try {
      final token = await _getToken(); // Dapatkan token
      debugPrint('🔄 Mengambil wallpaper...');

      // Memisahkan proses HTTP ke dalam Future agar UI tetap responsif
      final response = await http.get(
        Uri.parse(
            '${baseUrl}/api/v1/wallpapers?paginate=false'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ).timeout(Duration(seconds: 10));

      debugPrint('Status respons: ${response.statusCode}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        final List<dynamic> wallpaperData = jsonResponse['data'];
        wallpapers.value =
            wallpaperData.map((item) => Wallpaper.fromJson(item)).toList();
        wallpaperStatus.value = WallpaperStatus.loaded;
      } else {
        throw Exception(
            'Gagal memuat wallpaper, status kode: ${response.statusCode}');
      }
    } catch (e) {
      wallpaperStatus.value = WallpaperStatus.error;
      _handleInitializationError(e);
    }
  }

  Future<void> _fetchMusic() async {
    try {
      final token = await _getToken(); // Dapatkan token
      debugPrint('🔄 Mengambil musik...');

      final response = await http.get(
        Uri.parse(
            '${baseUrl}/api/v1/musics?paginate=false'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ).timeout(Duration(seconds: 10));

      debugPrint('Status respons: ${response.statusCode}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        final List<dynamic> musicData = jsonResponse['data'];
        musicPlaylist.value =
            musicData.map((item) => MusicTrack.fromJson(item)).toList();
        musicStatus.value = WallpaperStatus.loaded;
      } else {
        throw Exception(
            'Gagal memuat musik, status kode: ${response.statusCode}');
      }
    } catch (e) {
      musicStatus.value = WallpaperStatus.error;
      _handleInitializationError(e);
    }
  }

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  void selectWallpaper(Wallpaper wallpaper) {
    if (wallpaper.fileUrl.isEmpty) {
      debugPrint('Jalur wallpaper kosong');
      return;
    }

    // Hentikan dan buang video yang saat ini diinisialisasi
    stopAndDisposeCurrentVideo();

    selectedWallpaper.value = wallpaper.fileUrl;
    saveSelections();

    // Muat video hanya jika wallpaper yang dipilih adalah tipe video
    if (wallpaper.type == 'video') {
      _initializeVideo(wallpaper.fileUrl);
    } else {
      debugPrint('Wallpaper yang dipilih bukan video');
    }

    update();
  }

  void stopAndDisposeCurrentVideo() {
    // Dispose of the current video controller if it exists
    if (selectedWallpaper.value.isNotEmpty) {
      final currentController = videoControllers[selectedWallpaper.value];
      if (currentController != null) {
        currentController.pause();
        currentController.seekTo(Duration.zero);
        currentController
            .dispose(); // Hapus pengontrol untuk membebaskan memori
        videoControllers.remove(selectedWallpaper.value); // Hapus dari map
      }
    }
  }

  Future<void> _initializeVideo(String videoUrl) async {
    try {
      debugPrint('Menginisialisasi video: $videoUrl');
      final controller = BetterPlayerController(
        BetterPlayerConfiguration(
          autoPlay: true,
          looping: true,
          controlsConfiguration: BetterPlayerControlsConfiguration(
            showControls: true,
          ),
        ),
      );
      final dataSource = BetterPlayerDataSource(
        BetterPlayerDataSourceType.network,
        videoUrl,
      );
      await controller.setupDataSource(dataSource);
      videoControllers[videoUrl] = controller; // Simpan ke dalam map
      debugPrint('Video berhasil dimuat: $videoUrl');
    } catch (e) {
      debugPrint('Kesalahan inisialisasi video: $videoUrl - $e');
      wallpaperStatus.value = WallpaperStatus.error;
      errorMessage.value = 'Gagal memuat video: ${e.toString()}';
    }
  }

  void stopVideo(String videoPath) {
    final controller = getVideoController(videoPath);
    if (controller != null) {
      controller.pause();
      controller.seekTo(Duration.zero);
    }
  }

  BetterPlayerController? getVideoController(String videoPath) {
    return videoControllers[videoPath];
  }

  // Memilih Musik
  Future<void> selectMusic(MusicTrack musicTrack) async {
    try {
      musicStatus.value = WallpaperStatus.loading;

      if (selectedMusic.value == musicTrack.fileUrl) {
        if (audioPlayer.state == PlayerState.playing) {
          await audioPlayer.pause();
        } else {
          await audioPlayer.play(UrlSource(musicTrack.fileUrl));
        }
      } else {
        await audioPlayer.stop();
        await audioPlayer.play(UrlSource(musicTrack.fileUrl));
        selectedMusic.value = musicTrack.fileUrl;
        saveSelections();
      }

      musicStatus.value = WallpaperStatus.loaded;
    } catch (e) {
      musicStatus.value = WallpaperStatus.error;
      _handleAudioError(e);
    }
  }

  void addToPlaylist(MusicTrack musicTrack) {
    if (!musicPlaylist.contains(musicTrack)) {
      musicPlaylist.add(musicTrack);
    }
  }

  void playNextTrack() {
    if (musicPlaylist.isNotEmpty) {
      final currentIndex = musicPlaylist
          .indexWhere((track) => track.fileUrl == selectedMusic.value);
      final nextIndex = (currentIndex + 1) % musicPlaylist.length;
      selectMusic(musicPlaylist[nextIndex]);
    }
  }

  void setAudioVolume(double volume) {
    audioVolume.value = volume;
    audioPlayer.setVolume(volume);
  }

  void _handleAudioStateChange(PlayerState state) {
    switch (state) {
      case PlayerState.playing:
        debugPrint('Audio sedang diputar');
        break;
      case PlayerState.stopped:
        debugPrint('Audio dihentikan');
        break;
      default:
        break;
    }
  }

  void _handleMusicCompletion() {
    debugPrint('Musik telah selesai diputar');
    playNextTrack(); // Secara otomatis putar trek berikutnya
  }

  void _handleAudioError(dynamic error) {
    debugPrint('Kesalahan Audio: $error');
    errorMessage.value = 'Gagal memuat musik: ${error.toString()}';
    musicStatus.value = WallpaperStatus.error;
  }

  void _handleInitializationError(dynamic error) {
    debugPrint('Kesalahan Inisialisasi: $error');
    errorMessage.value = 'Inisialisasi gagal: ${error.toString()}';
    wallpaperStatus.value = WallpaperStatus.error;
  }

  @override
  void onClose() {
    // Bersihkan sumber daya
    videoControllers.forEach((_, controller) => controller.dispose());
    audioPlayer.stop();
    audioPlayer.dispose();
    _controller.dispose(); // Hapus controller baru
    super.onClose();
  }
}

// Status Enum
enum WallpaperStatus { idle, loading, error, loaded }
