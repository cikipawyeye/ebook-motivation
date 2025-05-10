import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ebookapp/core/constants/constant.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';

import '../model/music_track.dart';
import '../model/wallpaper_model.dart';

class WallpaperMusicController extends GetxController {
  final PageController pageController = PageController();
  final token = RxString('');

  final currentIndex = RxInt(0);

  final isLoadingWallpaper = RxBool(false);
  final wallpapers = RxList<Wallpaper>([]);
  final selectedWallpaper = Rxn<Wallpaper>();
  final videoController = Rxn<VideoPlayerController>();
  final isLoadingPlayer = RxBool(false);

  final isLoadingMusic = RxBool(false);
  final musicPlaylist = RxList<MusicTrack>([]);
  final selectedMusic = Rxn<MusicTrack>();
  final audioPlayer = AudioPlayer(useProxyForRequestHeaders: false);
  final audioPlayerState = Rx<ProcessingState>(ProcessingState.idle);
  final isPlayingAudio = RxBool(false);

  @override
  void onInit() {
    super.onInit();
    _getToken().then((value) => token.value = value ?? '');

    _fetchWallpapers();
    _fetchMusics();

    audioPlayer.playerStateStream.listen((state) {
      audioPlayerState.value = state.processingState;
    });
  }

  @override
  void onClose() {
    super.onClose();
    pageController.dispose();
    audioPlayer.dispose();
    if (videoController.value != null) {
      videoController.value!.dispose();
    }
  }

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  void nextPage() {
    pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    currentIndex.value = pageController.page?.round() ?? 0;
  }

  void prevPage() {
    pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    currentIndex.value = pageController.page?.round() ?? 0;
  }

  void onPageChanged(int index) {
    currentIndex.value = index;
  }

  void _handleError(String message, dynamic error) {
    Get.snackbar(errorTitle, errorDescription);
    debugPrint("Kesalahan: $error");
  }

  Future<void> loadSelections() async {
    final prefs = await SharedPreferences.getInstance();
    int? selectedWallpaperId = prefs.getInt('selectedWallpaperId');
    int? selectedMusicId = prefs.getInt('selectedMusicId');
    if (selectedWallpaperId != null) {
      try {
        selectedWallpaper.value = wallpapers
            .firstWhere((wallpaper) => wallpaper.id == selectedWallpaperId);
      } catch (e) {
        selectedWallpaper.value = null;
      }
    }
    if (selectedMusicId != null) {
      try {
        selectedMusic.value =
            musicPlaylist.firstWhere((music) => music.id == selectedMusicId);
      } catch (e) {
        selectedMusic.value = null;
      }
    }
    debugPrint(
        'Dimuat - Wallpaper: ${selectedWallpaper.value}, Musik: ${selectedMusic.value}');
  }

  Future<void> _fetchWallpapers() async {
    isLoadingWallpaper.value = true;
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

      if (response.statusCode != 200) {
        throw Exception(
            'Gagal memuat wallpaper, status kode: ${response.statusCode}');
      }

      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      final List<dynamic> wallpaperData = jsonResponse['data'];

      wallpapers.value = wallpaperData.map((item) {
        Wallpaper wallpaper = Wallpaper.fromJson(item);
        return wallpaper;
      }).toList();
    } catch (e) {
      _handleError('Gagal mengambil data wallpapers', e);
    } finally {
      loadSelections();
      isLoadingWallpaper.value = false;
    }
  }

  Future<void> selectWallpaper(Wallpaper wallpaper) async {
    selectedWallpaper.value = wallpaper;

    saveSelections();

    if (wallpaper.type != 'video') {
      if (videoController.value != null) {
        videoController.value!.dispose();
      }

      videoController.value = null;
      return;
    }

    isLoadingPlayer.value = true;

    _downloadWallpaper(wallpaper, false).then((file) {
      if (file == null) {
        debugPrint('Gagal mendownload file');
        return;
      }

      if (videoController.value != null) {
        videoController.value!.dispose();
      }

      videoController.value = VideoPlayerController.file(
        file,
        videoPlayerOptions: VideoPlayerOptions(mixWithOthers: false),
      );

      videoController.value!.initialize().then((value) {
        if (videoController.value != null &&
            videoController.value!.value.isInitialized) {
          videoController.value!.play();
          videoController.value!.setVolume(0);
        } else if (!videoController.value!.value.isInitialized) {
          _downloadWallpaper(wallpaper, true);
        }

        isLoadingPlayer.value = false;
      });
    });
  }

  Future<File?> _downloadWallpaper(
      Wallpaper wallpaper, bool replaceExisting) async {
    final permDir = await getApplicationDocumentsDirectory();

    final fileName = wallpaper.type == 'video'
        ? '${wallpaper.id}.mp4'
        : '${wallpaper.id}.jpg';
    final permFile = File('${permDir.path}/wallpapers/$fileName');

    if (!replaceExisting && await permFile.exists()) {
      debugPrint('File sudah ada di: ${permFile.path}');
      return permFile;
    }

    debugPrint('Mendownload video: ${wallpaper.name}');

    final dio = Dio();
    await dio.download(
      wallpaper.fileUrl,
      permFile.path,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ),
    );

    debugPrint('Video berhasil didownload ke: ${permFile.path}');

    return permFile;
  }

  Future<void> _fetchMusics() async {
    isLoadingMusic.value = true;

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

      if (response.statusCode != 200) {
        throw Exception(
            'Gagal memuat musik, status kode: ${response.statusCode}');
      }

      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      final List<dynamic> musicData = jsonResponse['data'];
      musicPlaylist.value =
          musicData.map((item) => MusicTrack.fromJson(item)).toList();
    } catch (e) {
      _handleError('Gagal mengambil data musics', e);
    } finally {
      loadSelections();
      isLoadingMusic.value = false;
    }
  }

  Future<void> selectMusic(MusicTrack music) async {
    try {
      final results = await Future.wait<dynamic>([
        _getToken(),
        getApplicationDocumentsDirectory(),
      ]);

      final token = results[0] as String;
      final dir = results[1] as Directory;

      final localFile = File('${dir.path}/musics/${music.id}.mp3');
      final audioSource = LockCachingAudioSource(Uri.parse(music.fileUrl),
          cacheFile: localFile,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          });

      if ((selectedMusic.value?.id != music.id)) {
        selectedMusic.value = music;

        saveSelections();

        audioPlayer.setAudioSource(audioSource).then((value) {
          audioPlayer.play();
          isPlayingAudio.value = true;
        });
      } else {
        if (audioPlayer.playing) {
          audioPlayer.pause();
          isPlayingAudio.value = false;
        } else {
          if (audioPlayer.audioSource == null) {
            audioPlayer.setAudioSource(audioSource).then((value) {
              audioPlayer.play();
            });
          } else {
            audioPlayer.play();
          }
          isPlayingAudio.value = true;
        }
      }
    } catch (e) {
      _handleError('Failed to select audio', e);
    }
  }

  Future<void> saveSelections() async {
    final prefs = await SharedPreferences.getInstance();

    if (selectedWallpaper.value != null) {
      await prefs.setInt('selectedWallpaperId', selectedWallpaper.value!.id);
      await prefs.setString(
          'selectedWallpaperType', selectedWallpaper.value!.type);
    }

    if (selectedMusic.value != null) {
      await prefs.setInt('selectedMusicId', selectedMusic.value!.id);
    }

    debugPrint(
        'Disimpan - Wallpaper: ${selectedWallpaper.value}, Musik: ${selectedMusic.value}');
  }
}
