import 'package:ebookapp/app/modules/wallpaper_music/controllers/wallpaper_music_controller.dart';
import 'package:ebookapp/app/modules/wallpaper_music/model/music_track.dart';
import 'package:ebookapp/core/constants/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';

class MusicItem extends StatelessWidget {
  final WallpaperMusicController controller;
  final MusicTrack music;

  const MusicItem(this.controller, this.music, {super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isSelected = controller.selectedMusic.value?.id == music.id;

      return GestureDetector(
        onTap: () {
          controller.selectMusic(music);
        },
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isSelected
                  ? [
                      colorBackground.withValues(alpha: 0.9),
                      colorBackground.withValues(alpha: 0.1)
                    ]
                  : [
                      Colors.white.withValues(alpha: 0.3),
                      Colors.white.withValues(alpha: 0.3)
                    ],
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected
                  ? colorBackground
                  : Colors.black.withValues(alpha: 0.3),
              width: 1.5,
            ),
          ),
          child: Row(
            children: [
              // Title
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Text(
                    music.title,
                    style: GoogleFonts.leagueSpartan(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),

              // Play/Pause Button
              Padding(
                padding: EdgeInsets.only(top: 2, bottom: 2),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: 37,
                  height: 37,
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? colorBackground
                        : Colors.black.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Icon(
                      getMusicControllerIcon(isSelected),
                      color: isSelected ? Colors.white : colorBackground,
                      size: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  IconData getMusicControllerIcon(bool isSelected) {
    if (!isSelected) {
      return Icons.play_arrow;
    }

    if (controller.audioPlayerState.value == ProcessingState.loading ||
        controller.audioPlayerState.value == ProcessingState.buffering) {
      return Icons.hourglass_empty;
    }

    if (controller.isPlayingAudio.value) {
      return Icons.pause;
    } else {
      return Icons.play_arrow;
    }
  }
}
