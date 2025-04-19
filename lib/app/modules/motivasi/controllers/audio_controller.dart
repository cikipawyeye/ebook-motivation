// import 'dart:async';
// import 'dart:io';
// import 'package:ebookapp/app/modules/wallpaper_music/controllers/wallpaper_music_controller.dart';
// import 'package:ebookapp/core/constants/constant.dart';
// import 'package:flutter/services.dart' show rootBundle;
// import 'package:path_provider/path_provider.dart';
// import 'package:audioplayers/audioplayers.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class AudioController extends GetxController {
//   final WallpaperMusicController wallpaperMusicController = Get.find<WallpaperMusicController>();

//   // Audio Player
//   late AudioPlayer _audioPlayer;

//   // Observable states
//   final RxBool isPlaying = false.obs;
//   final RxString currentTrack = ''.obs;

//   // Volume control
//   final RxDouble audioVolume = 0.5.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     _initializeAudioPlayer();

//     // Tambahkan listener untuk perubahan musik yang dipilih
//     ever(wallpaperMusicController.selectedMusic, (musicTrack) {
//       if (musicTrack.isNotEmpty) {
//         changeTrack(musicTrack);
//       }
//     });
//   }

//   Future<void> _initializeAudioPlayer() async {
//     _audioPlayer = AudioPlayer();

//     try {
//       // Gunakan musik yang sudah dipilih sebelumnya
//       final selectedMusic = wallpaperMusicController.selectedMusic.value;

//       if (selectedMusic.isNotEmpty) {
//         // Set track dari musik yang dipilih
//         currentTrack.value = selectedMusic;

//         // Coba load dari path lokal
//         final localPath = await _getLocalAudioPath(selectedMusic);
//         if (localPath.isNotEmpty) {
//           await _audioPlayer.setSource(DeviceFileSource(localPath));
//         }

//         // Setup listener
//         _setupPlayerListeners();
//       }
//     } catch (e) {
//       _handleAudioError(e);
//     }
//   }

//   void _setupPlayerListeners() {
//     _audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
//       isPlaying.value = state == PlayerState.playing;
//     });

//     _audioPlayer.onPlayerComplete.listen((_) {
//       isPlaying.value = false;
//       // Putar track selanjutnya secara otomatis
//       _playNextTrack();
//     });
//   }

//   Future<String> _getLocalAudioPath(String audioFileName) async {
//     try {
//       // Load bytes dari asset
//       final audioBytes = await rootBundle.load(audioFileName);

//       // Simpan ke direktori sementara
//       final tempDir = await getTemporaryDirectory();
//       final tempFile = File('${tempDir.path}/${audioFileName.split('/').last}');

//       await tempFile.writeAsBytes(
//         audioBytes.buffer.asUint8List(
//           audioBytes.offsetInBytes,
//           audioBytes.lengthInBytes
//         )
//       );

//       return tempFile.path;
//     } catch (e) {
//       print('Audio loading error: $e');
//       return '';
//     }
//   }

//   // Ganti track audio
//   Future<void> changeTrack(String newTrack) async {
//     try {
//       // Pause track saat ini
//       await pause();

//       // Set track baru
//       currentTrack.value = newTrack;

//       // Simpan pilihan musik di WallpaperMusicController
//       await wallpaperMusicController.selectMusic(newTrack);

//       // Load track baru
//       final localPath = await _getLocalAudioPath(newTrack);
//       if (localPath.isNotEmpty) {
//         await _audioPlayer.setSource(DeviceFileSource(localPath));

//         // Atur volume
//         await _audioPlayer.setVolume(audioVolume.value);

//         await play();
//       }
//     } catch (e) {
//       _handleAudioError(e);
//     }
//   }

//   // Putar track selanjutnya secara otomatis
//   void _playNextTrack() {
//     // Gunakan daftar musik dari WallpaperMusicController
//     final musicTracks = AssetPaths.musicTracks;

//     if (musicTracks.isEmpty) return;

//     // Cari index track saat ini
//     final currentIndex = musicTracks.indexWhere((track) => track == currentTrack.value);

//     // Hitung index track berikutnya
//     final nextIndex = currentIndex == -1
//         ? 0
//         : (currentIndex + 1) % musicTracks.length;

//     // Ganti ke track berikutnya
//     changeTrack(musicTracks[nextIndex]);
//   }

//   // Toggle play/pause
//   Future<void> togglePlayPause() async {
//     try {
//       if (isPlaying.value) {
//         await pause();
//       } else {
//         await play();
//       }
//     } catch (e) {
//       _handleAudioError(e);
//     }
//   }

//   // Play music
//   Future<void> play() async {
//     try {
//       await _audioPlayer.resume();
//       isPlaying.value = true;
//     } catch (e) {
//       _handleAudioError(e);
//     }
//   }

//   // Pause music
//   Future<void> pause() async {
//     try {
//       await _audioPlayer.pause();
//       isPlaying.value = false;
//     } catch (e) {
//       _handleAudioError(e);
//     }
//   }

//   // Kontrol Volume
//   void setVolume(double volume) {
//     audioVolume.value = volume.clamp(0.0, 1.0);
//     _audioPlayer.setVolume(audioVolume.value);
//     wallpaperMusicController.setAudioVolume(audioVolume.value);
//   }

//   // Error handling
//   void _handleAudioError(dynamic error) {
//     debugPrint('Audio Error: $error');
//     Get.snackbar(
//       'Audio Error',
//       error.toString(),
//       snackPosition: SnackPosition.BOTTOM,
//       backgroundColor: Colors.red,
//       colorText: Colors.white,
//     );
//   }

//   @override
//   void onClose() {
//     _audioPlayer.dispose();
//     super.onClose();
//   }
// }

import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:ebookapp/app/modules/wallpaper_music/controllers/wallpaper_music_controller.dart';
import 'package:ebookapp/core/constants/constant.dart';
import 'package:path_provider/path_provider.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../wallpaper_music/model/music_track.dart';

class AudioController extends GetxController {
  final WallpaperMusicController wallpaperMusicController =
      Get.find<WallpaperMusicController>();

  // Audio Player
  late AudioPlayer _audioPlayer;

  // Observable states
  final RxBool isPlaying = false.obs;
  final RxString currentTrackUrl = ''.obs;
  final RxString currentTrackTitle = ''.obs;

  // Volume control
  final RxDouble audioVolume = 0.5.obs;

  @override
  void onInit() {
    super.onInit();
    _initializeAudioPlayer();

    // Listen to changes in the selected music track from the controller
    ever(wallpaperMusicController.selectedMusicId, (musicId) {
      if (musicId != null) {
        final track = wallpaperMusicController.musicPlaylist
            .firstWhere((track) => track.id == musicId);
        changeTrack(track); // Use the MusicTrack object directly
      }
    });
  }

  Future<void> _initializeAudioPlayer() async {
    debugPrint('Initializing audio player...');
    _audioPlayer = AudioPlayer();
    final prefs = await SharedPreferences.getInstance();
    final int? selectedMusic = prefs.getInt('selectedMusicId');

    try {
      // Use the currently selected music
      if (selectedMusic != null) {
        debugPrint('Selected music ID: $selectedMusic');
        // Load audio from local storage or download it
        final localPath = await _getLocalAudioPath(selectedMusic);
        if (localPath.isNotEmpty) {
          await _audioPlayer.setSource(DeviceFileSource(localPath));
        }
      } else {
        debugPrint('No selected music, loading default track...');
        // Load audio from local asset
        await _audioPlayer.setSource(AssetSource(
            AssetPaths.musicTracks.first.replaceAll('assets/', '')));
      }

      // Setup listeners
      await _setupPlayerListeners();

      // await play();
    } catch (e) {
      _handleAudioError(e);
    }
  }

  Future<void> _setupPlayerListeners() async {
    _audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
      isPlaying.value = state == PlayerState.playing;
    });

    await Future.wait([
      _audioPlayer.setVolume(audioVolume.value),
      _audioPlayer.setReleaseMode(ReleaseMode.loop),
    ]);
    // _audioPlayer.onPlayerComplete.listen((_) {
    //   isPlaying.value = false;
    //   // Automatically play the next track
    //   _playNextTrack();
    // });
  }

  Future<String> _getLocalAudioPath(int musicId) async {
    try {
      final permDir = await getApplicationDocumentsDirectory();
      final permFile = File('${permDir.path}/musics/$musicId.mp3');

      if (await permFile.exists()) {
        return permFile.path;
      }

      final tempDir = await getTemporaryDirectory();
      final tempFile = File('${tempDir.path}/musics/$musicId.mp3');

      if (await tempFile.exists()) {
        return tempFile.path;
      }

      // Kalau tidak ada, download baru
      debugPrint('Music tidak ditemukan, mulai download...');
      await _downloadMusic(musicId, permFile);
      debugPrint(
          'Music berhasil didownload ke storage permanen: ${permFile.path}');
      return permFile.path;
    } catch (e) {
      debugPrint('Audio loading error: $e');
      return '';
    }
  }

  // Change audio track
  Future<void> changeTrack(MusicTrack newTrack) async {
    try {
      // Pause the current track
      await pause();

      // Set the new track details
      currentTrackUrl.value = newTrack.fileUrl;
      currentTrackTitle.value = newTrack.title;

      // Load the new track
      final localPath = await _getLocalAudioPath(newTrack.id);
      if (localPath.isNotEmpty) {
        await _audioPlayer.setSource(DeviceFileSource(localPath));

        // Set volume
        await _audioPlayer.setVolume(audioVolume.value);

        await play();
      }
    } catch (e) {
      _handleAudioError(e);
    }
  }

  // Automatically play the next track
  void _playNextTrack() {
    // Use the playlist from WallpaperMusicController
    final musicTracks = wallpaperMusicController.musicPlaylist;

    if (musicTracks.isEmpty) return;

    // Find the index of the current track
    final currentIndex = musicTracks
        .indexWhere((track) => track.fileUrl == currentTrackUrl.value);

    // Calculate the next track's index
    final nextIndex =
        currentIndex == -1 ? 0 : (currentIndex + 1) % musicTracks.length;

    // Change to the next track
    changeTrack(musicTracks[nextIndex]);
  }

  // Toggle play/pause
  Future<void> togglePlayPause() async {
    debugPrint('Toggle play/pause: ${isPlaying.value}');
    try {
      if (isPlaying.value) {
        await pause();
      } else {
        await play();
      }
    } catch (e) {
      _handleAudioError(e);
    }
  }

  // Play music
  Future<void> play() async {
    try {
      await _audioPlayer.resume();
      isPlaying.value = true;
    } catch (e) {
      _handleAudioError(e);
    }
  }

  // Pause music
  Future<void> pause() async {
    try {
      await _audioPlayer.pause();
      isPlaying.value = false;
    } catch (e) {
      _handleAudioError(e);
    }
  }

  // Volume control
  void setVolume(double volume) {
    audioVolume.value = volume.clamp(0.0, 1.0);
    _audioPlayer.setVolume(audioVolume.value);
    wallpaperMusicController.setAudioVolume(audioVolume.value);
  }

  // Error handling
  void _handleAudioError(dynamic error) {
    debugPrint('Audio Error: $error');
    Get.snackbar(
      'Audio Error',
      error.toString(),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }

  Future<void> _downloadMusic(int musicId, File saveAs) async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token')!;

    final response = await http.get(
      Uri.parse('$baseUrl/api/v1/musics/$musicId'),
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
    debugPrint('Video berhasil didownload ke: ${saveAs.path}');
  }

  @override
  void onClose() {
    debugPrint('AudioController closed');
    _audioPlayer.stop();
    _audioPlayer.dispose();
    super.onClose();
  }
}
