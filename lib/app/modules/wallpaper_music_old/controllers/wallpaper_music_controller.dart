import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:just_audio/just_audio.dart';
import 'package:video_player/video_player.dart';
import '/../../../core/constants/constant.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

import '../model/music_track.dart';
import '../model/wallpaper_model.dart';

class WallpaperMusicController extends GetxController {
  static const int VIDEO_LOAD_TIMEOUT = 10;

  final selectedWallpaper = RxString('');
  final selectedWallpaperId = RxnInt();
  final selectedWallpaperType = RxnString();
  final selectedMusic = RxString('');
  final selectedMusicId = RxnInt();
  final wallpaperStatus = Rx<WallpaperStatus>(WallpaperStatus.loading);
  final musicStatus = Rx<WallpaperStatus>(WallpaperStatus.loading);
  final audioPlayer = AudioPlayer(useProxyForRequestHeaders: false);
  final audioVolume = RxDouble(0.5);
  final errorMessage = RxString('');
  final token = RxString('');

  final musicPlaylist = RxList<MusicTrack>([]);
  final wallpapers = RxList<Wallpaper>([]);

  late VideoPlayerController _controller;

  // Menambahkan Map untuk menyimpan video controllers
  final Map<String, VideoPlayerController> videoControllers = {};

  @override
  void onInit() {
    debugPrint("Init WallpaperMusicController");
    super.onInit();
    _initializeVideoPlayback();
    _initializeServices();
    _getToken().then((value) => token.value = value ?? '');
    _initSelectedWallpaperMusic();
  }

  Future<void> _initSelectedWallpaperMusic() async {
    final prefs = await SharedPreferences.getInstance();
    selectedWallpaperId.value = prefs.getInt('selectedWallpaperId');
    selectedWallpaperType.value = prefs.getString('selectedWallpaperType');
    selectedMusicId.value = prefs.getInt('selectedMusicId');
  }

  Future<void> _initializeVideoPlayback() async {
    try {
      final token = await _getToken();
      debugPrint('🔄 Mengambil video dari URL...');

      if (selectedWallpaper.value.isEmpty) {
        if (wallpapers.isNotEmpty) {
          selectedWallpaper.value = wallpapers.first.fileUrl;
        } else {
          return;
        }
      }

      _controller = VideoPlayerController.networkUrl(
        Uri.parse(selectedWallpaper.value),
        httpHeaders: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      await _controller.initialize();

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
      audioPlayer.setShuffleModeEnabled(false);
      audioPlayer.setLoopMode(LoopMode.one);
      audioPlayer.playerStateStream.listen(_handleAudioStateChange);
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
    if (selectedWallpaperId.value != null) {
      await prefs.setInt('selectedWallpaperId', selectedWallpaperId.value!);
    }
    if (selectedWallpaperType.value != null) {
      await prefs.setString(
          'selectedWallpaperType', selectedWallpaperType.value!);
    }
    if (selectedMusicId.value != null) {
      await prefs.setInt('selectedMusicId', selectedMusicId.value!);
    }

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
        Uri.parse('$baseUrl/api/v1/wallpapers?paginate=false'),
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
        wallpapers.value = wallpaperData.map((item) {
          Wallpaper wallpaper = Wallpaper.fromJson(item);
          if (wallpaper.type == 'video') {
            _initializeVideo(wallpaper);
          }
          return wallpaper;
        }).toList();
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
        Uri.parse('$baseUrl/api/v1/musics?paginate=false'),
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

    selectedWallpaper.value = wallpaper.fileUrl;
    selectedWallpaperId.value = wallpaper.id;
    selectedWallpaperType.value = wallpaper.type;
    saveSelections();
    saveSelectedWallpaper(wallpaper, token.value);

    // Muat video hanya jika wallpaper yang dipilih adalah tipe video
    if (wallpaper.type == 'video') {
      VideoPlayerController? videoController =
          getVideoController(wallpaper.fileUrl);
      if (videoController == null ||
          videoController.value.isInitialized == false) {
        _initializeVideo(wallpaper);
      }
    } else {
      debugPrint('Wallpaper yang dipilih bukan video');
    }

    if (!isClosed) update();
  }

  Future<File> saveSelectedWallpaper(Wallpaper wallpaper, String token) async {
    final tempDir = await getTemporaryDirectory();
    final permDir = await getApplicationDocumentsDirectory();

    final fileName = wallpaper.type == 'video'
        ? '${wallpaper.id}.mp4'
        : '${wallpaper.id}.jpg';
    final tempFile = File('${tempDir.path}/wallpapers/$fileName');
    final permFile = File('${permDir.path}/wallpapers/$fileName');

    if (await tempFile.exists()) {
      // Kalau ada di cache, pindahkan ke storage permanen
      await tempFile.copy(permFile.path);
      debugPrint(
          'Video dipindahkan dari cache ke storage permanen: ${permFile.path}');
      return permFile;
    }

    // Kalau tidak ada, download baru
    debugPrint('Video tidak ditemukan, mulai download...');
    await _downloadVideo(wallpaper.fileUrl, token, permFile);
    debugPrint(
        'Video berhasil didownload ke storage permanen: ${permFile.path}');
    return permFile;
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

  Future<void> _downloadVideo(
      String videoUrl, String token, File saveAs) async {
    final dio = Dio();
    await dio.download(
      videoUrl,
      saveAs.path,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ),
    );
    debugPrint('Video berhasil didownload ke: ${saveAs.path}');
  }

  Future<void> _initializeVideo(Wallpaper wallpaper) async {
    try {
      debugPrint('Menginisialisasi video: ${wallpaper.fileUrl}');

      final token = await _getToken();

      // Download video ke local
      final dir = await getTemporaryDirectory();
      final localFile = File('${dir.path}/wallpapers/${wallpaper.id}.mp4');

      debugPrint('Path lokal: ${localFile.path}');

      VideoPlayerController controller;

      if (await localFile.exists()) {
        debugPrint('File lokal ditemukan: ${localFile.path}');

        controller = VideoPlayerController.file(localFile);
        await controller.initialize();

        if (!controller.value.isInitialized) {
          debugPrint('File ada tapi tidak bisa diputar, akan download ulang.');
          await _downloadVideo(wallpaper.fileUrl, token!, localFile);
          controller = VideoPlayerController.file(localFile);
          await controller.initialize();
        }
      } else {
        debugPrint('File lokal tidak ditemukan, download...');
        await _downloadVideo(wallpaper.fileUrl, token!, localFile);
        controller = VideoPlayerController.file(localFile);
        await controller.initialize();
      }

      await controller.setVolume(0);

      videoControllers[wallpaper.fileUrl] = controller; // Simpan ke dalam map
      debugPrint('Video berhasil dimuat: ${wallpaper.fileUrl}');

      if (!isClosed) update();
    } catch (e) {
      debugPrint('Kesalahan inisialisasi video: ${wallpaper.fileUrl} - $e');
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

  VideoPlayerController? getVideoController(String videoPath) {
    return videoControllers[videoPath];
  }

  // Memilih Musik
  Future<void> selectMusic(MusicTrack? musicTrack) async {
    if (musicTrack == null || musicTrack.fileUrl.isEmpty) {
      return;
    }

    try {
      final results = await Future.wait<dynamic>([
        _getToken(),
        getTemporaryDirectory(),
      ]);

      final token = results[0] as String;
      final dir = results[1] as Directory;

      final localFile = File('${dir.path}/musics/${musicTrack.id}.mp3');
      final audioSource = LockCachingAudioSource(Uri.parse(musicTrack.fileUrl),
          cacheFile: localFile,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          });

      if ((selectedMusic.value != musicTrack.fileUrl)) {
        selectedMusic.value = musicTrack.fileUrl;
        selectedMusicId.value = musicTrack.id;
        saveSelections();
        audioPlayer.setAudioSource(audioSource).then((value) {
          audioPlayer.play();
          if (!isClosed) update();
        });
      } else {
        if (audioPlayer.playing) {
          audioPlayer.pause();
        } else {
          if (audioPlayer.audioSource == null) {
            audioPlayer.setAudioSource(audioSource).then((value) {
              audioPlayer.play();
              if (!isClosed) update();
            });
          } else {
            audioPlayer.play();
          }
        }
      }
    } catch (e) {
      debugPrint(musicTrack.fileUrl);
      _handleAudioError(e);
    } finally {
      if (!isClosed) update();
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
    if (state.processingState == ProcessingState.completed) {
      debugPrint('Musik telah selesai diputar');
      // playNextTrack();
    } else if (state.processingState == ProcessingState.ready &&
        !state.playing) {
      debugPrint('Audio dihentikan');
    } else if (state.processingState == ProcessingState.ready &&
        state.playing) {
      debugPrint('Audio sedang diputar');
    } else if (state.processingState == ProcessingState.buffering) {
      debugPrint('Buffering...');
    }
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
    videoControllers.clear();
    audioPlayer.stop();
    audioPlayer.dispose();

    try {
      _controller.dispose();
    } catch (e) {
      debugPrint('Kesalahan saat menutup controller video: $e');
    }

    super.onClose();

    debugPrint("WallpaperMusicController closed");
  }
}

// Status Enum
enum WallpaperStatus { idle, loading, error, loaded }
