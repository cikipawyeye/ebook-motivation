import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:ebookapp/app/modules/splash_screen/controllers/background_audio_controller.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:ebookapp/core/constants/constant.dart';
import 'package:path_provider/path_provider.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../wallpaper_music/model/music_track.dart';

class AudioController extends GetxController {
  // Audio Player
  late AudioPlayer _audioPlayer;

  // Observable states
  final RxBool isPlaying = false.obs;
  final RxString currentTrackUrl = ''.obs;
  final RxString currentTrackTitle = ''.obs;

  // Volume control
  final RxDouble audioVolume = 0.5.obs;

  final BackgroundAudioController _backgroundAudioController =
      Get.find<BackgroundAudioController>();

  @override
  void onInit() {
    super.onInit();
    _backgroundAudioController.pause();
    _initializeAudioPlayer();
  }

  Future<void> _initializeAudioPlayer() async {
    debugPrint('Initializing audio player...');
    AudioLogger.logLevel = AudioLogLevel.none;
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
    await Future.wait([
      _audioPlayer.setVolume(audioVolume.value),
      _audioPlayer.setReleaseMode(ReleaseMode.loop),
    ]);

    await _audioPlayer.resume();
    isPlaying.value = true;
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

  Future<void> pauseByApp() async {
    await _audioPlayer.pause();
  }

  getState() {
    return _audioPlayer.state;
  }

  // Volume control
  void setVolume(double volume) {
    audioVolume.value = volume.clamp(0.0, 1.0);
    _audioPlayer.setVolume(audioVolume.value);
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
    _backgroundAudioController.resume();
    super.onClose();
  }
}
