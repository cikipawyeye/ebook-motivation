import 'package:ebookapp/app/modules/wallpaper_music/controllers/wallpaper_music_controller.dart';
import 'package:ebookapp/app/modules/wallpaper_music/widgets/music_item.dart';
import 'package:ebookapp/app/modules/wallpaper_music/widgets/wallpaper_item.dart';
import 'package:ebookapp/core/constants/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class WallpaperMusicView extends GetView<WallpaperMusicController> {
  const WallpaperMusicView({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          return;
        }

        if (controller.currentIndex.value > 0) {
          controller.prevPage();
          controller.audioPlayer.pause();
          controller.audioPlayer.seek(Duration.zero);
          controller.isPlayingAudio.value = false;
        } else {
          Get.back();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/Template.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
              child: Column(
            children: [
              Expanded(
                child: PageView(
                  controller: controller.pageController,
                  onPageChanged: controller.onPageChanged,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _buildWallpaperSelection(),
                    _buildMusicSelection(),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              _buildIndicator(),
              const SizedBox(height: 10),
              _buildNavigationButton(context),
            ],
          )),
        ),
      ),
    );
  }

  Widget _buildIndicator() {
    return SmoothPageIndicator(
      controller: controller.pageController,
      count: 2,
      effect: const WormEffect(
        activeDotColor: colorBackground,
        dotColor: Colors.grey,
        dotHeight: 8,
        dotWidth: 8,
      ),
    );
  }

  Widget _buildNavigationButton(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(bottom: 20, left: 20, right: 20),
        child: ElevatedButton(
          onPressed: () async {
            if (controller.currentIndex.value == 1) {
              // Jika ini halaman kedua (musical selection)
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setBool(
                  'isNewUser', false); // Set pengguna baru menjadi false

              // Arahkan ke halaman /home dan refresh data pengguna
              Get.offNamed('/home');
            } else {
              // Jika halaman pertama (wallpaper selection)
              controller.nextPage();
            }
          },
          style: ElevatedButton.styleFrom(
            minimumSize: Size(180, 40),
            backgroundColor: Colors.white.withValues(alpha: 0.3),
          ),
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 26),
              child: Obx(() {
                return Text(
                  controller.currentIndex.value == 1
                      ? 'Selesai'
                      : 'Selanjutnya',
                  style: GoogleFonts.leagueSpartan(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                );
              })),
        ));
  }

  Widget _buildWallpaperSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Silahkan pilih wallpapernya...',
                  style: GoogleFonts.leagueSpartan(
                      fontSize: 24, color: Colors.white),
                  textAlign: TextAlign.left,
                ),
              ],
            )),
        const SizedBox(height: 20),
        Obx(() {
          if (controller.isLoadingWallpaper.value) {
            return const Expanded(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

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
                      return WallpaperItem(controller, wallpaper);
                    },
                  ),
          );
        }),
      ],
    );
  }

  Widget _buildMusicSelection() {
    return Padding(
        padding: EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMusicHeader(),
            const SizedBox(height: 26),
            _buildMusicContent(),
          ],
        ));
  }

  Widget _buildMusicHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pilih audionya juga yaa...',
          style: GoogleFonts.leagueSpartan(fontSize: 24, color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildMusicContent() {
    return Obx(() {
      if (controller.isLoadingMusic.value) {
        return const Expanded(
          child: Center(
            child: CircularProgressIndicator(
              color: colorBackground,
            ),
          ),
        );
      }

      if (controller.musicPlaylist.isEmpty) {
        return _buildEmptyState();
      }

      return Expanded(
        child: ListView.separated(
          itemCount: controller.musicPlaylist.length,
          separatorBuilder: (context, index) => const SizedBox(height: 8),
          itemBuilder: (context, index) =>
              MusicItem(controller, controller.musicPlaylist[index]),
        ),
      );
    });
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
}
