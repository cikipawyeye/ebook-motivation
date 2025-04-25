// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:video_player/video_player.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';
// import 'package:google_fonts/google_fonts.dart';

// import '../controllers/wallpaper_music_controller.dart';

// class WallpaperMusicView extends StatefulWidget {
//   const WallpaperMusicView({Key? key}) : super(key: key);

//   @override
//   _WallpaperMusicViewState createState() => _WallpaperMusicViewState();
// }

// class _WallpaperMusicViewState extends State<WallpaperMusicView>
//     with AutomaticKeepAliveClientMixin {
//   final PageController _pageController = PageController();

//   @override
//   bool get wantKeepAlive => true;

//   @override
//   void initState() {
//     super.initState();

//     // Nonaktifkan rotasi layar
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitUp,
//       DeviceOrientation.portraitDown,
//     ]);
//   }

//   @override
//   void dispose() {
//     _pageController.dispose();

//     // Kembalikan orientasi layar default
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.landscapeRight,
//       DeviceOrientation.landscapeLeft,
//       DeviceOrientation.portraitUp,
//       DeviceOrientation.portraitDown,
//     ]);

//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     super.build(context);
//     return GetBuilder<WallpaperMusicController>(
//       builder: (controller) => Scaffold(
//         backgroundColor: Colors.white,
//         appBar: _buildAppBar(),
//         body: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.all(20),
//             child: Column(
//               children: [
//                 Expanded(
//                   child: PageView(
//                     controller: _pageController,
//                     physics: const NeverScrollableScrollPhysics(),
//                     children: [
//                       _buildWallpaperSelection(controller),
//                       _buildMusicSelection(controller),
//                     ],
//                   ),
//                 ),
//                 _buildIndicator(),
//                 const SizedBox(height: 10),
//                 _buildNavigationButton(controller),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   PreferredSizeWidget _buildAppBar() {
//     return AppBar(
//       backgroundColor: Colors.white,
//       elevation: 0,
//       leading: IconButton(
//         icon: const Icon(Icons.arrow_back, color: Colors.black),
//         onPressed: () => Get.back(),
//       ),
//       title: Text(
//         'Pilih Wallpaper & Musik',
//         style: GoogleFonts.leagueSpartan(color: Colors.black),
//       ),
//     );
//   }

//   Widget _buildIndicator() {
//     return SmoothPageIndicator(
//       controller: _pageController,
//       count: 2,
//       effect: const WormEffect(
//         activeDotColor: Colors.blue,
//         dotColor: Colors.grey,
//         dotHeight: 8,
//         dotWidth: 8,
//       ),
//     );
//   }

//   Widget _buildNavigationButton(WallpaperMusicController controller) {
//     return ElevatedButton(
//       onPressed: () {
//         if (_pageController.page == 1) {
//           Get.back();
//         } else {
//           _pageController.nextPage(
//             duration: const Duration(milliseconds: 300),
//             curve: Curves.easeInOut,
//           );
//         }
//       },
//       style: ElevatedButton.styleFrom(
//         minimumSize: const Size(double.infinity, 50),
//         backgroundColor: Colors.blue,
//       ),
//       child: Text(
//         _pageController.hasClients && _pageController.page == 1
//             ? 'Selesai'
//             : 'Selanjutnya',
//         style: const TextStyle(color: Colors.white),
//       ),
//     );
//   }

//   Widget _buildWallpaperSelection(WallpaperMusicController controller) {
//     return Column(
//       children: [
//         Text(
//           'Pilih Wallpaper',
//           style: GoogleFonts.leagueSpartan(fontSize: 24),
//         ),
//         Obx(() {
//           // Tampilkan indikator loading jika sedang menginisialisasi video
//           if (controller.isVideoInitializing.value) {
//             return const Expanded(
//               child: Center(
//                 child: CircularProgressIndicator(),
//               ),
//             );
//           }

//           return Expanded(
//             child: controller.wallpapers.isEmpty
//                 ? const Center(child: Text("Tidak ada wallpaper tersedia"))
//                 : GridView.builder(
//                     gridDelegate:
//                         const SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 3,
//                       childAspectRatio: 0.7,
//                       crossAxisSpacing: 8,
//                       mainAxisSpacing: 8,
//                     ),
//                     itemCount: controller.wallpapers.length,
//                     itemBuilder: (context, index) {
//                       final wallpaper = controller.wallpapers[index];
//                       return _buildWallpaperItem(controller, wallpaper);
//                     },
//                   ),
//           );
//         }),
//       ],
//     );
//   }

//   Widget _buildWallpaperItem(
//       WallpaperMusicController controller, String wallpaper) {
//     final isSelected = controller.selectedWallpaper.value == wallpaper;

//     return GestureDetector(
//       onTap: () => controller.selectWallpaper(wallpaper),
//       child: Container(
//         decoration: BoxDecoration(
//           border: Border.all(
//             color: isSelected ? Colors.blue : Colors.grey,
//             width: isSelected ? 2 : 1,
//           ),
//           borderRadius: BorderRadius.circular(15),
//           image: !wallpaper.endsWith('.mp4')
//               ? DecorationImage(
//                   image: AssetImage(wallpaper),
//                   fit: BoxFit.cover,
//                 )
//               : null,
//         ),
//         child: wallpaper.endsWith('.mp4')
//             ? _buildVideoPlayer(controller, wallpaper)
//             : null,
//       ),
//     );
//   }

//   Widget _buildVideoPlayer(
//       WallpaperMusicController controller, String wallpaper) {
//     final videoController = controller.getVideoController(wallpaper);

//     if (videoController == null || !videoController.value.isInitialized) {
//       return const Center(child: CircularProgressIndicator());
//     }

//     return AspectRatio(
//       aspectRatio: videoController.value.aspectRatio,
//       child: VideoPlayer(videoController),
//     );
//   }

//   Widget _buildMusicSelection(WallpaperMusicController controller) {
//     return Column(
//       children: [
//         Text(
//           'Pilih Musik',
//           style: GoogleFonts.leagueSpartan(fontSize: 24),
//         ),
//         Expanded(
//           child: controller.musicTracks.isEmpty
//               ? const Center(child: Text("Tidak ada musik tersedia"))
//               : ListView.builder(
//                   itemCount: controller.musicTracks.length,
//                   itemBuilder: (context, index) {
//                     final musicTrack = controller.musicTracks[index];
//                     final isSelected =
//                         controller.selectedMusic.value == musicTrack;

//                     return ListTile(
//                       title: Text('Lagu ${index + 1}'),
//                       trailing: isSelected
//                           ? const Icon(Icons.check, color: Colors.blue)
//                           : null,
//                       onTap: () {
//                         controller.selectMusic(musicTrack);
//                       },
//                     );
//                   },
//                 ),
//         ),
//       ],
//     );
//   }
// }

// import 'package:ebookapp/core/constants/constant.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:video_player/video_player.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';
// import 'package:google_fonts/google_fonts.dart';

// import '../controllers/wallpaper_music_controller.dart';

// class WallpaperMusicView extends StatefulWidget {
//   const WallpaperMusicView({Key? key}) : super(key: key);

//   @override
//   _WallpaperMusicViewState createState() => _WallpaperMusicViewState();
// }

// class _WallpaperMusicViewState extends State<WallpaperMusicView>
//     with AutomaticKeepAliveClientMixin {
//   final PageController _pageController = PageController();

//   @override
//   bool get wantKeepAlive => true;

//   @override
//   void initState() {
//     super.initState();
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitUp,
//       DeviceOrientation.portraitDown,
//     ]);
//   }

//   @override
//   void dispose() {
//     _pageController.dispose();
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.landscapeRight,
//       DeviceOrientation.landscapeLeft,
//       DeviceOrientation.portraitUp,
//       DeviceOrientation.portraitDown,
//     ]);
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     super.build(context);
//     return GetBuilder<WallpaperMusicController>(
//       builder: (controller) => Scaffold(
//         backgroundColor: Colors.white,
//         appBar: _buildAppBar(),
//         body: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.all(20),
//             child: Column(
//               children: [
//                 Expanded(
//                   child: PageView(
//                     controller: _pageController,
//                     physics: const NeverScrollableScrollPhysics(),
//                     children: [
//                       _buildWallpaperSelection(controller),
//                       _buildMusicSelection(controller),
//                     ],
//                   ),
//                 ),
//                 _buildIndicator(),
//                 const SizedBox(height: 10),
//                 _buildNavigationButton(controller),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   PreferredSizeWidget _buildAppBar() {
//     return AppBar(
//       backgroundColor: Colors.white,
//       elevation: 0,
//       leading: IconButton(
//         icon: const Icon(Icons.arrow_back, color: Colors.black),
//         onPressed: () => Get.back(),
//       ),
//       title: Text(
//         'Pilih Wallpaper & Musik',
//         style: GoogleFonts.leagueSpartan(color: Colors.black),
//       ),
//     );
//   }

//   Widget _buildIndicator() {
//     return SmoothPageIndicator(
//       controller: _pageController,
//       count: 2,
//       effect: const WormEffect(
//         activeDotColor: colorBackground,
//         dotColor: Colors.grey,
//         dotHeight: 8,
//         dotWidth: 8,
//       ),
//     );
//   }

//   Widget _buildNavigationButton(WallpaperMusicController controller) {
//     return ElevatedButton(
//       onPressed: () {
//         if (_pageController.page == 1) {
//           Get.back();
//         } else {
//           _pageController.nextPage(
//             duration: const Duration(milliseconds: 300),
//             curve: Curves.easeInOut,
//           );
//         }
//       },
//       style: ElevatedButton.styleFrom(
//         minimumSize: const Size(double.infinity, 50),
//         backgroundColor: colorBackground,
//       ),
//       child: Text(
//         _pageController.hasClients && _pageController.page == 1
//             ? 'Selesai'
//             : 'Selanjutnya',
//         style: const TextStyle(color: Colors.white),
//       ),
//     );
//   }

//   Widget _buildWallpaperSelection(WallpaperMusicController controller) {
//     return Column(
//       children: [
//         Text(
//           'Pilih Wallpaper',
//           style: GoogleFonts.leagueSpartan(fontSize: 24),
//         ),
//         Obx(() {
//           // Gunakan wallpaperStatus untuk penanganan loading
//           if (controller.wallpaperStatus.value == WallpaperStatus.loading) {
//             return const Expanded(
//               child: Center(
//                 child: CircularProgressIndicator(),
//               ),
//             );
//           }

//           // Penanganan error
//           if (controller.wallpaperStatus.value == WallpaperStatus.error) {
//             return Expanded(
//               child: Center(
//                 child: Text(
//                   'Error: ${controller.errorMessage.value}',
//                   style: const TextStyle(color: Colors.red),
//                 ),
//               ),
//             );
//           }

//           return Expanded(
//             child: AssetPaths.wallpapers.isEmpty
//                 ? const Center(child: Text("Tidak ada wallpaper tersedia"))
//                 : GridView.builder(
//                     gridDelegate:
//                         const SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 3,
//                       childAspectRatio: 0.7,
//                       crossAxisSpacing: 8,
//                       mainAxisSpacing: 8,
//                     ),
//                     itemCount: AssetPaths.wallpapers.length,
//                     itemBuilder: (context, index) {
//                       final wallpaper = AssetPaths.wallpapers[index];
//                       return _buildWallpaperItem(controller, wallpaper);
//                     },
//                   ),
//           );
//         }),
//       ],
//     );
//   }

//   Widget _buildWallpaperItem(
//       WallpaperMusicController controller, String wallpaper) {
//     final isSelected = controller.selectedWallpaper.value == wallpaper;

//     return GestureDetector(
//       onTap: () => controller.selectWallpaper(wallpaper),
//       child: Container(
//         decoration: BoxDecoration(
//           border: Border.all(
//             color: isSelected ? colorBackground : Colors.grey,
//             width: isSelected ? 2 : 1,
//           ),
//           borderRadius: BorderRadius.circular(15),
//           image: !wallpaper.endsWith('.mp4')
//               ? DecorationImage(
//                   image: AssetImage(wallpaper),
//                   fit: BoxFit.cover,
//                   colorFilter: isSelected
//                       ? ColorFilter.mode(
//                           colorBackground.withOpacity(0.3), BlendMode.srcATop)
//                       : null,
//                 )
//               : null,
//         ),
//         child: wallpaper.endsWith('.mp4')
//             ? _buildVideoPlayer(controller, wallpaper)
//             : null,
//       ),
//     );
//   }

//   Widget _buildVideoPlayer(
//       WallpaperMusicController controller, String wallpaper) {
//     final videoController = controller.getVideoController(wallpaper);

//     if (videoController == null || !videoController.value.isInitialized) {
//       return const Center(child: CircularProgressIndicator());
//     }

//     return GestureDetector(
//       onTap: () {
//         // Toggle play/pause saat di-tap
//         if (videoController.value.isPlaying) {
//           videoController.pause();
//         } else {
//           videoController.play();
//         }
//       },
//       child: AspectRatio(
//         aspectRatio: videoController.value.aspectRatio,
//         child: Stack(
//           alignment: Alignment.center,
//           children: [
//             VideoPlayer(videoController),
//             Obx(() {
//               final isSelected =
//                   controller.selectedWallpaper.value == wallpaper;
//               if (isSelected) {
//                 return CircleAvatar(
//                   backgroundColor: Colors.black54,
//                   child: Icon(
//                     videoController.value.isPlaying
//                         ? Icons.pause
//                         : Icons.play_arrow,
//                     color: Colors.white,
//                   ),
//                 );
//               }
//               return const SizedBox.shrink();
//             }),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildMusicSelection(WallpaperMusicController controller) {
//     return Column(
//       children: [
//         Text(
//           'Pilih Musik',
//           style: GoogleFonts.leagueSpartan(fontSize: 24),
//         ),
//         Obx(() {
//           // Tambahkan penanganan status musik
//           if (controller.musicStatus.value == WallpaperStatus.loading) {
//             return const Expanded(
//               child: Center(
//                 child: CircularProgressIndicator(),
//               ),
//             );
//           }

//           // Penanganan error musik
//           if (controller.musicStatus.value == WallpaperStatus.error) {
//             return Expanded(
//               child: Center(
//                 child: Text(
//                   'Error: ${controller.errorMessage.value}',
//                   style: const TextStyle(color: Colors.red),
//                 ),
//               ),
//             );
//           }

//           return Expanded(
//             child: AssetPaths.musicTracks.isEmpty
//                 ? const Center(child: Text("Tidak ada musik tersedia"))
//                 : ListView.builder(
//                     itemCount: AssetPaths.musicTracks.length,
//                     itemBuilder: (context, index) {
//                       final musicTrack = AssetPaths.musicTracks[index];
//                       final isSelected =
//                           controller.selectedMusic.value == musicTrack;

//                       return ListTile(
//                         title: Text('Penyejuk Hati ${index + 1}'),
//                         trailing: isSelected
//                             ? const Icon(Icons.check, color: colorBackground)
//                             : null,
//                         onTap: () {
//                           controller.selectMusic(musicTrack);
//                         },
//                       );
//                     },
//                   ),
//           );
//         }),
//       ],
//     );
//   }
// }

// import 'package:ebookapp/core/constants/constant.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:video_player/video_player.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';
// import 'package:google_fonts/google_fonts.dart';
// import '../controllers/wallpaper_music_controller.dart';

// class WallpaperMusicView extends StatefulWidget {
//   const WallpaperMusicView({Key? key}) : super(key: key);

//   @override
//   _WallpaperMusicViewState createState() => _WallpaperMusicViewState();
// }

// class _WallpaperMusicViewState extends State<WallpaperMusicView>
//     with AutomaticKeepAliveClientMixin {
//   final PageController _pageController = PageController();

//   @override
//   bool get wantKeepAlive => true;

//   @override
//   void initState() {
//     super.initState();
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitUp,
//       DeviceOrientation.portraitDown,
//     ]);
//   }

//   @override
//   void dispose() {
//     _pageController.dispose();
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.landscapeRight,
//       DeviceOrientation.landscapeLeft,
//       DeviceOrientation.portraitUp,
//       DeviceOrientation.portraitDown,
//     ]);
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     super.build(context);
//     return GetBuilder<WallpaperMusicController>(
//       builder: (controller) => Scaffold(
//         backgroundColor: Colors.white,
//         body: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.all(20),
//             child: Column(
//               children: [
//                 Expanded(
//                   child: PageView(
//                     controller: _pageController,
//                     physics: const NeverScrollableScrollPhysics(),
//                     children: [
//                       _buildWallpaperSelection(controller),
//                       _buildMusicSelection(controller),
//                     ],
//                   ),
//                 ),
//                 _buildIndicator(),
//                 const SizedBox(height: 10),
//                 _buildNavigationButton(controller),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildIndicator() {
//     return SmoothPageIndicator(
//       controller: _pageController,
//       count: 2,
//       effect: const WormEffect(
//         activeDotColor: colorBackground,
//         dotColor: Colors.grey,
//         dotHeight: 8,
//         dotWidth: 8,
//       ),
//     );
//   }

//   Widget _buildNavigationButton(WallpaperMusicController controller) {
//     return ElevatedButton(
//       onPressed: () {
//         if (_pageController.page == 1) {
//           Get.back();
//         } else {
//           _pageController.nextPage(
//             duration: const Duration(milliseconds: 300),
//             curve: Curves.easeInOut,
//           );
//         }
//       },
//       style: ElevatedButton.styleFrom(
//         minimumSize: const Size(double.infinity, 50),
//         backgroundColor: colorBackground,
//       ),
//       child: Text(
//         _pageController.hasClients && _pageController.page == 1
//             ? 'Selesai'
//             : 'Selanjutnya',
//         style: const TextStyle(color: Colors.white),
//       ),
//     );
//   }

//   Widget _buildWallpaperSelection(WallpaperMusicController controller) {
//     return Column(
//       children: [
//         Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Pilih Wallpapermu!',
//               style: GoogleFonts.leagueSpartan(
//                   fontSize: 24, fontWeight: FontWeight.bold),
//               textAlign: TextAlign.left,
//             ),
//             Text(
//               'Kamu bisa memilih wallpaper yang paling kamu suka loh.\nagar menambah pengalamanmu saat membaca',
//               style: GoogleFonts.leagueSpartan(fontSize: 14),
//               textAlign: TextAlign.left,
//             ),
//             SizedBox(height: 20),
//           ],
//         ),
//         Obx(() {
//           if (controller.wallpaperStatus.value == WallpaperStatus.loading) {
//             return const Expanded(
//               child: Center(
//                 child: CircularProgressIndicator(),
//               ),
//             );
//           }
//           if (controller.wallpaperStatus.value == WallpaperStatus.error) {
//             return Expanded(
//               child: Center(
//                 child: Text(
//                   'Error: ${controller.errorMessage.value}',
//                   style: const TextStyle(color: Colors.red),
//                 ),
//               ),
//             );
//           }

//           return Expanded(
//             child: AssetPaths.wallpapers.isEmpty
//                 ? const Center(child: Text("Tidak ada wallpaper tersedia"))
//                 : GridView.builder(
//                     gridDelegate:
//                         const SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 3,
//                       childAspectRatio: 0.7,
//                       crossAxisSpacing: 8,
//                       mainAxisSpacing: 8,
//                     ),
//                     itemCount: AssetPaths.wallpapers.length,
//                     itemBuilder: (context, index) {
//                       final wallpaper = AssetPaths.wallpapers[index];
//                       return _buildWallpaperItem(controller, wallpaper);
//                     },
//                   ),
//           );
//         }),
//       ],
//     );
//   }

//   Widget _buildWallpaperItem(
//       WallpaperMusicController controller, String wallpaper) {
//     final isSelected = controller.selectedWallpaper.value == wallpaper;

//     return GestureDetector(
//       onTap: () {
//         controller.selectWallpaper(wallpaper);
//         if (isSelected) {
//           debugPrint(
//               'Wallpaper dipilih: $wallpaper'); // Debug Print untuk wallpaper
//         }
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           border: Border.all(
//             color: isSelected ? colorBackground : Colors.grey,
//             width: isSelected ? 2 : 1,
//           ),
//           borderRadius: BorderRadius.circular(15),
//         ),
//         child: wallpaper.endsWith('.mp4')
//             ? _buildVideoPlayer(controller, wallpaper, isSelected)
//             : _buildImageTile(wallpaper, isSelected),
//       ),
//     );
//   }

//   Widget _buildImageTile(String wallpaper, bool isSelected) {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(15),
//         image: DecorationImage(
//           image: AssetImage(wallpaper),
//           fit: BoxFit.cover,
//           colorFilter: isSelected
//               ? ColorFilter.mode(
//                   colorBackground.withOpacity(0.3), BlendMode.srcATop)
//               : null,
//         ),
//       ),
//     );
//   }

//   Widget _buildVideoPlayer(
//       WallpaperMusicController controller, String wallpaper, bool isSelected) {
//     final videoController = controller.getVideoController(wallpaper);

//     if (videoController == null || !videoController.value.isInitialized) {
//       return const Center(child: CircularProgressIndicator());
//     }

//     // Play or pause the video based on selection
//     if (isSelected) {
//       videoController.play();
//     } else {
//       videoController.pause();
//     }

//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(15),
//         color: Colors.black,
//       ),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(15),
//         child: AspectRatio(
//           aspectRatio: videoController.value.aspectRatio,
//           child: Stack(
//             alignment: Alignment.center,
//             children: [
//               VideoPlayer(videoController),
//               if (isSelected)
//                 CircleAvatar(
//                   backgroundColor: Colors.black54,
//                   child: Icon(
//                     videoController.value.isPlaying
//                         ? Icons.pause
//                         : Icons.play_arrow,
//                     color: Colors.white,
//                   ),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildMusicSelection(WallpaperMusicController controller) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Ayo pilih lagumu!',
//           style: GoogleFonts.leagueSpartan(
//               fontSize: 24, fontWeight: FontWeight.bold),
//         ),
//         Text(
//           'Musik ini akan diputar saat kamu sedang membuka bacaan,\njadi pilih sesuai mood mu ya!',
//           style: GoogleFonts.leagueSpartan(fontSize: 14),
//         ),
//         const SizedBox(
//           height: 58,
//         ),
//         Obx(() {
//           if (controller.musicStatus.value == WallpaperStatus.loading) {
//             return const Expanded(
//               child: Center(
//                 child: CircularProgressIndicator(),
//               ),
//             );
//           }
//           if (controller.musicStatus.value == WallpaperStatus.error) {
//             return Expanded(
//               child: Center(
//                 child: Text(
//                   'Error: ${controller.errorMessage.value}',
//                   style: const TextStyle(color: Colors.red),
//                 ),
//               ),
//             );
//           }

//           return Expanded(
//             child: AssetPaths.musicTracks.isEmpty
//                 ? const Center(child: Text("Tidak ada musik tersedia"))
//                 : ListView.builder(
//                     itemCount: AssetPaths.musicTracks.length,
//                     itemBuilder: (context, index) {
//                       final musicTrack = AssetPaths.musicTracks[index];
//                       final isSelected =
//                           controller.selectedMusic.value == musicTrack;

//                       return Container(
//                         margin: const EdgeInsets.symmetric(vertical: 5),
//                         decoration: BoxDecoration(
//                           color: Colors.white.withOpacity(0.8),
//                           borderRadius: BorderRadius.circular(12),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black.withOpacity(0.1),
//                               blurRadius: 5,
//                               offset: const Offset(0, 3),
//                             ),
//                           ],
//                         ),
//                         child: ListTile(
//                           title: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text('Penyejuk Hati ${index + 1}'),
//                               InkWell(
//                                 onTap: () {
//                                   controller.selectMusic(musicTrack);
//                                   debugPrint(
//                                       'Musik dipilih: $musicTrack'); // Debug Print untuk musik
//                                 },
//                                 child: Container(
//                                   padding: const EdgeInsets.all(8),
//                                   decoration: BoxDecoration(
//                                     color: isSelected
//                                         ? colorBackground
//                                         : Colors.grey[300],
//                                     borderRadius: BorderRadius.circular(8),
//                                   ),
//                                   child: Icon(
//                                     isSelected ? Icons.pause : Icons.play_arrow,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//           );
//         }),
//       ],
//     );
//   }
// }

// import 'package:ebookapp/core/constants/constant.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:video_player/video_player.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';
// import 'package:google_fonts/google_fonts.dart';
// import '../controllers/wallpaper_music_controller.dart';

// class WallpaperMusicView extends StatefulWidget {
//   const WallpaperMusicView({Key? key}) : super(key: key);

//   @override
//   _WallpaperMusicViewState createState() => _WallpaperMusicViewState();
// }

// class _WallpaperMusicViewState extends State<WallpaperMusicView>
//     with AutomaticKeepAliveClientMixin {
//   final PageController _pageController = PageController();

//   @override
//   bool get wantKeepAlive => true;

//   @override
//   void initState() {
//     super.initState();
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitUp,
//       DeviceOrientation.portraitDown,
//     ]);
//   }

//   @override
//   void dispose() {
//     _pageController.dispose();
//     SystemChrome.setPreferredOrientations(DeviceOrientation.values);
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     super.build(context);
//     final screenSize = MediaQuery.of(context).size;

//     return GetBuilder<WallpaperMusicController>(
//       builder: (controller) => Scaffold(
//         backgroundColor: Colors.white,
//         body: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.all(20),
//             child: Column(
//               children: [
//                 Expanded(
//                   child: PageView(
//                     controller: _pageController,
//                     physics: const NeverScrollableScrollPhysics(),
//                     children: [
//                       _buildWallpaperSelection(controller),
//                       _buildMusicSelection(controller),
//                     ],
//                   ),
//                 ),
//                 _buildIndicator(),
//                 const SizedBox(height: 10),
//                 _buildNavigationButton(controller),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildIndicator() {
//     return SmoothPageIndicator(
//       controller: _pageController,
//       count: 2,
//       effect: const WormEffect(
//         activeDotColor: colorBackground,
//         dotColor: Colors.grey,
//         dotHeight: 8,
//         dotWidth: 8,
//       ),
//     );
//   }

//   Widget _buildNavigationButton(WallpaperMusicController controller) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     return SizedBox(
//       width: screenWidth,
//       child: ElevatedButton(
//         onPressed: () {
//           if (_pageController.page == 1) {
//             Get.back();
//           } else {
//             _pageController.nextPage(
//               duration: const Duration(milliseconds: 300),
//               curve: Curves.easeInOut,
//             );
//           }
//         },
//         style: ElevatedButton.styleFrom(
//           minimumSize: Size(screenWidth, 50),
//           backgroundColor: colorBackground,
//         ),
//         child: Text(
//           _pageController.hasClients && _pageController.page == 1
//               ? 'Selesai'
//               : 'Selanjutnya',
//           style: const TextStyle(color: Colors.white),
//         ),
//       ),
//     );
//   }

//   Widget _buildWallpaperSelection(WallpaperMusicController controller) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Pilih Wallpapermu!',
//           style: GoogleFonts.leagueSpartan(
//               fontSize: 34, fontWeight: FontWeight.bold),
//           textAlign: TextAlign.left,
//         ),
//         Text(
//           'Kamu bisa memilih wallpaper yang paling kamu suka loh.\nagar menambah pengalamanmu saat membaca',
//           style: GoogleFonts.leagueSpartan(fontSize: 14),
//           textAlign: TextAlign.left,
//         ),
//         const SizedBox(height: 20),
//         Obx(() {
//           if (controller.wallpaperStatus.value == WallpaperStatus.loading) {
//             return const Expanded(
//               child: Center(
//                 child: CircularProgressIndicator(),
//               ),
//             );
//           }
//           if (controller.wallpaperStatus.value == WallpaperStatus.error) {
//             return Expanded(
//               child: Center(
//                 child: Text(
//                   'Error: ${controller.errorMessage.value}',
//                   style: const TextStyle(color: Colors.red),
//                 ),
//               ),
//             );
//           }

//           final screenSize = MediaQuery.of(context).size;
//           return Expanded(
//             child: AssetPaths.wallpapers.isEmpty
//                 ? const Center(child: Text("Tidak ada wallpaper tersedia"))
//                 : GridView.builder(
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount:
//                           (screenSize.width > 400) ? 3 : 2, // responsive count
//                       childAspectRatio: 0.7,
//                       crossAxisSpacing: 8,
//                       mainAxisSpacing: 8,
//                     ),
//                     itemCount: AssetPaths.wallpapers.length,
//                     itemBuilder: (context, index) {
//                       final wallpaper = AssetPaths.wallpapers[index];
//                       return _buildWallpaperItem(controller, wallpaper);
//                     },
//                   ),
//           );
//         }),
//       ],
//     );
//   }

//   Widget _buildWallpaperItem(
//       WallpaperMusicController controller, String wallpaper) {
//     final isSelected = controller.selectedWallpaper.value == wallpaper;

//     return GestureDetector(
//       onTap: () {
//         controller.selectWallpaper(wallpaper);
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           border: Border.all(
//             color: isSelected ? colorBackground : Colors.grey,
//             width: isSelected ? 2 : 1,
//           ),
//           borderRadius: BorderRadius.circular(15),
//         ),
//         child: wallpaper.endsWith('.mp4')
//             ? _buildVideoPlayer(controller, wallpaper, isSelected)
//             : _buildImageTile(wallpaper, isSelected),
//       ),
//     );
//   }

//   Widget _buildImageTile(String wallpaper, bool isSelected) {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(15),
//         image: DecorationImage(
//           image: AssetImage(wallpaper),
//           fit: BoxFit.cover,
//           colorFilter: isSelected
//               ? ColorFilter.mode(
//                   colorBackground.withOpacity(0.3), BlendMode.srcATop)
//               : null,
//         ),
//       ),
//     );
//   }

//   Widget _buildVideoPlayer(
//       WallpaperMusicController controller, String wallpaper, bool isSelected) {
//     final videoController = controller.getVideoController(wallpaper);
//     if (videoController == null || !videoController.value.isInitialized) {
//       return const Center(child: CircularProgressIndicator());
//     }

//     if (isSelected) {
//       videoController.play();
//     } else {
//       videoController.pause();
//     }

//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(15),
//         color: Colors.black,
//       ),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(15),
//         child: AspectRatio(
//           aspectRatio: videoController.value.aspectRatio,
//           child: Stack(
//             alignment: Alignment.center,
//             children: [
//               VideoPlayer(videoController),
//               if (isSelected)
//                 CircleAvatar(
//                   backgroundColor: Colors.black54,
//                   child: Icon(
//                     videoController.value.isPlaying
//                         ? Icons.pause
//                         : Icons.play_arrow,
//                     color: Colors.white,
//                   ),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildMusicSelection(WallpaperMusicController controller) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Ayo pilih lagumu!',
//           style: GoogleFonts.leagueSpartan(
//               fontSize: 24, fontWeight: FontWeight.bold),
//         ),
//         Text(
//           'Musik ini akan diputar saat kamu sedang membuka bacaan,\njadi pilih sesuai mood mu ya!',
//           style: GoogleFonts.leagueSpartan(fontSize: 14),
//         ),
//         const SizedBox(height: 20),
//         Obx(() {
//           if (controller.musicStatus.value == WallpaperStatus.loading) {
//             return const Expanded(
//               child: Center(
//                 child: CircularProgressIndicator(),
//               ),
//             );
//           }
//           if (controller.musicStatus.value == WallpaperStatus.error) {
//             return Expanded(
//               child: Center(
//                 child: Text(
//                   'Error: ${controller.errorMessage.value}',
//                   style: const TextStyle(color: Colors.red),
//                 ),
//               ),
//             );
//           }

//           return Expanded(
//             child: AssetPaths.musicTracks.isEmpty
//                 ? const Center(child: Text("Tidak ada musik tersedia"))
//                 : ListView.builder(
//                     itemCount: AssetPaths.musicTracks.length,
//                     itemBuilder: (context, index) {
//                       final musicTrack = AssetPaths.musicTracks[index];
//                       final isSelected =
//                           controller.selectedMusic.value == musicTrack;

//                       return Container(
//                         margin: const EdgeInsets.symmetric(vertical: 5),
//                         decoration: BoxDecoration(
//                           color: Colors.white.withOpacity(0.8),
//                           borderRadius: BorderRadius.circular(12),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black.withOpacity(0.1),
//                               blurRadius: 5,
//                               offset: const Offset(0, 3),
//                             ),
//                           ],
//                         ),
//                         child: ListTile(
//                           title: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text('Penyejuk Hati ${index + 1}'),
//                               InkWell(
//                                 onTap: () {
//                                   controller.selectMusic(musicTrack);
//                                 },
//                                 child: Container(
//                                   padding: const EdgeInsets.all(8),
//                                   decoration: BoxDecoration(
//                                     color: isSelected
//                                         ? colorBackground
//                                         : Colors.grey[300],
//                                     borderRadius: BorderRadius.circular(8),
//                                   ),
//                                   child: Icon(
//                                     isSelected ? Icons.pause : Icons.play_arrow,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//           );
//         }),
//       ],
//     );
//   }
// }

// import 'package:ebookapp/core/constants/constant.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:video_player/video_player.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';
// import 'package:google_fonts/google_fonts.dart';
// import '../controllers/wallpaper_music_controller.dart';

// class WallpaperMusicView extends StatefulWidget {
//   const WallpaperMusicView({Key? key}) : super(key: key);

//   @override
//   _WallpaperMusicViewState createState() => _WallpaperMusicViewState();
// }

// class _WallpaperMusicViewState extends State<WallpaperMusicView>
//     with AutomaticKeepAliveClientMixin {
//   final PageController _pageController = PageController();

//   @override
//   bool get wantKeepAlive => true;

//   @override
//   void initState() {
//     super.initState();
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitUp,
//       DeviceOrientation.portraitDown,
//     ]);
//   }

//   @override
//   void dispose() {
//     _pageController.dispose();
//     SystemChrome.setPreferredOrientations(DeviceOrientation.values);
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     super.build(context);
//     final screenSize = MediaQuery.of(context).size;

//     return GetBuilder<WallpaperMusicController>(
//       builder: (controller) => Scaffold(
//         backgroundColor: Colors.white,
//         body: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.all(20),
//             child: Column(
//               children: [
//                 Expanded(
//                   child: PageView(
//                     controller: _pageController,
//                     physics: const NeverScrollableScrollPhysics(),
//                     children: [
//                       _buildWallpaperSelection(controller),
//                       _buildMusicSelection(controller),
//                     ],
//                   ),
//                 ),
//                 _buildIndicator(),
//                 const SizedBox(height: 10),
//                 _buildNavigationButton(controller),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildIndicator() {
//     return SmoothPageIndicator(
//       controller: _pageController,
//       count: 2,
//       effect: const WormEffect(
//         activeDotColor: colorBackground,
//         dotColor: Colors.grey,
//         dotHeight: 8,
//         dotWidth: 8,
//       ),
//     );
//   }

//   Widget _buildNavigationButton(WallpaperMusicController controller) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     return SizedBox(
//       width: screenWidth,
//       child: ElevatedButton(
//         onPressed: () {
//           if (_pageController.page == 1) {
//             Get.back();
//           } else {
//             _pageController.nextPage(
//               duration: const Duration(milliseconds: 300),
//               curve: Curves.easeInOut,
//             );
//           }
//         },
//         style: ElevatedButton.styleFrom(
//           minimumSize: Size(screenWidth, 50),
//           backgroundColor: colorBackground,
//         ),
//         child: Text(
//           _pageController.hasClients && _pageController.page == 1
//               ? 'Selesai'
//               : 'Selanjutnya',
//           style: const TextStyle(color: Colors.white),
//         ),
//       ),
//     );
//   }

//   Widget _buildWallpaperSelection(WallpaperMusicController controller) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Pilih Wallpapermu!',
//           style: GoogleFonts.leagueSpartan(
//               fontSize: 34, fontWeight: FontWeight.bold),
//           textAlign: TextAlign.left,
//         ),
//         Text(
//           'Kamu bisa memilih wallpaper yang paling kamu suka loh.\nagar menambah pengalamanmu saat membaca',
//           style: GoogleFonts.leagueSpartan(fontSize: 14),
//           textAlign: TextAlign.left,
//         ),
//         const SizedBox(height: 20),
//         Obx(() {
//           if (controller.wallpaperStatus.value == WallpaperStatus.loading) {
//             return const Expanded(
//               child: Center(
//                 child: CircularProgressIndicator(),
//               ),
//             );
//           }
//           if (controller.wallpaperStatus.value == WallpaperStatus.error) {
//             return Expanded(
//               child: Center(
//                 child: Text(
//                   'Error: ${controller.errorMessage.value}',
//                   style: const TextStyle(color: Colors.red),
//                 ),
//               ),
//             );
//           }

//           final size = MediaQuery.of(context).size;
//           return Expanded(
//             child: AssetPaths.wallpapers.isEmpty
//                 ? const Center(child: Text("Tidak ada wallpaper tersedia"))
//                 : GridView.builder(
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: (size.width > 400) ? 3 : 2,
//                       childAspectRatio: 0.7,
//                       crossAxisSpacing: 8,
//                       mainAxisSpacing: 8,
//                     ),
//                     itemCount: AssetPaths.wallpapers.length,
//                     itemBuilder: (context, index) {
//                       final wallpaper = AssetPaths.wallpapers[index];
//                       return _buildWallpaperItem(controller, wallpaper);
//                     },
//                   ),
//           );
//         }),
//       ],
//     );
//   }

//   Widget _buildWallpaperItem(
//       WallpaperMusicController controller, String wallpaper) {
//     final isSelected = controller.selectedWallpaper.value == wallpaper;

//     return GestureDetector(
//       onTap: () {
//         // Memilih wallpaper saat diklik.
//         controller.selectWallpaper(wallpaper);
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           border: Border.all(
//             color: isSelected ? colorBackground : Colors.grey,
//             width: isSelected ? 2 : 1,
//           ),
//           borderRadius: BorderRadius.circular(15),
//         ),
//         child: wallpaper.endsWith('.mp4')
//             ? _buildVideoPlayer(controller, wallpaper, isSelected)
//             : _buildImageTile(wallpaper, isSelected),
//       ),
//     );
//   }

//   Widget _buildImageTile(String wallpaper, bool isSelected) {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(15),
//         image: DecorationImage(
//           image: AssetImage(wallpaper),
//           fit: BoxFit.cover,
//           colorFilter: isSelected
//               ? ColorFilter.mode(
//                   colorBackground.withOpacity(0.3), BlendMode.srcATop)
//               : null,
//         ),
//       ),
//     );
//   }

//   Widget _buildVideoPlayer(
//       WallpaperMusicController controller, String wallpaper, bool isSelected) {
//     final videoController = controller.getVideoController(wallpaper);

//     // Memeriksa apakah video controller tersedia dan sudah diinisialisasi
//     if (videoController == null) {
//       return const Center(child: CircularProgressIndicator());
//     }

//     // Memutar atau menghentikan video berdasarkan status pemilihan
//     if (isSelected) {
//       videoController.play();
//     } else {
//       videoController.pause();
//     }

//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(15),
//         color: Colors.black,
//       ),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(15),
//         child: AspectRatio(
//           aspectRatio: videoController.value.aspectRatio,
//           child: Stack(
//             alignment: Alignment.center,
//             children: [
//               VideoPlayer(videoController),
//               if (isSelected)
//                 CircleAvatar(
//                   backgroundColor: Colors.black54,
//                   child: Icon(
//                     videoController.value.isPlaying
//                         ? Icons.pause
//                         : Icons.play_arrow,
//                     color: Colors.white,
//                   ),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildMusicSelection(WallpaperMusicController controller) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Ayo pilih lagumu!',
//           style: GoogleFonts.leagueSpartan(
//               fontSize: 24, fontWeight: FontWeight.bold),
//         ),
//         Text(
//           'Musik ini akan diputar saat kamu sedang membuka bacaan,\njadi pilih sesuai mood mu ya!',
//           style: GoogleFonts.leagueSpartan(fontSize: 14),
//         ),
//         const SizedBox(height: 20),
//         Obx(() {
//           if (controller.musicStatus.value == WallpaperStatus.loading) {
//             return const Expanded(
//               child: Center(
//                 child: CircularProgressIndicator(),
//               ),
//             );
//           }
//           if (controller.musicStatus.value == WallpaperStatus.error) {
//             return Expanded(
//               child: Center(
//                 child: Text(
//                   'Error: ${controller.errorMessage.value}',
//                   style: const TextStyle(color: Colors.red),
//                 ),
//               ),
//             );
//           }

//           return Expanded(
//             child: AssetPaths.musicTracks.isEmpty
//                 ? const Center(child: Text("Tidak ada musik tersedia"))
//                 : ListView.builder(
//                     itemCount: AssetPaths.musicTracks.length,
//                     itemBuilder: (context, index) {
//                       final musicTrack = AssetPaths.musicTracks[index];
//                       final isSelected =
//                           controller.selectedMusic.value == musicTrack;

//                       return Container(
//                         margin: const EdgeInsets.symmetric(vertical: 5),
//                         decoration: BoxDecoration(
//                           color: Colors.white.withOpacity(0.8),
//                           borderRadius: BorderRadius.circular(12),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black.withOpacity(0.1),
//                               blurRadius: 5,
//                               offset: const Offset(0, 3),
//                             ),
//                           ],
//                         ),
//                         child: ListTile(
//                           title: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text('Penyejuk Hati ${index + 1}'),
//                               InkWell(
//                                 onTap: () {
//                                   controller.selectMusic(musicTrack);
//                                 },
//                                 child: Container(
//                                   padding: const EdgeInsets.all(8),
//                                   decoration: BoxDecoration(
//                                     color: isSelected
//                                         ? colorBackground
//                                         : Colors.grey[300],
//                                     borderRadius: BorderRadius.circular(8),
//                                   ),
//                                   child: Icon(
//                                     isSelected ? Icons.pause : Icons.play_arrow,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//           );
//         }),
//       ],
//     );
//   }
// }

// import 'package:ebookapp/core/constants/constant.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:video_player/video_player.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../controllers/wallpaper_music_controller.dart';
// import '../model/music_track.dart';
// import '../model/wallpaper_model.dart';

// class WallpaperMusicView extends StatefulWidget {
//   const WallpaperMusicView({Key? key}) : super(key: key);

//   @override
//   _WallpaperMusicViewState createState() => _WallpaperMusicViewState();
// }

// class _WallpaperMusicViewState extends State<WallpaperMusicView>
//     with AutomaticKeepAliveClientMixin {
//   final PageController _pageController = PageController();

//   @override
//   bool get wantKeepAlive => true;

//   @override
//   void initState() {
//     super.initState();
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitUp,
//       DeviceOrientation.portraitDown,
//     ]);
//   }

//   @override
//   void dispose() {
//     _pageController.dispose();
//     SystemChrome.setPreferredOrientations(DeviceOrientation.values);
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     super.build(context);
//     final screenSize = MediaQuery.of(context).size;

//     return GetBuilder<WallpaperMusicController>(
//       builder: (controller) => Scaffold(
//         backgroundColor: Colors.white,
//         body: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.all(20),
//             child: Column(
//               children: [
//                 Expanded(
//                   child: PageView(
//                     controller: _pageController,
//                     physics: const NeverScrollableScrollPhysics(),
//                     children: [
//                       _buildWallpaperSelection(controller),
//                       _buildMusicSelection(controller),
//                     ],
//                   ),
//                 ),
//                 _buildIndicator(),
//                 const SizedBox(height: 10),
//                 _buildNavigationButton(controller),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildIndicator() {
//     return SmoothPageIndicator(
//       controller: _pageController,
//       count: 2,
//       effect: const WormEffect(
//         activeDotColor: colorBackground,
//         dotColor: Colors.grey,
//         dotHeight: 8,
//         dotWidth: 8,
//       ),
//     );
//   }

//   Widget _buildNavigationButton(WallpaperMusicController controller) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     return SizedBox(
//       width: screenWidth,
//       child: ElevatedButton(
//         onPressed: () async {
//           if (_pageController.page == 1) {
//             // Jika ini halaman kedua (musical selection)
//             SharedPreferences prefs = await SharedPreferences.getInstance();
//             prefs.setBool(
//                 'isNewUser', false); // Set pengguna baru menjadi false

//             // Arahkan ke halaman /home dan refresh data pengguna
//             Get.offNamed('/home', arguments: {'refresh': true});
//           } else {
//             // Jika halaman pertama (wallpaper selection)
//             _pageController.nextPage(
//               duration: const Duration(milliseconds: 300),
//               curve: Curves.easeInOut,
//             );
//           }
//         },
//         style: ElevatedButton.styleFrom(
//           minimumSize: Size(screenWidth, 50),
//           backgroundColor: colorBackground,
//         ),
//         child: Text(
//           _pageController.hasClients && _pageController.page == 1
//               ? 'Selesai'
//               : 'Selanjutnya',
//           style: const TextStyle(color: Colors.white),
//         ),
//       ),
//     );
//   }

//   Widget _buildWallpaperSelection(WallpaperMusicController controller) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Pilih Wallpapermu!',
//           style: GoogleFonts.leagueSpartan(
//               fontSize: 34, fontWeight: FontWeight.bold),
//           textAlign: TextAlign.left,
//         ),
//         Text(
//           'Kamu bisa memilih wallpaper yang paling kamu suka loh.\nagar menambah pengalamanmu saat membaca',
//           style: GoogleFonts.leagueSpartan(fontSize: 14),
//           textAlign: TextAlign.left,
//         ),
//         const SizedBox(height: 20),
//         Obx(() {
//           if (controller.wallpaperStatus.value == WallpaperStatus.loading) {
//             return const Expanded(
//               child: Center(
//                 child: CircularProgressIndicator(),
//               ),
//             );
//           }
//           if (controller.wallpaperStatus.value == WallpaperStatus.error) {
//             return Expanded(
//               child: Center(
//                 child: Text(
//                   'Error: ${controller.errorMessage.value}',
//                   style: const TextStyle(color: Colors.red),
//                 ),
//               ),
//             );
//           }

//           final wallpapers = controller.wallpapers;
//           final size = MediaQuery.of(context).size;
//           return Expanded(
//             child: wallpapers.isEmpty
//                 ? const Center(child: Text("Tidak ada wallpaper tersedia"))
//                 : GridView.builder(
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: (size.width > 400) ? 3 : 2,
//                       childAspectRatio: 0.7,
//                       crossAxisSpacing: 8,
//                       mainAxisSpacing: 8,
//                     ),
//                     itemCount: wallpapers.length,
//                     itemBuilder: (context, index) {
//                       final wallpaper = wallpapers[index];
//                       return _buildWallpaperItem(controller, wallpaper);
//                     },
//                   ),
//           );
//         }),
//       ],
//     );
//   }

//   Widget _buildWallpaperItem(
//       WallpaperMusicController controller, Wallpaper wallpaper) {
//     final isSelected = controller.selectedWallpaper.value == wallpaper.fileUrl;

//     return GestureDetector(
//       onTap: () {
//         // Memilih wallpaper saat diklik.
//         controller.selectWallpaper(wallpaper);
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           border: Border.all(
//             color: isSelected ? colorBackground : Colors.grey,
//             width: isSelected ? 2 : 1,
//           ),
//           borderRadius: BorderRadius.circular(15),
//         ),
//         child: wallpaper.type == 'video'
//             ? _buildVideoPlayer(controller, wallpaper.fileUrl, isSelected)
//             : _buildImageTile(wallpaper.thumbnailUrl, isSelected),
//       ),
//     );
//   }

//   Widget _buildImageTile(String thumbnailUrl, bool isSelected) {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(15),
//       ),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(15),
//         child: Image.network(
//           thumbnailUrl,
//           fit: BoxFit.cover,
//           loadingBuilder: (context, child, loadingProgress) {
//             if (loadingProgress == null) return child;
//             return Center(child: CircularProgressIndicator());
//           },
//           errorBuilder: (context, error, stackTrace) {
//             return Container(
//               color: Colors.grey, // Placeholder color
//               child: const Icon(Icons.error),
//             );
//           },
//         ),
//       ),
//     );
//   }

//   Widget _buildVideoPlayer(
//       WallpaperMusicController controller, String videoUrl, bool isSelected) {
//     final videoController = controller.getVideoController(videoUrl);

//     if (videoController == null) {
//       return const Center(child: CircularProgressIndicator());
//     }

//     // Memutar atau menghentikan video berdasarkan status pemilihan
//     if (isSelected) {
//       videoController.play();
//     } else {
//       videoController.pause();
//     }

//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(15),
//         color: Colors.black,
//       ),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(15),
//         child: AspectRatio(
//           aspectRatio: videoController.value.aspectRatio,
//           child: Stack(
//             alignment: Alignment.center,
//             children: [
//               VideoPlayer(videoController),
//               if (isSelected)
//                 CircleAvatar(
//                   backgroundColor: Colors.black54,
//                   child: Icon(
//                     videoController.value.isPlaying
//                         ? Icons.pause
//                         : Icons.play_arrow,
//                     color: Colors.white,
//                   ),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildMusicSelection(WallpaperMusicController controller) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         _buildMusicHeader(),
//         const SizedBox(height: 20),
//         _buildMusicContent(controller),
//       ],
//     );
//   }

//   Widget _buildMusicHeader() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Ayo pilih lagumu!',
//           style: GoogleFonts.leagueSpartan(
//             fontSize: 34,
//             fontWeight: FontWeight.w700,
//             color: Colors.black87,
//           ),
//         ),
//         Text(
//           'Musik ini akan diputar saat kamu sedang membuka bacaan jadi pilih sesuai mood mu ya!',
//           style: GoogleFonts.leagueSpartan(
//             fontSize: 14,
//             color: Colors.black54,
//             fontWeight: FontWeight.w400,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildMusicContent(WallpaperMusicController controller) {
//     return Obx(() {
//       if (controller.musicStatus.value == WallpaperStatus.loading) {
//         return _buildCenteredLoader();
//       }

//       if (controller.musicStatus.value == WallpaperStatus.error) {
//         return _buildErrorMessage(controller);
//       }

//       if (controller.musicPlaylist.isEmpty) {
//         return _buildEmptyState();
//       }

//       return Expanded(
//         child: ListView.separated(
//           itemCount: controller.musicPlaylist.length,
//           separatorBuilder: (context, index) => const SizedBox(height: 10),
//           itemBuilder: (context, index) =>
//               _buildMusicItem(controller, controller.musicPlaylist[index]),
//         ),
//       );
//     });
//   }

//   Widget _buildCenteredLoader() {
//     return const Expanded(
//       child: Center(
//         child: CircularProgressIndicator(
//           color: colorBackground,
//         ),
//       ),
//     );
//   }

//   Widget _buildErrorMessage(WallpaperMusicController controller) {
//     return Expanded(
//       child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.error_outline,
//               color: Colors.red,
//               size: 50,
//             ),
//             const SizedBox(height: 10),
//             Text(
//               'Ups! Terjadi Kesalahan',
//               style: GoogleFonts.leagueSpartan(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.black87,
//               ),
//             ),
//             Text(
//               controller.errorMessage.value,
//               style: GoogleFonts.leagueSpartan(
//                 fontSize: 14,
//                 color: Colors.black54,
//               ),
//               textAlign: TextAlign.center,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildEmptyState() {
//     return Expanded(
//       child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.music_off,
//               color: Colors.grey,
//               size: 50,
//             ),
//             const SizedBox(height: 10),
//             Text(
//               'Tidak Ada Musik Tersedia',
//               style: GoogleFonts.leagueSpartan(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.black87,
//               ),
//             ),
//             Text(
//               'Kami akan segera menambahkan musik baru',
//               style: GoogleFonts.leagueSpartan(
//                 fontSize: 14,
//                 color: Colors.black54,
//               ),
//               textAlign: TextAlign.center,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildMusicItem(
//       WallpaperMusicController controller, MusicTrack musicTrack) {
//     final isSelected = controller.selectedMusic.value == musicTrack.fileUrl;

//     return Container(
//       height: 45,
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: isSelected
//               ? [
//                   colorBackground.withOpacity(0.2),
//                   colorBackground.withOpacity(0.1)
//                 ]
//               : [Colors.white, Colors.white],
//         ),
//         borderRadius: BorderRadius.circular(15),
//         border: Border.all(
//           color: isSelected ? colorBackground : Colors.grey.shade200,
//           width: 1.5,
//         ),
//       ),
//       child: Row(
//         children: [
//           // Leading Icon
//           Container(
//             width: 40,
//             height: 40,
//             margin: const EdgeInsets.only(left: 10),
//             decoration: BoxDecoration(
//               color: isSelected ? colorBackground : Colors.grey.shade200,
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: Center(
//               child: Icon(
//                 Icons.music_note,
//                 color: isSelected ? Colors.white : Colors.black54,
//                 size: 20,
//               ),
//             ),
//           ),

//           // Title
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 12),
//               child: Text(
//                 musicTrack.title,
//                 style: GoogleFonts.leagueSpartan(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w600,
//                   color: Colors.black87,
//                 ),
//                 overflow: TextOverflow.ellipsis,
//               ),
//             ),
//           ),

//           // Play/Pause Button
//           GestureDetector(
//             onTap: () => controller
//                 .selectMusic(musicTrack),
//             child: AnimatedContainer(
//               duration: const Duration(milliseconds: 300),
//               width: 40,
//               height: 40,
//               margin: const EdgeInsets.only(right: 10),
//               decoration: BoxDecoration(
//                 color: isSelected ? colorBackground : Colors.grey.shade200,
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Center(
//                 child: Icon(
//                   isSelected ? Icons.pause : Icons.play_arrow,
//                   color: isSelected ? Colors.white : Colors.black54,
//                   size: 20,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

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
                    Get.delete<WallpaperMusicController>();
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
