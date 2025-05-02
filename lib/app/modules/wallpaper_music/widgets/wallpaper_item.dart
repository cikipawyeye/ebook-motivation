import 'package:ebookapp/app/modules/wallpaper_music/controllers/wallpaper_music_controller.dart';
import 'package:ebookapp/app/modules/wallpaper_music/model/wallpaper_model.dart';
import 'package:ebookapp/core/constants/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class WallpaperItem extends StatelessWidget {
  final WallpaperMusicController controller;
  final Wallpaper wallpaper;

  const WallpaperItem(
    this.controller,
    this.wallpaper, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isSelected = controller.selectedWallpaper.value?.id == wallpaper.id;

      return GestureDetector(
        onTap: () {
          // Memilih wallpaper saat diklik.
          controller.selectWallpaper(wallpaper);
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: isSelected ? colorBackground : Colors.grey,
              width: isSelected ? 2 : 1,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              _buildImageTile(wallpaper, isSelected),
              _buildVideoPlayer(wallpaper, isSelected)
            ],
          ),
        ),
      );
    });
  }

  Widget _buildImageTile(Wallpaper wallpaper, bool isSelected) {
    String token = controller.token.value;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(13),
        child: Image.network(
          wallpaper.thumbnailUrl,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(child: CircularProgressIndicator());
          },
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colors.grey, // Placeholder color
              child: const Icon(Icons.error),
            );
          },
        ),
      ),
    );
  }

  Widget _buildVideoPlayer(Wallpaper wallpaper, bool isSelected) {
    if (!isSelected || wallpaper.type != 'video') {
      return SizedBox.shrink(); // Hide video player if not selected
    }

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(13),
        child: !controller.isLoadingPlayer.value
            ? FittedBox(
                fit: BoxFit.cover,
                alignment: Alignment.center,
                child: SizedBox(
                  width: controller.videoController.value!.value.size.width,
                  height: controller.videoController.value!.value.size.height,
                  child: VideoPlayer(controller.videoController.value!),
                ))
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
