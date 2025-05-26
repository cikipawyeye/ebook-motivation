import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BackgroundAudioController extends GetxController {
  static BackgroundAudioController get to => Get.find();

  final AudioPlayer _player = AudioPlayer();
  var isPlaying = false.obs;

  Future<void> play() async {
    try {
      await _player.setReleaseMode(ReleaseMode.loop);
      await _player.play(AssetSource('audio/PenyejukHati1.mp3'));
      isPlaying.value = true;
    } catch (e) {
      debugPrint('Error playing audio: $e');
    }
  }

  Future<void> pause() async {
    await _player.pause();
    isPlaying.value = false;
  }

  Future<void> resume() async {
    await _player.resume();
    isPlaying.value = true;
  }

  Future<void> stop() async {
    await _player.stop();
    isPlaying.value = false;
  }

  @override
  void onClose() {
    _player.dispose();
    super.onClose();
  }
}
