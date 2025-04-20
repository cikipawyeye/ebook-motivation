// import 'package:ebookapp/app/modules/settings/controllers/payment_detail_controller.dart';
// import 'package:ebookapp/app/modules/settings/controllers/setting_theme_controller.dart';
// import 'package:ebookapp/app/routes/app_pages.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import '../controllers/home_controller.dart';

// class HomeView extends GetView<HomeController> {
//   HomeView({super.key});

//   static const Color appBarColor = Color(0xFF32497B);

//   // Fungsi untuk styling text
//   TextStyle _getTextStyle(
//       {double fontSize = 20,
//       Color color = Colors.black,
//       List<Shadow>? shadows}) {
//     return GoogleFonts.leagueSpartan(
//       fontSize: fontSize,
//       color: color,
//       fontWeight: FontWeight.bold,
//       height: 0.9,
//       shadows: shadows ?? [],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Menggunakan instance yang sama dari ThemeController
//     final ThemeController themeController = Get.find<ThemeController>();

//     // Memanggil fetchUserProfile setelah widget dibangun
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       controller.fetchUserProfile();
//     });

//     return Obx(
//       () => Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           title: Text(
//             'Home',
//             style: _getTextStyle(color: Colors.white),
//           ),
//           backgroundColor:
//               themeController.currentColor, // Menggunakan warna yang dipilih
//           centerTitle: true,
//           actions: [
//             IconButton(
//               icon: const Icon(Icons.settings, color: Colors.white),
//               onPressed: () {
//                 Get.toNamed('/settings');
//               },
//             ),
//           ],
//         ),
//         body: Container(
//           decoration: BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage('assets/images/Watermark.png'),
//               fit: BoxFit.cover, // Mengatur gambar agar menutupi seluruh area
//             ),
//           ),
//           child: Obx(() {
//             if (controller.isLoading.value) {
//               return Center(child: CircularProgressIndicator());
//             }

//             if (controller.userResponse.value == null) {
//               return Center(child: Text('No user data available'));
//             }

//             return RefreshIndicator(
//               onRefresh: () async {
//                 // Memuat ulang data pengguna
//                 await controller.fetchUserProfile();
//               },
//               child: ListView(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
//                 children: [
//                   // Greeting message
//                   Container(
//                     padding: EdgeInsets.all(10),
//                     child: RichText(
//                       textAlign: TextAlign.left,
//                       text: TextSpan(
//                         text:
//                             'Assalamualaikum, ${controller.userResponse.value?.user.name} \n\n',
//                         style: _getTextStyle(fontSize: 24, color: Colors.black),
//                         children: <TextSpan>[
//                           TextSpan(
//                             text:
//                                 'Terima kasih sudah mendaftar kesini.\nOya, buku ini berisi motivasi yang menyejukkan hati, serta pengingat yang berpedoman kepada Al-Qur\'an. Semoga dapat bermanfaat dan menambah semangat dalam kehidupan sehari-hari ya.... Aamiin Ya Robbal Alamin.',
//                             style: _getTextStyle(
//                                 fontSize: 13, color: Colors.black54),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),

//                   // Motivasi Card
//                   Card(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(16),
//                     ),
//                     clipBehavior: Clip.antiAlias,
//                     child: InkWell(
//                       onTap: () {
//                         // Navigasi ke halaman Motivasi dengan GetX
//                         Get.toNamed(Routes
//                             .motivasi); // Pastikan menggunakan Routes yang benar
//                       },
//                       child: Stack(
//                         children: [
//                           Image.asset(
//                             'assets/images/Motivasi1.png',
//                             height: 220,
//                             width: double.infinity,
//                             fit: BoxFit.cover,
//                           ),
//                           Positioned(
//                             left: 16,
//                             bottom: 16,
//                             child: Text(
//                               'Motivasi',
//                               style: _getTextStyle(
//                                 fontSize: 18,
//                                 color: Colors.white,
//                                 shadows: [
//                                   Shadow(
//                                     blurRadius: 5.0,
//                                     color: Colors.black.withOpacity(0.7),
//                                     offset: const Offset(2, 2),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           Positioned(
//                             right: 16,
//                             bottom: 16,
//                             child: Text(
//                               '>',
//                               style: _getTextStyle(
//                                   fontSize: 24, color: Colors.white),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 16),

//                   // Pengingat Card
//                   Card(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(16),
//                     ),
//                     clipBehavior: Clip.antiAlias,
//                     child: InkWell(
//                       onTap: () {
//                         print('Navigate to pengingat page');
//                         Get.toNamed(Routes.pengingat);
//                       }, // Ganti dengan route yang sesuai
//                       child: Stack(
//                         children: [
//                           Image.asset(
//                             'assets/images/Pengingat1.png',
//                             height: 220,
//                             width: double.infinity,
//                             fit: BoxFit.cover,
//                           ),
//                           Positioned(
//                             left: 16,
//                             bottom: 10,
//                             child: Text(
//                               'Pengingat',
//                               style: _getTextStyle(
//                                 fontSize: 18,
//                                 color: Colors.white,
//                                 shadows: [
//                                   Shadow(
//                                     blurRadius: 5.0,
//                                     color: Colors.black.withOpacity(0.7),
//                                     offset: const Offset(2, 2),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           Positioned(
//                             right: 16,
//                             bottom: 16,
//                             child: Text(
//                               '>',
//                               style: _getTextStyle(
//                                   fontSize: 24, color: Colors.white),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 24),

//                   // Premium Button
//                   Row(
//                     children: [
//                       OutlinedButton.icon(
//                         onPressed: () {
//                           print('Navigating to Try Premium page...');
//                           final paymentStatus =
//                               Get.find<PaymentController>().paymentStatus.value;
//                           Get.toNamed(Routes.tryPremium,
//                               arguments: paymentStatus);
//                         },
//                         icon: Image.asset(
//                           'assets/images/crown.png',
//                           width: 20,
//                           height: 20,
//                         ),
//                         label: Text(
//                           'Coba Premium!',
//                           style: _getTextStyle(
//                             fontSize: 16,
//                             color: appBarColor,
//                           ),
//                         ),
//                         style: OutlinedButton.styleFrom(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 20, vertical: 12),
//                           side: const BorderSide(color: appBarColor, width: 2),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(16),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             );
//           }),
//         ),
//       ),
//     );
//   }
// }

// import 'package:ebookapp/app/modules/motivasi/controllers/motivasi_controller.dart';
// import 'package:ebookapp/app/modules/pengingat/controllers/pengingat_category_controller.dart';
// import 'package:ebookapp/app/modules/settings/controllers/payment_detail_controller.dart';
// import 'package:ebookapp/app/modules/settings/controllers/setting_theme_controller.dart';
// import 'package:ebookapp/app/routes/app_pages.dart';
// import 'package:ebookapp/core/constants/constant.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import '../controllers/home_controller.dart';

// class HomeView extends GetView<HomeController> {
//   HomeView({super.key});

//   static const Color appBarColor = Color(0xFF32497B);

//   TextStyle _getTextStyle(
//       {double fontSize = 20,
//       Color color = Colors.black,
//       List<Shadow>? shadows}) {
//     return GoogleFonts.leagueSpartan(
//       fontSize: fontSize,
//       color: color,
//       fontWeight: FontWeight.bold,
//       height: 0.9,
//       shadows: shadows ?? [],
//     );
//   }

//   void _showMotivasiPopup(BuildContext context) {
//     final MotivasiController motivasiController =
//         Get.find<MotivasiController>();
//     final TextEditingController searchController = TextEditingController();
//     final ValueNotifier<bool> isSearching = ValueNotifier<bool>(false);

//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         // Reset pencarian saat popup dibuka
//         motivasiController.searchQuery.value = '';

//         return Dialog(
//           backgroundColor: Colors.white.withOpacity(0.7),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16),
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               // AppBar Kustom dengan warna latar belakang
//               Container(
//                 decoration: BoxDecoration(
//                   color: colorBackground,
//                   borderRadius: const BorderRadius.only(
//                     topLeft: Radius.circular(16),
//                     topRight: Radius.circular(16),
//                   ),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Row(
//                     children: [
//                       IconButton(
//                         icon: Icon(Icons.arrow_back,
//                             color: Colors.white), // Ikon kembali
//                         onPressed: () => Navigator.of(context).pop(),
//                       ),
//                       const SizedBox(width: 8),
//                       Text(
//                         'Motivasi',
//                         style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white),
//                       ),
//                       const Spacer(),
//                       IconButton(
//                         icon: Icon(Icons.search,
//                             color: Colors.white), // Ikon pencarian
//                         onPressed: () {
//                           isSearching.value =
//                               !isSearching.value; // Toggle pencarian
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ),

//               // Tampilkan TextField ketika pencarian diaktifkan
//               ValueListenableBuilder<bool>(
//                 valueListenable: isSearching,
//                 builder: (context, value, child) {
//                   return value
//                       ? Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Row(
//                             children: [
//                               const Icon(Icons.search, color: Colors.grey),
//                               const SizedBox(width: 8),
//                               Expanded(
//                                 child: TextField(
//                                   controller: searchController,
//                                   decoration: InputDecoration(
//                                     hintText: 'Cari...',
//                                     border: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(10),
//                                     ),
//                                   ),
//                                   onChanged: (text) {
//                                     // Update query pencarian
//                                     motivasiController.searchQuery.value = text;
//                                   },
//                                 ),
//                               ),
//                               IconButton(
//                                 icon: const Icon(Icons.clear,
//                                     color: Colors.black),
//                                 onPressed: () {
//                                   searchController.clear();
//                                   motivasiController.searchQuery.value =
//                                       ''; // Reset query
//                                 },
//                               ),
//                             ],
//                           ),
//                         )
//                       : SizedBox(); // Jika tidak dalam mode pencarian, tampilkan SizedBox kosong
//                 },
//               ),

//               // Daftar Motivasi dengan Pencarian
//               Flexible(
//                 child: Obx(() {
//                   final filteredSubcategories = motivasiController.subcategories
//                       .where((subcategory) => subcategory.name
//                           .toLowerCase()
//                           .contains(motivasiController.searchQuery.value
//                               .toLowerCase()))
//                       .toList();

//                   // Tampilkan pesan jika tidak ada hasil
//                   if (filteredSubcategories.isEmpty) {
//                     return Center(
//                       child: Text(
//                         "Tidak ada motivasi ditemukan",
//                         style: TextStyle(color: Colors.grey),
//                       ),
//                     );
//                   }

//                   // Tampilkan grid motivasi
//                   return GridView.builder(
//                     padding: EdgeInsets.all(8),
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2,
//                       childAspectRatio: 1,
//                       crossAxisSpacing: 10,
//                       mainAxisSpacing: 10,
//                     ),
//                     itemCount: filteredSubcategories.length,
//                     itemBuilder: (context, index) {
//                       final subcategory = filteredSubcategories[index];

//                       return GestureDetector(
//                         onTap: () {
//                           // Navigasi ke halaman detail motivasi
//                           Get.toNamed('/motivation/contents',
//                               arguments: subcategory);
//                         },
//                         child: Container(
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(15),
//                             image: DecorationImage(
//                               image: AssetImage('assets/images/Motivasi1.png'),
//                               fit: BoxFit.cover,
//                               colorFilter: ColorFilter.mode(
//                                   Colors.black45, BlendMode.darken),
//                             ),
//                           ),
//                           child: Center(
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Text(
//                                   subcategory.name,
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 Text(
//                                   "Halaman: ${subcategory.contentsCount}",
//                                   style: TextStyle(
//                                     color: Colors.white70,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 }),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   void _showPengingatPopup(BuildContext context) {
//   final PengingatIdController pengingatController = Get.find<PengingatIdController>();
//   final TextEditingController searchController = TextEditingController();
//   final ValueNotifier<bool> isSearching = ValueNotifier<bool>(false);

//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       // Reset pencarian saat popup dibuka
//       pengingatController.searchQuery.value = '';

//       return Dialog(
//         backgroundColor: Colors.white.withOpacity(0.7),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(16),
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             // AppBar Kustom dengan warna latar belakang
//             Container(
//               decoration: BoxDecoration(
//                 color: colorBackground, // Pastikan Anda memiliki variabel ini
//                 borderRadius: const BorderRadius.only(
//                   topLeft: Radius.circular(16),
//                   topRight: Radius.circular(16),
//                 ),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Row(
//                   children: [
//                     IconButton(
//                       icon: Icon(Icons.arrow_back, color: Colors.white),
//                       onPressed: () => Navigator.of(context).pop(),
//                     ),
//                     const SizedBox(width: 8),
//                     Text(
//                       'Pengingat',
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                     const Spacer(),
//                     IconButton(
//                       icon: Icon(Icons.search, color: Colors.white),
//                       onPressed: () {
//                         isSearching.value = !isSearching.value; // Toggle pencarian
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ),

//             // Tampilkan TextField ketika pencarian diaktifkan
//             ValueListenableBuilder<bool>(
//               valueListenable: isSearching,
//               builder: (context, value, child) {
//                 return value
//                     ? Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Row(
//                           children: [
//                             const Icon(Icons.search, color: Colors.grey),
//                             const SizedBox(width: 8),
//                             Expanded(
//                               child: TextField(
//                                 controller: searchController,
//                                 decoration: InputDecoration(
//                                   hintText: 'Cari...',
//                                   border: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(10),
//                                   ),
//                                 ),
//                                 onChanged: (text) {
//                                   // Update query pencarian
//                                   pengingatController.searchQuery.value = text;
//                                 },
//                               ),
//                             ),
//                             IconButton(
//                               icon: const Icon(Icons.clear, color: Colors.black),
//                               onPressed: () {
//                                 searchController.clear();
//                                 pengingatController.searchQuery.value = ''; // Reset query
//                               },
//                             ),
//                           ],
//                         ),
//                       )
//                     : SizedBox(); // Jika tidak dalam mode pencarian, tampilkan SizedBox kosong
//               },
//             ),

//             // Daftar Pengingat dengan Pencarian
//             Flexible(
//               child: Obx(() {
//                 final filteredSubcategories = pengingatController.subcategories
//                     .where((subcategory) => subcategory.name
//                         .toLowerCase()
//                         .contains(pengingatController.searchQuery.value.toLowerCase()))
//                     .toList();

//                 // Tampilkan pesan jika tidak ada hasil
//                 if (filteredSubcategories.isEmpty) {
//                   return Center(
//                     child: Text(
//                       "Tidak ada pengingat ditemukan",
//                       style: TextStyle(color: Colors.grey),
//                     ),
//                   );
//                 }

//                 // Tampilkan grid pengingat
//                 return GridView.builder(
//                   padding: EdgeInsets.all(8),
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     childAspectRatio: 1,
//                     crossAxisSpacing: 10,
//                     mainAxisSpacing: 10,
//                   ),
//                   itemCount: filteredSubcategories.length,
//                   itemBuilder: (context, index) {
//                     final subcategory = filteredSubcategories[index];

//                     return GestureDetector(
//                       onTap: () {
//                         // Navigasi ke halaman detail pengingat
//                         Get.toNamed('/reminders/contents', arguments: subcategory);
//                       },
//                       child: Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(15),
//                           image: DecorationImage(
//                             image: AssetImage('assets/images/Pengingat1.png'), // Ganti dengan gambar Pengingat
//                             fit: BoxFit.cover,
//                             colorFilter: ColorFilter.mode(
//                                 Colors.black45, BlendMode.darken),
//                           ),
//                         ),
//                         child: Center(
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text(
//                                 subcategory.name,
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                                 textAlign: TextAlign.center,
//                               ),
//                               Text(
//                                 "Halaman: ${subcategory.contentsCount}",
//                                 style: TextStyle(
//                                   color: Colors.white70,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               }),
//             ),
//           ],
//         ),
//       );
//     },
//   );
// }

//   @override
//   Widget build(BuildContext context) {
//     final ThemeController themeController = Get.find<ThemeController>();

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       controller.fetchUserProfile(); // Mengambil informasi profil pengguna
//     });

//     return Obx(
//       () => Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           title: Text(
//             'Home',
//             style: _getTextStyle(color: Colors.white),
//           ),
//           backgroundColor: themeController.currentColor,
//           centerTitle: true,
//           actions: [
//             IconButton(
//               icon: const Icon(Icons.settings, color: Colors.white),
//               onPressed: () {
//                 Get.toNamed('/settings');
//               },
//             ),
//           ],
//         ),
//         body: Container(
//           decoration: BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage('assets/images/Watermark.png'),
//               fit: BoxFit.cover,
//             ),
//           ),
//           child: Obx(() {
//             if (controller.isLoading.value) {
//               return Center(child: CircularProgressIndicator());
//             }

//             if (controller.userResponse.value == null) {
//               return Center(child: Text('No user data available'));
//             }

//             return RefreshIndicator(
//               onRefresh: () async {
//                 await controller
//                     .fetchUserProfile(); // Memuat ulang data pengguna
//               },
//               child: ListView(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
//                 children: [
//                   Container(
//                     padding: EdgeInsets.all(10),
//                     child: RichText(
//                       textAlign: TextAlign.left,
//                       text: TextSpan(
//                         text:
//                             'Assalamualaikum, ${controller.userResponse.value?.user.name} \n\n',
//                         style: _getTextStyle(fontSize: 24, color: Colors.black),
//                         children: <TextSpan>[
//                           TextSpan(
//                             text:
//                                 'Terima kasih sudah mendaftar kesini.\nOya, buku ini berisi motivasi yang menyejukkan hati, serta pengingat yang berpedoman kepada Al-Qur\'an. Semoga dapat bermanfaat dan menambah semangat dalam kehidupan sehari-hari ya.... Aamiin Ya Robbal Alamin.',
//                             style: _getTextStyle(
//                                 fontSize: 13, color: Colors.black54),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   // Kartu Motivasi
//                   Card(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(16),
//                     ),
//                     clipBehavior: Clip.antiAlias,
//                     child: InkWell(
//                       onTap: () {
//                         _showMotivasiPopup(context); // Panggil fungsi popup
//                       },
//                       child: Stack(
//                         children: [
//                           Image.asset(
//                             'assets/images/Motivasi1.png',
//                             height: 220,
//                             width: double.infinity,
//                             fit: BoxFit.cover,
//                           ),
//                           Positioned(
//                             left: 16,
//                             bottom: 16,
//                             child: Text(
//                               'Motivasi',
//                               style: _getTextStyle(
//                                 fontSize: 18,
//                                 color: Colors.white,
//                                 shadows: [
//                                   Shadow(
//                                     blurRadius: 5.0,
//                                     color: Colors.black.withOpacity(0.7),
//                                     offset: const Offset(2, 2),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           Positioned(
//                             right: 16,
//                             bottom: 16,
//                             child: Text(
//                               '>',
//                               style: _getTextStyle(
//                                   fontSize: 24, color: Colors.white),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   // Kartu Pengingat
//                   Card(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(16),
//                     ),
//                     clipBehavior: Clip.antiAlias,
//                     child: InkWell(
//                       onTap: () {
//                         _showPengingatPopup(context); // Panggil fungsi popup
//                       },
//                       child: Stack(
//                         children: [
//                           Image.asset(
//                             'assets/images/Pengingat1.png',
//                             height: 220,
//                             width: double.infinity,
//                             fit: BoxFit.cover,
//                           ),
//                           Positioned(
//                             left: 16,
//                             bottom: 10,
//                             child: Text(
//                               'Pengingat',
//                               style: _getTextStyle(
//                                 fontSize: 18,
//                                 color: Colors.white,
//                                 shadows: [
//                                   Shadow(
//                                     blurRadius: 5.0,
//                                     color: Colors.black.withOpacity(0.7),
//                                     offset: const Offset(2, 2),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           Positioned(
//                             right: 16,
//                             bottom: 16,
//                             child: Text(
//                               '>',
//                               style: _getTextStyle(
//                                   fontSize: 24, color: Colors.white),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 24),
//                   // Tombol Premium
//                   Row(
//                     children: [
//                       OutlinedButton.icon(
//                         onPressed: () {
//                           print('Navigating to Try Premium page...');
//                           final paymentStatus =
//                               Get.find<PaymentController>().paymentStatus.value;
//                           Get.toNamed(Routes.tryPremium,
//                               arguments: paymentStatus);
//                         },
//                         icon: Image.asset(
//                           'assets/images/crown.png',
//                           width: 20,
//                           height: 20,
//                         ),
//                         label: Text(
//                           'Coba Premium!',
//                           style:
//                               _getTextStyle(fontSize: 16, color: appBarColor),
//                         ),
//                         style: OutlinedButton.styleFrom(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 20, vertical: 12),
//                           side: const BorderSide(color: appBarColor, width: 2),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(16),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             );
//           }),
//         ),
//       ),
//     );
//   }
// }

import 'dart:ui';
import 'package:ebookapp/app/modules/motivasi/controllers/motivasi_controller.dart';
import 'package:ebookapp/app/modules/pengingat/controllers/pengingat_category_controller.dart';
import 'package:ebookapp/app/modules/settings/controllers/payment_detail_controller.dart';
import 'package:ebookapp/app/modules/settings/controllers/setting_theme_controller.dart';
import 'package:ebookapp/app/routes/app_pages.dart';
import 'package:ebookapp/core/constants/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  static const Color appBarColor = Color(0xFF32497B);

  TextStyle _getTextStyle({
    double fontSize = 20,
    Color color = Colors.black,
    List<Shadow>? shadows,
  }) {
    return GoogleFonts.leagueSpartan(
      fontSize: fontSize,
      color: color,
      fontWeight: FontWeight.bold,
      height: 0.9,
      shadows: shadows ?? [],
    );
  }

  void _showMotivasiPopup(BuildContext context) {
    final MotivasiController motivasiController =
        Get.find<MotivasiController>();
    final TextEditingController searchController = TextEditingController();
    final ValueNotifier<bool> isSearching = ValueNotifier<bool>(false);

    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.3),
      builder: (BuildContext context) {
        motivasiController.searchQuery.value = '';

        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Dialog(
            backgroundColor: Colors.white.withOpacity(0.9),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: colorBackground,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Motivasi',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: Icon(Icons.search, color: Colors.white),
                          onPressed: () {
                            isSearching.value = !isSearching.value;
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                // Search TextField
                ValueListenableBuilder<bool>(
                  valueListenable: isSearching,
                  builder: (context, value, child) {
                    return value
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                const Icon(Icons.search, color: Colors.grey),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: TextField(
                                    controller: searchController,
                                    decoration: InputDecoration(
                                      hintText: 'Cari...',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    onChanged: (text) {
                                      motivasiController.searchQuery.value =
                                          text;
                                    },
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.clear,
                                      color: Colors.black),
                                  onPressed: () {
                                    searchController.clear();
                                    motivasiController.searchQuery.value = '';
                                  },
                                ),
                              ],
                            ),
                          )
                        : SizedBox();
                  },
                ),

                // Motivasi List
                Flexible(
                  child: Obx(() {
                    final filteredSubcategories = motivasiController
                        .subcategories
                        .where((subcategory) => subcategory.name
                            .toLowerCase()
                            .contains(motivasiController.searchQuery.value
                                .toLowerCase()))
                        .toList();

                    if (filteredSubcategories.isEmpty) {
                      return Center(
                        child: Text(
                          "Tidak ada motivasi ditemukan",
                          style: TextStyle(color: Colors.grey),
                        ),
                      );
                    }

                    return GridView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.all(8),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: filteredSubcategories.length,
                      itemBuilder: (context, index) {
                        final subcategory = filteredSubcategories[index];

                        return GestureDetector(
                          onTap: () {
                            Get.toNamed('/motivation/contents',
                                arguments: subcategory);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                image:
                                    AssetImage('assets/images/Motivasi1.png'),
                                fit: BoxFit.cover,
                                colorFilter: ColorFilter.mode(
                                    Colors.black45, BlendMode.darken),
                              ),
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    subcategory.name,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "Halaman: ${subcategory.contentsCount}",
                                    style: TextStyle(
                                      color: Colors.white70,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Popup Pengingat
  void _showPengingatPopup(BuildContext context) {
    final PengingatIdController pengingatController =
        Get.find<PengingatIdController>();
    final TextEditingController searchController = TextEditingController();
    final ValueNotifier<bool> isSearching = ValueNotifier<bool>(false);

    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.3),
      builder: (BuildContext context) {
        pengingatController.searchQuery.value = '';

        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Dialog(
            backgroundColor: Colors.white.withOpacity(0.9),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: colorBackground,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Pengingat',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: Icon(Icons.search, color: Colors.white),
                          onPressed: () {
                            isSearching.value = !isSearching.value;
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                // Search TextField
                ValueListenableBuilder<bool>(
                  valueListenable: isSearching,
                  builder: (context, value, child) {
                    return value
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                const Icon(Icons.search, color: Colors.grey),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: TextField(
                                    controller: searchController,
                                    decoration: InputDecoration(
                                      hintText: 'Cari...',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    onChanged: (text) {
                                      pengingatController.searchQuery.value =
                                          text;
                                    },
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.clear,
                                      color: Colors.black),
                                  onPressed: () {
                                    searchController.clear();
                                    pengingatController.searchQuery.value = '';
                                  },
                                ),
                              ],
                            ),
                          )
                        : SizedBox();
                  },
                ),

                // Pengingat List
                Flexible(
                  child: Obx(() {
                    final filteredSubcategories = pengingatController
                        .subcategories
                        .where((subcategory) => subcategory.name
                            .toLowerCase()
                            .contains(pengingatController.searchQuery.value
                                .toLowerCase()))
                        .toList();

                    if (filteredSubcategories.isEmpty) {
                      return Center(
                        child: Text(
                          "Tidak ada pengingat ditemukan",
                          style: TextStyle(color: Colors.grey),
                        ),
                      );
                    }

                    return GridView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.all(8),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: filteredSubcategories.length,
                      itemBuilder: (context, index) {
                        final subcategory = filteredSubcategories[index];

                        return GestureDetector(
                          onTap: () {
                            Get.toNamed('/reminders/contents',
                                arguments: subcategory);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                image:
                                    AssetImage('assets/images/Pengingat1.png'),
                                fit: BoxFit.cover,
                                colorFilter: ColorFilter.mode(
                                    Colors.black45, BlendMode.darken),
                              ),
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    subcategory.name,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "Halaman: ${subcategory.contentsCount}",
                                    style: TextStyle(
                                      color: Colors.white70,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchUserProfile();
    });

    return Obx(
      () => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'Home',
            style: _getTextStyle(color: Colors.white),
          ),
          backgroundColor: themeController.currentColor,
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.settings, color: Colors.white),
              onPressed: () {
                Get.toNamed('/settings');
              },
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/Watermark.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Obx(() {
            if (controller.isLoading.value) {
              return Center(child: CircularProgressIndicator());
            }

            if (controller.userResponse.value == null) {
              return Center(child: Text('No user data available'));
            }

            return RefreshIndicator(
              onRefresh: () async {
                await controller.fetchUserProfile();
              },
              child: ListView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    child: RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(
                        text:
                            'Assalamualaikum, ${controller.userResponse.value?.user.name} \n\n',
                        style: _getTextStyle(fontSize: 24, color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(
                            text:
                                'Terima kasih sudah mendaftar kesini.\nOya, buku ini berisi motivasi yang menyejukkan hati, serta pengingat yang berpedoman kepada Al-Qur\'an. Semoga dapat bermanfaat dan menambah semangat dalam kehidupan sehari-hari ya.... Aamiin Ya Robbal Alamin.',
                            style: _getTextStyle(
                                fontSize: 13, color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Kartu Motivasi
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: InkWell(
                      onTap: () {
                        _showMotivasiPopup(context);
                      },
                      child: Stack(
                        children: [
                          Image.asset(
                            'assets/images/Motivasi1.png',
                            height: 220,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            left: 16,
                            bottom: 16,
                            child: Text(
                              'Motivasi',
                              style: _getTextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                shadows: [
                                  Shadow(
                                    blurRadius: 5.0,
                                    color: Colors.black.withOpacity(0.7),
                                    offset: const Offset(2, 2),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            right: 16,
                            bottom: 16,
                            child: Text(
                              '>',
                              style: _getTextStyle(
                                  fontSize: 24, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Kartu Pengingat
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: InkWell(
                      onTap: () {
                        _showPengingatPopup(context);
                      },
                      child: Stack(
                        children: [
                          Image.asset(
                            'assets/images/Pengingat1.png',
                            height: 220,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            left: 16,
                            bottom: 10,
                            child: Text(
                              'Pengingat',
                              style: _getTextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                shadows: [
                                  Shadow(
                                    blurRadius: 5.0,
                                    color: Colors.black.withOpacity(0.7),
                                    offset: const Offset(2, 2),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            right: 16,
                            bottom: 16,
                            child: Text(
                              '>',
                              style: _getTextStyle(
                                  fontSize: 24, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Tombol Premium
                  Row(
                    children: [
                      OutlinedButton.icon(
                        onPressed: () {
                          final paymentStatus =
                              Get.find<PaymentController>().paymentStatus.value;
                          Get.toNamed(Routes.tryPremium,
                              arguments: paymentStatus);
                        },
                        icon: Image.asset(
                          'assets/images/crown.png',
                          width: 20,
                          height: 20,
                        ),
                        label: Text(
                          'Coba Premium!',
                          style:
                              _getTextStyle(fontSize: 16, color: appBarColor),
                        ),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          side: const BorderSide(color: appBarColor, width: 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
