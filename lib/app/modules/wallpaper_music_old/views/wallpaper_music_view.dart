import 'package:ebookapp/core/constants/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import '../controllers/wallpaper_music_controller.dart';
import '../model/music_track.dart';
import '../model/wallpaper_model.dart';

class WallpaperMusicView extends StatefulWidget {
  const WallpaperMusicView({super.key});

  @override
  _WallpaperMusicViewState createState() => _WallpaperMusicViewState();
}

class _WallpaperMusicViewState extends State<WallpaperMusicView>
    with AutomaticKeepAliveClientMixin {
  final PageController _pageController = PageController();
  final RxInt _currentPage = 0.obs;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    _pageController.addListener(() {
      if (_pageController.page != null) {
        _currentPage.value =
            _pageController.page!.round(); // Update nilai halaman
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return GetBuilder<WallpaperMusicController>(
        dispose: (state) {
          Get.delete<WallpaperMusicController>();
        },
        builder: (controller) => Scaffold(
              backgroundColor: Colors.white,
              body: PopScope(
                canPop: false,
                onPopInvokedWithResult: (didPop, result) {
                  if (didPop) {
                    return;
                  }

                  int currentPage = _pageController.page?.round() ?? 0;

                  if (currentPage > 0) {
                    _pageController.previousPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  } else {
                    Get.back();
                  }
                },
                child: SafeArea(
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/Template.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: PageView(
                            controller: _pageController,
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              _buildWallpaperSelection(controller),
                              _buildMusicSelection(controller),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        _buildIndicator(),
                        const SizedBox(height: 10),
                        _buildNavigationButton(controller),
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }

  Widget _buildIndicator() {
    return SmoothPageIndicator(
      controller: _pageController,
      count: 2,
      effect: const WormEffect(
        activeDotColor: colorBackground,
        dotColor: Colors.grey,
        dotHeight: 8,
        dotWidth: 8,
      ),
    );
  }

  Widget _buildNavigationButton(WallpaperMusicController controller) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
        padding: EdgeInsets.only(bottom: 20, left: 20, right: 20),
        child: SizedBox(
          width: screenWidth,
          child: ElevatedButton(
            onPressed: () async {
              if (_pageController.page == 1) {
                // Jika ini halaman kedua (musical selection)
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setBool(
                    'isNewUser', false); // Set pengguna baru menjadi false

                // Arahkan ke halaman /home dan refresh data pengguna
                Get.offNamed('/home', arguments: {'refresh': true})?.then(
                    (onValue) => {Get.delete<WallpaperMusicController>()});
              } else {
                // Jika halaman pertama (wallpaper selection)
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              }
            },
            style: ElevatedButton.styleFrom(
              minimumSize: Size(screenWidth, 50),
              backgroundColor: colorBackground,
            ),
            child: Obx(() {
              return Text(
                _currentPage.value == 1 ? 'Selesai' : 'Selanjutnya',
                style: const TextStyle(color: Colors.white),
              );
            }),
          ),
        ));
  }

  Widget _buildWallpaperSelection(WallpaperMusicController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pilih Wallpapermu!',
                  style: GoogleFonts.leagueSpartan(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  textAlign: TextAlign.left,
                ),
                Text(
                  'Kamu bisa memilih wallpaper yang paling kamu suka loh.\nagar menambah pengalamanmu saat membaca',
                  style: GoogleFonts.leagueSpartan(
                      fontSize: 14, color: Colors.white),
                  textAlign: TextAlign.left,
                ),
              ],
            )),
        const SizedBox(height: 20),
        Obx(() {
          if (controller.wallpaperStatus.value == WallpaperStatus.loading) {
            return const Expanded(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          // TODO: Error per video card
          // if (controller.wallpaperStatus.value == WallpaperStatus.error) {
          //   return Expanded(
          //     child: Center(
          //       child: Text(
          //         'Error: ${controller.errorMessage.value}',
          //         style: const TextStyle(color: Colors.red),
          //       ),
          //     ),
          //   );
          // }

          final wallpapers = controller.wallpapers;
          return Expanded(
            child: wallpapers.isEmpty
                ? const Center(child: Text("Tidak ada wallpaper tersedia"))
                : GridView.builder(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    scrollDirection: Axis.horizontal,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1.3,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: wallpapers.length,
                    itemBuilder: (context, index) {
                      final wallpaper = wallpapers[index];
                      return _buildWallpaperItem(controller, wallpaper);
                    },
                  ),
          );
        }),
      ],
    );
  }

  Widget _buildWallpaperItem(
      WallpaperMusicController controller, Wallpaper wallpaper) {
    final isSelected = controller.selectedWallpaperId.value == wallpaper.id;

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
        child: wallpaper.type == 'video'
            ? _buildVideoPlayer(controller, wallpaper.fileUrl, isSelected)
            : _buildImageTile(controller, wallpaper.fileUrl, isSelected),
      ),
    );
  }

  Widget _buildImageTile(WallpaperMusicController controller,
      String thumbnailUrl, bool isSelected) {
    String token = controller.token.value;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.network(
          thumbnailUrl,
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

  Widget _buildVideoPlayer(
      WallpaperMusicController controller, String videoUrl, bool isSelected) {
    VideoPlayerController? videoController =
        controller.getVideoController(videoUrl);

    if (videoController == null) {
      return const Center(child: CircularProgressIndicator());
    }

    // Control video playback based on selection state
    if (isSelected) {
      videoController.play();
    } else {
      videoController.pause();
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.black,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: AspectRatio(
          aspectRatio: 16 / 9, // You can adjust this based on your video
          child: Stack(
            alignment: Alignment.center,
            children: [
              VideoPlayer(videoController), // Using BetterPlayer
              if (isSelected)
                CircleAvatar(
                  backgroundColor: Colors.black54,
                  child: Icon(
                    isSelected ? Icons.pause : Icons.play_arrow,
                    color: Colors.white,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMusicSelection(WallpaperMusicController controller) {
    return Padding(
        padding: EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMusicHeader(),
            const SizedBox(height: 20),
            _buildMusicContent(controller),
          ],
        ));
  }

  Widget _buildMusicHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ayo pilih lagumu!',
          style: GoogleFonts.leagueSpartan(
            fontSize: 34,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        Text(
          'Musik ini akan diputar saat kamu sedang membuka bacaan jadi pilih sesuai mood mu ya!',
          style: GoogleFonts.leagueSpartan(
            fontSize: 14,
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _buildMusicContent(WallpaperMusicController controller) {
    return Obx(() {
      if (controller.musicStatus.value == WallpaperStatus.loading) {
        return _buildCenteredLoader();
      }

      if (controller.musicStatus.value == WallpaperStatus.error) {
        return _buildErrorMessage(controller);
      }

      if (controller.musicPlaylist.isEmpty) {
        return _buildEmptyState();
      }

      return Expanded(
        child: ListView.separated(
          itemCount: controller.musicPlaylist.length,
          separatorBuilder: (context, index) => const SizedBox(height: 6),
          itemBuilder: (context, index) =>
              _buildMusicItem(controller, controller.musicPlaylist[index]),
        ),
      );
    });
  }

  Widget _buildCenteredLoader() {
    return const Expanded(
      child: Center(
        child: CircularProgressIndicator(
          color: colorBackground,
        ),
      ),
    );
  }

  Widget _buildErrorMessage(WallpaperMusicController controller) {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 50,
            ),
            const SizedBox(height: 10),
            Text(
              'Ups! Terjadi Kesalahan',
              style: GoogleFonts.leagueSpartan(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            Text(
              controller.errorMessage.value,
              style: GoogleFonts.leagueSpartan(
                fontSize: 14,
                color: Colors.black54,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.music_off,
              color: Colors.grey,
              size: 50,
            ),
            const SizedBox(height: 10),
            Text(
              'Tidak Ada Musik Tersedia',
              style: GoogleFonts.leagueSpartan(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            Text(
              'Kami akan segera menambahkan musik baru',
              style: GoogleFonts.leagueSpartan(
                fontSize: 14,
                color: Colors.black54,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMusicItem(
      WallpaperMusicController controller, MusicTrack musicTrack) {
    final isSelected = controller.selectedMusicId.value == musicTrack.id;

    return GestureDetector(
      onTap: () => controller.selectMusic(musicTrack),
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
                  musicTrack.title,
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
                    getMusicControllerIcon(isSelected, controller),
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
  }

  IconData getMusicControllerIcon(
      bool isSelected, WallpaperMusicController controller) {
    if (!isSelected) {
      return Icons.play_arrow;
    }

    if (controller.audioPlayer.playerState.processingState ==
            ProcessingState.loading ||
        controller.audioPlayer.playerState.processingState ==
            ProcessingState.buffering) {
      return Icons.hourglass_empty;
    }

    if (controller.audioPlayer.playing) {
      return Icons.pause;
    } else {
      return Icons.play_arrow;
    }
  }
}
