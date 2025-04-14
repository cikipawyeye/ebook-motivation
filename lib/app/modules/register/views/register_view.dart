// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:google_fonts/google_fonts.dart';
// // import 'package:intl/intl.dart';
// // import 'package:ebookapp/app/modules/register/controllers/register_controller.dart';
// // import 'package:ebookapp/core/constants/constant.dart';
// // import 'package:smooth_page_indicator/smooth_page_indicator.dart';
//
// // class RegisterPage extends GetView<RegisterController> {
// //   final PageController _pageController = PageController();
//
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.white,
// //       appBar: _buildAppBar(),
// //       body: SafeArea(
// //         child: Padding(
// //           padding: const EdgeInsets.all(20), // Add padding here
// //           child: Column(
// //             children: [
// //               Expanded(
// //                 child: PageView(
// //                   controller: _pageController,
// //                   physics: NeverScrollableScrollPhysics(),
// //                   children: [
// //                     _buildNameStep(),
// //                     _buildEmailStep(),
// //                     _buildPhoneStep(),
// //                     _buildDobStep(),
// //                     _buildDomisiliStep(),
// //                     _buildGenderStep(),
// //                     _buildJobStep(),
// //                     _buildPasswordStep(),
// //                   ],
// //                 ),
// //               ),
// //               _buildNavigationButton(),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
//
// //   // App Bar
// //   PreferredSizeWidget _buildAppBar() {
// //     return AppBar(
// //       backgroundColor: Colors.white,
// //       elevation: 0,
// //       leading: IconButton(
// //         icon: Icon(Icons.arrow_back, color: Colors.black),
// //         onPressed: () => Get.back(),
// //       ),
// //       title: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           SmoothPageIndicator(
// //             controller: _pageController,
// //             count: 8,
// //             effect: WormEffect(
// //               activeDotColor: colorBackground,
// //               dotColor: Colors.grey,
// //               dotHeight: 8,
// //               dotWidth: 8,
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
//
// //   // // Progress Indicator
// //   // Widget _buildProgressIndicator() {
// //   //   return SmoothPageIndicator(
// //   //     controller: _pageController,
// //   //     count: 8,
// //   //     effect: WormEffect(
// //   //       activeDotColor: colorBackground,
// //   //       dotColor: Colors.grey,
// //   //       dotHeight: 8,
// //   //       dotWidth: 8,
// //   //     ),
// //   //   );
// //   // }
//
// //   // Step Name
// //   Widget _buildNameStep() {
// //     return _buildScrollableColumn(child: [
// //       Text(
// //         'Halo, Kenalan dulu yuk!',
// //         style: GoogleFonts.leagueSpartan(
// //           fontSize: 34,
// //           fontWeight: FontWeight.bold,
// //         ),
// //       ),
// //       Text(
// //         'Siapa Nama Kamu?',
// //         style: GoogleFonts.leagueSpartan(
// //           fontSize: 14,
// //           fontWeight: FontWeight.normal,
// //         ),
// //       ),
// //       SizedBox(height: 20),
// //       Obx(() => TextField(
// //             controller: controller.nameController,
// //             decoration: InputDecoration(
// //               labelText: 'Nama Lengkap',
// //               errorText: controller.isNameError.value
// //                   ? 'Nama harus minimal 2 karakter'
// //                   : null,
// //               border: OutlineInputBorder(
// //                 borderRadius: BorderRadius.circular(30),
// //                 borderSide: BorderSide(color: Colors.grey, width: 1.5),
// //               ),
// //               focusedBorder: OutlineInputBorder(
// //                 borderRadius: BorderRadius.circular(30),
// //                 borderSide: BorderSide(color: colorBackground, width: 2),
// //               ),
// //               enabledBorder: OutlineInputBorder(
// //                 borderRadius: BorderRadius.circular(30),
// //                 borderSide: BorderSide(color: Colors.grey, width: 1.5),
// //               ),
// //             ),
// //             onChanged: (value) {
// //               controller.validateName(); // Called on every change
// //             },
// //           )),
// //     ]);
// //   }
//
// //   // Step Email
// //   Widget _buildEmailStep() {
// //     return _buildScrollableColumn(
// //       child: [
// //         Obx(
// //           () => Text(
// //             'Terima kasih, ${controller.firstName.value}!', // Ensure this is reactive
// //             style: GoogleFonts.leagueSpartan(
// //               fontSize: 28,
// //               fontWeight: FontWeight.bold,
// //             ),
// //           ),
// //         ),
// //         Text.rich(
// //           TextSpan(
// //             text: 'Sekarang, ',
// //             style: GoogleFonts.leagueSpartan(
// //               fontSize: 14,
// //               fontWeight: FontWeight.normal,
// //             ),
// //             children: [
// //               TextSpan(
// //                 text: 'masukkan email kamu ya!',
// //                 style: GoogleFonts.leagueSpartan(
// //                   fontSize: 14,
// //                   fontWeight: FontWeight.bold,
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //         Text(
// //           'Kami akan menggunakannya untuk informasi penting nanti.',
// //           style: GoogleFonts.leagueSpartan(
// //             fontSize: 14,
// //             fontWeight: FontWeight.normal,
// //           ),
// //         ),
// //         SizedBox(height: 20),
// //         Obx(() => TextField(
// //               controller: controller.emailController,
// //               keyboardType: TextInputType.emailAddress,
// //               decoration: InputDecoration(
// //                 labelText: 'Email',
// //                 errorText:
// //                     controller.isEmailError.value ? 'Email tidak valid' : null,
// //                 border: OutlineInputBorder(
// //                   borderRadius: BorderRadius.circular(30),
// //                   borderSide: BorderSide(color: Colors.grey, width: 1.5),
// //                 ),
// //                 focusedBorder: OutlineInputBorder(
// //                   borderRadius: BorderRadius.circular(30),
// //                   borderSide: BorderSide(color: colorBackground, width: 2),
// //                 ),
// //                 enabledBorder: OutlineInputBorder(
// //                   borderRadius: BorderRadius.circular(30),
// //                   borderSide: BorderSide(color: Colors.grey, width: 1.5),
// //                 ),
// //               ),
// //               onChanged: (_) => controller.validateEmail(),
// //             )),
// //       ],
// //     );
// //   }
//
// //   // Step Phone
// //   Widget _buildPhoneStep() {
// //     return _buildScrollableColumn(child: [
// //       Text(
// //         'Agar kami bisa\nlebih dekat denganmu...',
// //         style: GoogleFonts.leagueSpartan(
// //           fontSize: 28,
// //           fontWeight: FontWeight.bold,
// //         ),
// //       ),
// //       Text.rich(
// //         TextSpan(
// //           text: 'Silahkan, ',
// //           style: GoogleFonts.leagueSpartan(
// //             fontSize: 14,
// //             fontWeight: FontWeight.normal,
// //           ),
// //           children: [
// //             TextSpan(
// //               text: 'masukkan nomor telepon',
// //               style: GoogleFonts.leagueSpartan(
// //                 fontSize: 14,
// //                 fontWeight: FontWeight.bold,
// //               ),
// //             ),
// //             TextSpan(
// //               text: 'yang aktif ya!',
// //               style: GoogleFonts.leagueSpartan(
// //                 fontSize: 14,
// //                 fontWeight: FontWeight.bold,
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //       SizedBox(height: 20),
// //       Obx(() => TextField(
// //             controller: controller.phoneNumberController,
// //             keyboardType: TextInputType.phone,
// //             decoration: InputDecoration(
// //               labelText: 'Nomor Telepon',
// //               errorText: controller.isPhoneError.value
// //                   ? 'Nomor telepon tidak valid'
// //                   : null,
// //               border: OutlineInputBorder(
// //                 borderRadius: BorderRadius.circular(30),
// //                 borderSide: BorderSide(color: Colors.grey, width: 1.5),
// //               ),
// //               focusedBorder: OutlineInputBorder(
// //                 borderRadius: BorderRadius.circular(30),
// //                 borderSide: BorderSide(color: colorBackground, width: 2),
// //               ),
// //               enabledBorder: OutlineInputBorder(
// //                 borderRadius: BorderRadius.circular(30),
// //                 borderSide: BorderSide(color: Colors.grey, width: 1.5),
// //               ),
// //             ),
// //             onChanged: (_) => controller.validatePhoneNumber(),
// //           )),
// //     ]);
// //   }
//
// //   // Step Date of Birth
// //   Widget _buildDobStep() {
// //     return _buildScrollableColumn(child: [
// //       Text(
// //         'Ulang tahunmu spesial!',
// //         style: GoogleFonts.leagueSpartan(
// //             fontSize: 28, fontWeight: FontWeight.bold),
// //       ),
// //       Text(
// //         'Kapan hari lahirmu',
// //         style: GoogleFonts.leagueSpartan(
// //             fontSize: 14, fontWeight: FontWeight.normal),
// //       ),
// //       SizedBox(height: 20),
// //       TextField(
// //         controller: controller.dobController,
// //         decoration: InputDecoration(
// //           labelText: 'Pilih Tanggal Lahir',
// //           border: OutlineInputBorder(
// //             borderRadius: BorderRadius.circular(30),
// //             borderSide: BorderSide(color: Colors.grey, width: 1.5),
// //           ),
// //           focusedBorder: OutlineInputBorder(
// //             borderRadius: BorderRadius.circular(30),
// //             borderSide: BorderSide(color: colorBackground, width: 2),
// //           ),
// //           enabledBorder: OutlineInputBorder(
// //             borderRadius: BorderRadius.circular(30),
// //             borderSide: BorderSide(color: Colors.grey, width: 1.5),
// //           ),
// //         ),
// //         onTap: () async {
// //           DateTime? pickedDate = await showDatePicker(
// //             context: Get.context!,
// //             initialDate: DateTime.now(),
// //             firstDate: DateTime(1900),
// //             lastDate: DateTime.now(),
// //           );
// //           if (pickedDate != null) {
// //             controller.dobController.text =
// //                 DateFormat('yyyy-MM-dd').format(pickedDate);
// //             controller.validateDob();
// //           }
// //         },
// //         readOnly: true,
// //       ),
// //     ]);
// //   }
//
// //   // Step City/Domicile
// //   Widget _buildDomisiliStep() {
// //     return _buildScrollableColumn(child: [
// //       Text(
// //         'Biar kami tahu lebih\nbanyak tentangmu...',
// //         style: GoogleFonts.leagueSpartan(
// //             fontSize: 28, fontWeight: FontWeight.bold),
// //       ),
// //       Text.rich(
// //         TextSpan(
// //           text: 'Kamu tinggal, ',
// //           style: GoogleFonts.leagueSpartan(
// //             fontSize: 14,
// //             fontWeight: FontWeight.normal,
// //           ),
// //           children: [
// //             TextSpan(
// //               text: 'di kota atau kabupaten mana?',
// //               style: GoogleFonts.leagueSpartan(
// //                 fontSize: 14,
// //                 fontWeight: FontWeight.bold,
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //       SizedBox(height: 20),
// //       TextField(
// //         controller: controller.domisiliController,
// //         decoration: InputDecoration(
// //           labelText: 'Cari Kota/Kabupaten',
// //           border: OutlineInputBorder(
// //             borderRadius: BorderRadius.circular(30),
// //             borderSide: BorderSide(color: Colors.grey, width: 1.5),
// //           ),
// //           focusedBorder: OutlineInputBorder(
// //             borderRadius: BorderRadius.circular(30),
// //             borderSide: BorderSide(color: colorBackground, width: 2),
// //           ),
// //           enabledBorder: OutlineInputBorder(
// //             borderRadius: BorderRadius.circular(30),
// //             borderSide: BorderSide(color: Colors.grey, width: 1.5),
// //           ),
// //         ),
// //         onChanged: (value) => controller.fetchCities(value),
// //       ),
// //       Obx(() => Column(
// //             children: controller.domisiliList
// //                 .map((city) => ListTile(
// //                       title: Text(city['name']),
// //                       onTap: () => controller.onCitySelected(city),
// //                     ))
// //                 .toList(),
// //           )),
// //     ]);
// //   }
//
// //   // Step Gender
// //   Widget _buildGenderStep() {
// //     return _buildScrollableColumn(child: [
// //       Text(
// //         'Setiap perjalanan\nitu unik...',
// //         style: GoogleFonts.leagueSpartan(
// //             fontSize: 28, fontWeight: FontWeight.bold),
// //       ),
// //       Text.rich(
// //         TextSpan(
// //           text: 'Boleh pilih ',
// //           style: GoogleFonts.leagueSpartan(
// //             fontSize: 14,
// //             fontWeight: FontWeight.normal,
// //           ),
// //           children: [
// //             TextSpan(
// //               text: 'jenis kelaminmu?',
// //               style: GoogleFonts.leagueSpartan(
// //                 fontSize: 14,
// //                 fontWeight: FontWeight.bold,
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //       SizedBox(height: 20),
// //       Obx(() => Column(
// //             children: [
// //               GestureDetector(
// //                 onTap: () {
// //                   controller.setGender('M'); // Laki-laki
// //                 },
// //                 child: Container(
// //                   width: 400,
// //                   padding: EdgeInsets.all(12),
// //                   margin: EdgeInsets.only(right: 10),
// //                   decoration: BoxDecoration(
// //                     color: controller.selectedGender.value == 'M'
// //                         ? colorBackground
// //                         : Colors.white,
// //                     borderRadius: BorderRadius.circular(10),
// //                     border: Border.all(
// //                       color: controller.selectedGender.value == 'M'
// //                           ? colorBackground
// //                           : Colors.grey,
// //                     ),
// //                   ),
// //                   child: Text(
// //                     'Laki-laki',
// //                     style: TextStyle(
// //                       color: controller.selectedGender.value == 'M'
// //                           ? Colors.white
// //                           : Colors.black,
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //               SizedBox(
// //                 height: 10,
// //               ),
// //               GestureDetector(
// //                 onTap: () {
// //                   controller.setGender('F'); // Perempuan
// //                 },
// //                 child: Container(
// //                   width: 400,
// //                   padding: EdgeInsets.all(12),
// //                   margin: EdgeInsets.only(right: 10),
// //                   decoration: BoxDecoration(
// //                     color: controller.selectedGender.value == 'F'
// //                         ? colorBackground
// //                         : Colors.white,
// //                     borderRadius: BorderRadius.circular(10),
// //                     border: Border.all(
// //                       color: controller.selectedGender.value == 'F'
// //                           ? colorBackground
// //                           : Colors.grey,
// //                     ),
// //                   ),
// //                   child: Text(
// //                     'Perempuan',
// //                     style: TextStyle(
// //                       color: controller.selectedGender.value == 'F'
// //                           ? Colors.white
// //                           : Colors.black,
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //             ],
// //           )),
// //     ]);
// //   }
//
// //   // Step Job
// //   Widget _buildJobStep() {
// //     final Map<String, String> jobType = {
// //       '0': 'Lainnya',
// //       '1': 'Pelajar',
// //       '2': 'Mahasiswa',
// //       '3': 'Pegawai Negeri (ASN)',
// //       '4': 'Pegawai Swasta/Karyawan Swasta',
// //       '5': 'Profesional/Ahli',
// //       '6': 'Ibu Rumah Tangga',
// //       '7': 'Wiraswasta/Pengusaha',
// //       '8': 'Tidak Bekerja',
// //     };
//
// //     return _buildScrollableColumn(
// //       child: [
// //         Text(
// //           'Hampir selesai!',
// //           style: GoogleFonts.leagueSpartan(
// //             fontSize: 28,
// //             fontWeight: FontWeight.bold,
// //           ),
// //         ),
// //         Text.rich(
// //           TextSpan(
// //             text: 'Boleh tahu ',
// //             style: GoogleFonts.leagueSpartan(
// //               fontSize: 14,
// //               fontWeight: FontWeight.normal,
// //             ),
// //             children: [
// //               TextSpan(
// //                 text: 'apa pekerjaanmu saat ini?',
// //                 style: GoogleFonts.leagueSpartan(
// //                   fontSize: 14,
// //                   fontWeight: FontWeight.bold,
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //         SizedBox(height: 20),
// //         Obx(() => Column(
// //               children: jobType.entries.map((entry) {
// //                 final key = entry.key; // key (String)
// //                 final title = entry.value; // value (job title)
// //                 return GestureDetector(
// //                   onTap: () {
// //                     controller.selectedJobType.value =
// //                         int.parse(key); // Update selected job type
// //                   },
// //                   child: Container(
// //                     width: 400,
// //                     margin:
// //                         EdgeInsets.only(bottom: 10), // Space between options
// //                     padding: EdgeInsets.all(15),
// //                     decoration: BoxDecoration(
// //                       color: controller.selectedJobType.value == int.parse(key)
// //                           ? colorBackground
// //                           : Colors.white,
// //                       borderRadius: BorderRadius.circular(20),
// //                       border: Border.all(
// //                         color:
// //                             controller.selectedJobType.value == int.parse(key)
// //                                 ? colorBackground
// //                                 : Colors.black,
// //                         width: 1.5,
// //                       ),
// //                     ),
// //                     child: Text(
// //                       title,
// //                       style: TextStyle(
// //                         color:
// //                             controller.selectedJobType.value == int.parse(key)
// //                                 ? Colors.white
// //                                 : Colors.black,
// //                       ),
// //                     ),
// //                   ),
// //                 );
// //               }).toList(),
// //             )),
// //         Obx(() => controller.selectedJobType.value ==
// //                 0 // Assuming 'Lain lainnya' has the index 0
// //             ? TextField(
// //                 controller: controller.customJobController,
// //                 decoration: InputDecoration(
// //                   labelText: 'Tuliskan Pekerjaan Lain',
// //                   border: OutlineInputBorder(
// //                     borderRadius: BorderRadius.circular(30),
// //                     borderSide: BorderSide(color: Colors.grey, width: 1.5),
// //                   ),
// //                   focusedBorder: OutlineInputBorder(
// //                     borderRadius: BorderRadius.circular(30),
// //                     borderSide: BorderSide(color: colorBackground, width: 2),
// //                   ),
// //                   enabledBorder: OutlineInputBorder(
// //                     borderRadius: BorderRadius.circular(30),
// //                     borderSide: BorderSide(color: Colors.grey, width: 1.5),
// //                   ),
// //                 ),
// //               )
// //             : SizedBox.shrink()),
// //       ],
// //     );
// //   }
//
// //   // Step Password
// //   Widget _buildPasswordStep() {
// //     return _buildScrollableColumn(
// //       child: [
// //         Text(
// //           'Atur kata sandi kamu',
// //           style: GoogleFonts.leagueSpartan(
// //               fontSize: 28, fontWeight: FontWeight.bold),
// //         ),
// //         Text(
// //           'Buat kata sandi mu agar aman ya!',
// //           style: GoogleFonts.leagueSpartan(
// //               fontSize: 14, fontWeight: FontWeight.normal),
// //         ),
// //         SizedBox(height: 20),
// //         Obx(
// //           () => Column(
// //             children: [
// //               // Password Field
// //               TextField(
// //                 controller: controller.passwordController,
// //                 obscureText: !controller.isPasswordVisible.value,
// //                 decoration: InputDecoration(
// //                   labelText: 'Kata Sandi',
// //                   errorText: controller.isPasswordError.value
// //                       ? 'Password minimal 8 karakter, huruf kapital dan angka'
// //                       : null,
// //                   suffixIcon: IconButton(
// //                     icon: Icon(controller.isPasswordVisible.value
// //                         ? Icons.visibility
// //                         : Icons.visibility_off),
// //                     onPressed: controller.togglePasswordVisibility,
// //                   ),
// //                   border: OutlineInputBorder(
// //                     borderRadius: BorderRadius.circular(30),
// //                     borderSide: BorderSide(color: Colors.grey, width: 1.5),
// //                   ),
// //                   focusedBorder: OutlineInputBorder(
// //                     borderRadius: BorderRadius.circular(30),
// //                     borderSide: BorderSide(color: colorBackground, width: 2),
// //                   ),
// //                   enabledBorder: OutlineInputBorder(
// //                     borderRadius: BorderRadius.circular(30),
// //                     borderSide: BorderSide(color: Colors.grey, width: 1.5),
// //                   ),
// //                 ),
// //                 onChanged: (value) => controller.validatePassword(value),
// //               ),
// //               SizedBox(height: 16),
//
// //               // Confirm Password Field
// //               TextField(
// //                 controller: controller.confirmPasswordController,
// //                 obscureText: !controller.isConfirmPasswordVisible.value,
// //                 decoration: InputDecoration(
// //                   labelText: 'Konfirmasi Kata Sandi',
// //                   errorText: controller.isConfirmPasswordError.value
// //                       ? 'Konfirmasi password tidak cocok'
// //                       : null,
// //                   suffixIcon: IconButton(
// //                     icon: Icon(controller.isConfirmPasswordVisible.value
// //                         ? Icons.visibility
// //                         : Icons.visibility_off),
// //                     onPressed: controller.toggleConfirmPasswordVisibility,
// //                   ),
// //                   border: OutlineInputBorder(
// //                     borderRadius: BorderRadius.circular(30),
// //                     borderSide: BorderSide(color: Colors.grey, width: 1.5),
// //                   ),
// //                   focusedBorder: OutlineInputBorder(
// //                     borderRadius: BorderRadius.circular(30),
// //                     borderSide: BorderSide(color: colorBackground, width: 2),
// //                   ),
// //                   enabledBorder: OutlineInputBorder(
// //                     borderRadius: BorderRadius.circular(30),
// //                     borderSide: BorderSide(color: Colors.grey, width: 1.5),
// //                   ),
// //                 ),
// //                 onChanged: (value) => controller.validateConfirmPassword(value),
// //               ),
// //               SizedBox(height: 16),
//
// //               // CheckBox for terms and conditions
// //               Obx(
// //                 () => Row(
// //                   children: [
// //                     Checkbox(
// //                       value: controller.isAgreed.value,
// //                       onChanged: (value) {
// //                         if (value != null) {
// //                           controller.isAgreed.value = value;
// //                           if (value) {
// //                             _showTermsAndConditions(Get.context!);
// //                           }
// //                         }
// //                       },
// //                     ),
// //                     Expanded(
// //                       // Use Expanded to prevent overflow
// //                       child: Text.rich(
// //                         TextSpan(
// //                           text: 'Saya telah menyetujui ',
// //                           style: GoogleFonts.leagueSpartan(
// //                             fontSize: 14,
// //                             fontWeight: FontWeight.normal,
// //                           ),
// //                           children: [
// //                             TextSpan(
// //                               text: 'term of service',
// //                               style: GoogleFonts.leagueSpartan(
// //                                 fontSize: 14,
// //                                 fontWeight: FontWeight.bold,
// //                               ),
// //                             ),
// //                             TextSpan(
// //                               text: 'dan ',
// //                               style: GoogleFonts.leagueSpartan(
// //                                 fontSize: 14,
// //                                 fontWeight: FontWeight.normal,
// //                               ),
// //                             ),
// //                             TextSpan(
// //                               text: 'Privacy Policy',
// //                               style: GoogleFonts.leagueSpartan(
// //                                 fontSize: 14,
// //                                 fontWeight: FontWeight.bold,
// //                               ),
// //                             ),
// //                             TextSpan(
// //                               text: ' yang berlaku.',
// //                               style: GoogleFonts.leagueSpartan(
// //                                 fontSize: 14,
// //                                 fontWeight: FontWeight.normal,
// //                               ),
// //                             ),
// //                           ],
// //                         ),
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ],
// //     );
// //   }
//
// //   // Navigation Button
// //   Widget _buildNavigationButton() {
// //     return Obx(() => ElevatedButton(
// //           onPressed: controller.isLoading.value ? null : _navigateOrRegister,
// //           style: ElevatedButton.styleFrom(
// //             minimumSize: Size(double.infinity, 50),
// //             backgroundColor: colorBackground,
// //           ),
// //           child: controller.isLoading.value
// //               ? CircularProgressIndicator(color: Colors.white)
// //               : Text(
// //                   'Lanjutkan',
// //                   style: GoogleFonts.leagueSpartan(
// //                     color: Colors.white,
// //                     fontWeight: FontWeight.bold,
// //                   ),
// //                 ),
// //         ));
// //   }
//
// //   // Logic Navigation
// //   void _navigateOrRegister() {
// //     int currentPage = _pageController.page?.round() ?? 0;
//
// //     // Navigasi hanya jika halaman ada
// //     if (currentPage == 7) {
// //       controller.register();
// //     } else if (currentPage < 7) {
// //       // Melanjutkan ke halaman berikutnya
// //       _pageController.nextPage(
// //         duration: Duration(milliseconds: 300),
// //         curve: Curves.easeInOut,
// //       );
// //     }
// //   }
//
// //   // Metode untuk menampilkan pesan kesalahan validasi
// //   void _showValidationError(String message) {
// //     Get.snackbar(
// //       'Validasi Gagal',
// //       message,
// //       snackPosition: SnackPosition.BOTTOM,
// //       backgroundColor: Colors.red,
// //       colorText: Colors.white,
// //       duration: Duration(seconds: 2),
// //     );
// //   }
//
// // // Gender Step dengan perbaikan
//
// //   void _showTermsAndConditions(BuildContext context) {
// //     showDialog(
// //       context: context,
// //       builder: (BuildContext context) {
// //         return AlertDialog(
// //           backgroundColor: Colors.white,
// //           title: Text(
// //             'SYARAT KETENTUAN PENGGUNAAN DAN KEBIJAKAN PRIVASI',
// //             style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
// //           ),
// //           content: SingleChildScrollView(
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Text(
// // 'Aplikasi Mobile Motivasi Penyejuk Hati dari Al-Qur’an\n'
// // 'Versi Terakhir: 6 Desember 2024\n'
// // 'Selamat datang di aplikasi mobile e-book Motivasi Penyejuk Hati dari Al-Qur’an. '
// // 'Syarat dan Ketentuan ini mengatur akses dan penggunaan Aplikasi oleh pengguna ("Anda") '
// // 'yang disediakan oleh [Eli Nur Nirmala Sari] ("Kami"). Dengan mengunduh, menginstal, '
// // 'dan menggunakan Aplikasi ini, Anda menyetujui seluruh syarat dan ketentuan yang berlaku.\n'
// // 'Jika Anda tidak setuju dengan salah satu bagian dari Ketentuan ini, harap segera berhenti menggunakan Aplikasi.\n\n'
// // '1. Pendahuluan\n'
// // '1.1 Deskripsi Layanan\n'
// // 'Aplikasi ini menyediakan akses ke e-book Motivasi Penyejuk Hati dari Al-Qur’an, '
// // 'termasuk artikel, konten premium, dan fitur lainnya yang dirancang untuk mendukung pengalaman membaca Anda.\n'
// // '1.2 Penerimaan Ketentuan\n'
// // 'Dengan menggunakan Aplikasi ini, Anda menyetujui Ketentuan ini, kebijakan privasi, '
// // 'dan semua peraturan lainnya yang kami tetapkan terkait penggunaan layanan.\n\n'
// // '2. Ketentuan Penggunaan\n'
// // '2.1 Registrasi Akun\n'
// // 'Anda wajib membuat akun untuk menggunakan beberapa fitur Aplikasi. '
// // 'Data yang diperlukan meliputi nama lengkap, alamat email, dan password.\n'
// // 'Anda bertanggung jawab menjaga kerahasiaan akun Anda dan tidak boleh membagikannya kepada pihak ketiga.\n'
// // '2.2 Batasan Usia\n'
// // 'Aplikasi ini hanya boleh digunakan oleh individu yang berusia minimal 13 tahun.\n'
// // 'Jika Anda berusia di bawah 18 tahun, Anda harus mendapatkan izin dari orang tua atau wali Anda.\n'
// // '2.3 Penggunaan yang Dilarang\n'
// // 'You dilarang menggunakan Aplikasi untuk:\n'
// // 'Konten yang melanggar hukum, diskriminatif, atau berisi ujaran kebencian.\n'
// // 'Mendistribusikan ulang konten dari Aplikasi tanpa persetujuan tertulis dari Kami.\n\n'
// // '3. Fitur Pembayaran\n'
// // '3.1 Konten Premium dan Transaksi\n'
// // 'Beberapa e-book atau fitur dalam Aplikasi hanya dapat diakses dengan pembelian tertentu '
// // 'menggunakan layanan pembayaran yang terintegrasi (Xendit).\n'
// // 'Semall transaksi bersifat final dan tidak dapat dikembalikan, kecuali terdapat kesalahan teknis pada sistem Kami.\n'
// // '3.2 Keamanan Pembayaran\n'
// // 'Kami bekerja sama dengan penyedia layanan pembayaran terpercaya untuk memproses transaksi Anda.\n'
// // 'You wajib memastikan informasi pembayaran yang diberikan adalah benar dan akurat.\n\n'
// // '4. Hak Kekayaan Intelektual\n'
// // '4.1 Hak Cipta dan Konten\n'
// // 'Semua konten di Aplikasi, termasuk e-book, artikel, desain, logo, dan fitur lainnya, '
// // 'adalam milik Kami atau pemberi lisensi Kami, dan dilindungi oleh undang-undang hak cipta.\n'
// // 'You tidak diperbolehkan menyalin, mendistribusikan, atau memodifikasi konten Aplikasi tanpa izin tertulis dari Kami.\n\n'
// // '5. Kebijakan Keamanan\n'
// // '5.1 Data Pengguna\n'
// // 'Kami berkomitmen untuk menjaga keamanan data pribadi Anda. Kebijakan penggunaan data sepenuhnya diatur dalam Kebijakan Privasi Kami.\n'
// // '5.2 Tanggung Jawab Anda\n'
// // 'You bertanggung jawab atas keamanan perangkat Anda dalam menggunakan Aplikasi, '
// // 'termasuk memastikan perangkat bebas dari virus atau perangkat lunak berbahaya lainnya.\n'
// // '5.3 Penyalahgunaan Akun\n'
// // 'Kami tidak bertanggung jawab atas akses yang tidak sah ke akun Anda yang disebabkan oleh kelalaian Anda dalam menjaga kerahasiaan data akun Anda.\n\n'
// // '6. Batasan Tanggung Jawab\n'
// // '6.1 Kegagalan Sistem atau Layanan\n'
// // 'Kami tidak bertanggung jawab atas kehilangan data, keterlambatan akses, atau kerusakan perangkat '
// // 'yang diakibatkan oleh kegagalan sistem, perangkat lunak, atau koneksi internet Anda.\n'
// // '6.2 Konten Pihak Ketiga\n'
// // 'Aplikasi ini mungkin menyertakan tautan ke konten pihak ketiga atau layanan eksternal (misalnya, API pembayaran). '
// // 'Kami tidak bertanggung jawab atas kualitas atau keamanan layanan yang disediakan oleh pihak ketiga tersebut.\n'
// // '6.3 Keakuratan Konten\n'
// // 'Kami berusaha menyediakan konten Islami yang akurat, tetapi Kami tidak memberikan jaminan atau pernyataan '
// // 'bahwa semua konten sepenuhnya bebas dari kesalahan atau sesuai dengan interpretasi individu Anda.\n\n'
// // '7. Penghentian Layanan\n'
// // '7.1 Hak Kami\n'
// // 'Kami berhak menangguhkan atau menghentikan akses Anda ke Aplikasi jika Anda melanggar Ketentuan ini, tanpa pemberitahuan sebelumnya.\n'
// // '7.2 Keputusan Final\n'
// // 'Semall keputusan terkait penghentian akses bersifat final dan tidak dapat diganggu gugat.\n\n'
// // '8. Perubahan Ketentuan\n'
// // 'Kami dapat memperbarui Ketentuan ini sewaktu-waktu. Jika ada perubahan signifikan, Kami akan memberi tahu Anda '
// // 'melalui Aplikasi atau email terdaftar Anda. Dengan terus menggunakan Aplikasi setelah perubahan diberlakukan, '
// // 'You menyetujui Ketentuan yang diperbarui.\n\n'
// // '9. Kontak Kami\n'
// // 'Jika Anda memiliki pertanyaan, saran, atau keluhan terkait Aplikasi atau Ketentuan ini, silakan hubungi Kami melalui:\n'
// // 'Email: 3linnsari@gmail.com\n\n'
// // 'KEBIJAKAN PRIVASI\n'
// // 'Aplikasi Mobile Motivasi Penyejuk Hati dari Al-Qur’an\n'
// // 'Versi Terakhir: 6 Desember 2024\n'
// // 'Kami, [Eli Nur Nirmala Sari] ("Kami"), menghargai privasi Anda dan berkomitmen untuk melindungi data pribadi yang Anda berikan saat menggunakan aplikasi mobile Motivasi Penyejuk Hati dari Al-Quran'
// // 'an ("Aplikasi"). Kebijakan Privasi ini menjelaskan bagaimana Kami mengumpulkan, menggunakan, menyimpan, dan melindungi informasi pribadi Anda.\n'
// // 'Dengan menggunakan Aplikasi, Anda menyetujui pengumpulan dan penggunaan informasi sebagaimana diatur dalam Kebijakan Privasi ini. Jika Anda tidak setuju, mohon untuk tidak menggunakan Aplikasi ini.\n\n'
// // '1. Informasi yang Kami Kumpulkan\n'
// // 'Kami mengumpulkan informasi berikut dari pengguna:\n'
// // '1.1 Informasi Pribadi\n'
// // 'Nama lengkap.\n'
// // 'Alamat email.\n'
// // 'Nomor telepon\n'
// // 'Domisili\n'
// // 'Usia.\n'
// // 'Informasi pembayaran (hanya digunakan saat Anda melakukan pembelian).\n'
// // '1.2 Informasi Teknis\n'
// // 'Alamat IP.\n'
// // 'Jenis perangkat dan sistem operasi.\n'
// // 'Log aktivitas di Aplikasi (misalnya, halaman yang diakses, waktu penggunaan).\n'
// // '1.3 Informasi Pihak Ketiga\n'
// // 'Jika Anda mendaftar atau login menggunakan akun media sosial (jika tersedia), Kami dapat mengakses informasi dasar dari akun tersebut, seperti nama dan alamat email.\n\n'
// // '2. Cara Kami Menggunakan Informasi Anda\n'
// // 'Kami menggunakan data yang dikumpulkan untuk:\n'
// // '2.1 Memberikan Layanan\n'
// // 'Memproses registrasi akun dan login.\n'
// // 'Mengelola transaksi pembelian konten premium melalui integrasi dengan API Xendit.\n'
// // 'Menyediakan akses ke e-book Islami dan artikel yang relevan.\n'
// // '2.2 Meningkatkan Pengalaman Pengguna\n'
// // 'Meningkatkan performa Aplikasi berdasarkan data teknis.\n'
// // 'Menyediakan rekomendasi e-book yang sesuai dengan preferensi Anda.\n'
// // '2.3 Keamanan\n'
// // 'Mendeteksi dan mencegah aktivitas mencurigakan, seperti akses tidak sah atau penyalahgunaan fitur.\n'
// // 'Memastikan perlindungan konten dengan watermark otomatis.\n'
// // '2.4 Komunikasi\n'
// // 'Mengirimkan pemberitahuan terkait akun, pembaruan Aplikasi, dan penawaran khusus melalui email atau push notification (jika Anda mengizinkan).\n\n'
// // '3. Bagaimana Kami Melindungi Data Anda\n'
// // 'Kami menerapkan langkah-langkah berikut untuk menjaga keamanan data Anda:\n'
// // '3.1 Enkripsi\n'
// // 'Semall data pribadi dan informasi pembayaran dienkripsi menggunakan protokol keamanan (seperti HTTPS dan SSL) untuk mencegah akses tidak sah selama transmisi.\n'
// // '3.2 Pembatasan Akses\n'
// // 'Hanya karyawan yang berwenang yang dapat mengakses data pribadi Anda.\n'
// // '3.3 Audit Keamanan\n'
// // 'Kami secara rutin memeriksa sistem Kami untuk memastikan tidak ada kerentanan atau ancaman keamanan.\n\n'
// // '4. Pembagian Informasi\n'
// // 'Kami tidak akan menjual, menyewakan, atau membagikan data pribadi Anda kepada pihak ketiga, kecuali dalam situasi berikut:\n'
// // '4.1 Layanan Pihak Ketiga\n'
// // 'Penyedia Layanan Pembayaran: Data terkait transaksi akan dibagikan dengan Xendit untuk memproses pembayaran.\n'
// // 'Penyedia Hosting: Data Anda disimpan di server yang disediakan oleh penyedia hosting terpercaya.\n'
// // '4.2 Persyaratan Hukum\n'
// // 'Kami dapat membagikan data Anda jika diwajibkan oleh hukum atau untuk memenuhi permintaan yang sah dari pihak berwenang (misalnya, polisi atau pengadilan).\n'
// // '4.3 Perlindungan Hak\n'
// // 'Jika diperlukan untuk melindungi hak, properti, atau keselamatan Kami, pengguna lain, atau masyarakat umum.\n\n'
// // '5. Cookie dan Teknologi Serupa\n'
// // 'Kami menggunakan cookie dan teknologi serupa untuk meningkatkan pengalaman Anda saat menggunakan Aplikasi. Cookie digunakan untuk:\n'
// // 'Menyimpan preferensi pengguna.\n'
// // 'Menganalisis penggunaan Aplikasi untuk meningkatkan layanan.\n'
// // 'Anda dapat menonaktifkan cookie melalui pengaturan perangkat Anda, tetapi ini mungkin memengaruhi fungsi tertentu dalam Aplikasi.\n\n'
// // '6. Hak Anda\n'
// // 'You memiliki hak berikut terkait data pribadi Anda:\n'
// // '6.1 Akses Data\n'
// // 'Anda dapat meminta salinan informasi pribadi yang telah Kami kumpulkan.\n'
// // '6.2 Perbaikan Data\n'
// // 'Anda dapat meminta Kami untuk memperbarui atau memperbaiki informasi pribadi yang tidak akurat.\n'
// // '6.3 Penghapusan Data\n'
// // 'Anda dapat meminta penghapusan akun dan data pribadi Anda, kecuali jika data tersebut diperlukan untuk memenuhi kewajiban hukum Kami.\n'
// // '6.4 Menolak Komunikasi\n'
// // 'Anda dapat memilih untuk berhenti menerima email promosi atau push notification kapan saja melalui pengaturan akun Anda.\n\n'
// // '7. Penyimpanan Data\n'
// // 'Kami hanya menyimpan data pribadi Anda selama diperlukan untuk tujuan yang telah dijelaskan dalam Kebijakan Privasi ini, atau untuk memenuhi kewajiban hukum Kami.\n'
// // 'Jika Anda menghapus akun, data Anda akan dihapus dari server Kami dalam waktu 30 hari, kecuali data tertentu yang harus disimpan untuk keperluan hukum atau akuntansi.\n\n'
// // '8. Perubahan Kebijakan Privasi\n'
// // 'Kami dapat memperbarui Kebijakan Privasi ini dari waktu ke waktu. Jika ada perubahan material, Kami akan memberi tahu Anda melalui Aplikasi atau email terdaftar Anda sebelum perubahan diberlakukan.\n'
// // 'Tanggal revisi terakhir akan ditampilkan di bagian atas dokumen ini.\n\n'
// // '9. Anak-Anak\n'
// // 'Aplikasi ini tidak ditujukan untuk anak-anak di bawah usia 13 tahun. Kami tidak secara sengaja mengumpulkan informasi pribadi dari anak-anak tanpa persetujuan orang tua atau wali mereka. Jika Anda mengetahui bahwa seorang anak telah memberikan data pribadinya tanpa persetujuan, silakan hubungi Kami untuk penghapusan.\n\n'
// // '10. Kontak Kami\n'
// // 'Jika Anda memiliki pertanyaan, saran, atau keluhan terkait Kebijakan Privasi ini, silakan hubungi Kami melalui:\n'
// // 'Email: 3linnsari@gmail.com',
// // style: GoogleFonts.poppins(fontSize: 14),
// //                 ),
// //               ],
// //             ),
// //           ),
// //           actions: [
// //             TextButton(
// //               onPressed: () {
// //                 Navigator.of(context).pop(); // Menutup modal
// //               },
// //               child: Text(
// //                 'Tutup',
// //                 style: GoogleFonts.poppins(
// //                   color: Colors.blue,
// //                   fontWeight: FontWeight.bold,
// //                 ),
// //               ),
// //             ),
// //             TextButton(
// //               onPressed: () {
// //                 // Setujui syarat dan ketentuan
// //                 controller.isAgreed.value = true;
// //                 Navigator.of(context).pop();
// //               },
// //               child: Text(
// //                 'Setuju',
// //                 style: GoogleFonts.poppins(
// //                   color: Colors.green,
// //                   fontWeight: FontWeight.bold,
// //                 ),
// //               ),
// //             ),
// //           ],
// //         );
// //       },
// //     );
// //   }
//
// //   Widget _buildScrollableColumn({required List<Widget> child}) {
// //     return SingleChildScrollView(
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         mainAxisSize: MainAxisSize.min,
// //         children: child,
// //       ),
// //     );
// //   }
// // }
//
// import 'package:ebookapp/app/routes/app_pages.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';
// import 'package:ebookapp/app/modules/register/controllers/register_controller.dart';
// import 'package:ebookapp/core/constants/constant.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';
//
// class RegisterPage extends GetView<RegisterController> {
//   final PageController _pageController = PageController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: _buildAppBar(),
//       body: SafeArea(
//         child: Container(
//           decoration: BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage('assets/images/Watermark.png'),
//               fit: BoxFit.cover,
//             ),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(20),
//             child: Column(
//               children: [
//                 Expanded(
//                   child: PageView(
//                     controller: _pageController,
//                     physics: NeverScrollableScrollPhysics(),
//                     children: [
//                       _buildNameStep(),
//                       _buildEmailStep(),
//                       _buildPhoneStep(),
//                       _buildDobStep(),
//                       _buildDomisiliStep(),
//                       _buildGenderStep(),
//                       _buildJobStep(),
//                       _buildPasswordStep(),
//                     ],
//                   ),
//                 ), // Jarak antara login dan tombol navigasi
//                 _buildNavigationButton(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   // App Bar
//   PreferredSizeWidget _buildAppBar() {
//     return AppBar(
//       backgroundColor: Colors.white,
//       elevation: 0,
//       leading: IconButton(
//         icon: Icon(Icons.arrow_back, color: Colors.black),
//         onPressed: () {
//           if (_pageController.page!.round() > 0) {
//             _pageController.previousPage(
//               duration: Duration(milliseconds: 300),
//               curve: Curves.easeInOut,
//             );
//           }
//         },
//       ),
//       centerTitle: true,
//       title: SmoothPageIndicator(
//         controller: _pageController,
//         count: 8,
//         effect: WormEffect(
//           activeDotColor: colorBackground,
//           dotColor: Colors.grey,
//           dotHeight: 8,
//           dotWidth: 8,
//         ),
//       ),
//     );
//   }
//
//   // Step Name
//   Widget _buildNameStep() {
//     return _buildScrollableColumn(child: [
//       Text(
//         'Halo, Kenalan dulu yuk!',
//         style: GoogleFonts.leagueSpartan(
//           fontSize: 34,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//       Text(
//         'Siapa Nama Kamu?',
//         style: GoogleFonts.leagueSpartan(
//           fontSize: 14,
//           fontWeight: FontWeight.normal,
//         ),
//       ),
//       SizedBox(height: 20),
//       Obx(() => TextField(
//             controller: controller.nameController,
//             decoration: InputDecoration(
//               labelText: 'Nama Lengkap',
//               errorText: controller.isNameError.value
//                   ? 'Nama harus minimal 2 karakter'
//                   : null,
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(30),
//                 borderSide: BorderSide(color: Colors.grey, width: 1.5),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(30),
//                 borderSide: BorderSide(color: colorBackground, width: 2),
//               ),
//               enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(30),
//                 borderSide: BorderSide(color: Colors.grey, width: 1.5),
//               ),
//             ),
//             onChanged: (value) {
//               controller.validateName(); // Called on every change
//             },
//           )),
//       SizedBox(height: 20),
//       GestureDetector(
//         onTap: () {
//           Get.toNamed(Routes.login);
//         },
//         child: Align(
//           alignment: Alignment.center,
//           child: RichText(
//             text: TextSpan(
//               text: 'Sudah punya akun? ',
//               style: GoogleFonts.leagueSpartan(
//                 fontSize: 14,
//                 fontWeight: FontWeight.normal,
//                 color: Colors.black,
//               ),
//               children: [
//                 TextSpan(
//                   text: 'Login',
//                   style: GoogleFonts.leagueSpartan(
//                     fontSize: 14,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//       SizedBox(height: 10),
//     ]);
//   }
//
//   // Step Email
//   Widget _buildEmailStep() {
//     return _buildScrollableColumn(
//       child: [
//         Obx(
//           () => Text(
//             'Terima kasih, ${controller.firstName.value}!',
//             style: GoogleFonts.leagueSpartan(
//               fontSize: 28,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//         Text.rich(
//           TextSpan(
//             text: 'Sekarang, ',
//             style: GoogleFonts.leagueSpartan(
//               fontSize: 14,
//               fontWeight: FontWeight.normal,
//             ),
//             children: [
//               TextSpan(
//                 text: 'masukkan email kamu ya!',
//                 style: GoogleFonts.leagueSpartan(
//                   fontSize: 14,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         Text(
//           'Kami akan menggunakannya untuk informasi penting nanti.',
//           style: GoogleFonts.leagueSpartan(
//             fontSize: 14,
//             fontWeight: FontWeight.normal,
//           ),
//         ),
//         SizedBox(height: 20),
//         Obx(() => TextField(
//               controller: controller.emailController,
//               keyboardType: TextInputType.emailAddress,
//               decoration: InputDecoration(
//                 labelText: 'Email',
//                 errorText:
//                     controller.isEmailError.value ? 'Email tidak valid' : null,
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(30),
//                   borderSide: BorderSide(color: Colors.grey, width: 1.5),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(30),
//                   borderSide: BorderSide(color: colorBackground, width: 2),
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(30),
//                   borderSide: BorderSide(color: Colors.grey, width: 1.5),
//                 ),
//               ),
//               onChanged: (_) => controller.validateEmail(),
//             )),
//       ],
//     );
//   }
//
//   // Step Phone
//   Widget _buildPhoneStep() {
//     return _buildScrollableColumn(child: [
//       Text(
//         'Agar kami bisa\nlebih dekat denganmu...',
//         style: GoogleFonts.leagueSpartan(
//           fontSize: 28,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//       Text.rich(
//         TextSpan(
//           text: 'Silahkan, ',
//           style: GoogleFonts.leagueSpartan(
//             fontSize: 14,
//             fontWeight: FontWeight.normal,
//           ),
//           children: [
//             TextSpan(
//               text: 'masukkan nomor telepon',
//               style: GoogleFonts.leagueSpartan(
//                 fontSize: 14,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             TextSpan(
//               text: ' yang aktif ya!',
//               style: GoogleFonts.leagueSpartan(
//                 fontSize: 14,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ],
//         ),
//       ),
//       SizedBox(height: 20),
//       Obx(() => TextField(
//             controller: controller.phoneNumberController,
//             keyboardType: TextInputType.phone,
//             decoration: InputDecoration(
//               labelText: 'Nomor Telepon',
//               errorText: controller.isPhoneError.value
//                   ? 'Nomor telepon tidak valid'
//                   : null,
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(30),
//                 borderSide: BorderSide(color: Colors.grey, width: 1.5),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(30),
//                 borderSide: BorderSide(color: colorBackground, width: 2),
//               ),
//               enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(30),
//                 borderSide: BorderSide(color: Colors.grey, width: 1.5),
//               ),
//             ),
//             onChanged: (_) => controller.validatePhoneNumber(),
//           )),
//     ]);
//   }
//
//   // Step Date of Birth
//   Widget _buildDobStep() {
//     return _buildScrollableColumn(child: [
//       Text(
//         'Ulang tahunmu spesial!',
//         style: GoogleFonts.leagueSpartan(
//             fontSize: 28, fontWeight: FontWeight.bold),
//       ),
//       Text(
//         'Kapan hari lahirmu?',
//         style: GoogleFonts.leagueSpartan(
//             fontSize: 14, fontWeight: FontWeight.normal),
//       ),
//       SizedBox(height: 20),
//       TextField(
//         controller: controller.dobController,
//         decoration: InputDecoration(
//           labelText: 'Pilih Tanggal Lahir',
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(30),
//             borderSide: BorderSide(color: Colors.grey, width: 1.5),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(30),
//             borderSide: BorderSide(color: colorBackground, width: 2),
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(30),
//             borderSide: BorderSide(color: Colors.grey, width: 1.5),
//           ),
//         ),
//         onTap: () async {
//           DateTime? pickedDate = await showDatePicker(
//             context: Get.context!,
//             initialDate: DateTime.now(),
//             firstDate: DateTime(1900),
//             lastDate: DateTime.now(),
//           );
//           if (pickedDate != null) {
//             controller.dobController.text =
//                 DateFormat('yyyy-MM-dd').format(pickedDate);
//             controller.validateDob();
//           }
//         },
//         readOnly: true,
//       ),
//     ]);
//   }
//
//   // Step City/Domicile
//   Widget _buildDomisiliStep() {
//     return _buildScrollableColumn(child: [
//       Text(
//         'Biar kami tahu lebih\nbanyak tentangmu...',
//         style: GoogleFonts.leagueSpartan(
//             fontSize: 28, fontWeight: FontWeight.bold),
//       ),
//       Text.rich(
//         TextSpan(
//           text: 'Kamu tinggal, ',
//           style: GoogleFonts.leagueSpartan(
//             fontSize: 14,
//             fontWeight: FontWeight.normal,
//           ),
//           children: [
//             TextSpan(
//               text: 'di kota atau kabupaten mana?',
//               style: GoogleFonts.leagueSpartan(
//                 fontSize: 14,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ],
//         ),
//       ),
//       SizedBox(height: 20),
//       TextField(
//         controller: controller.domisiliController,
//         decoration: InputDecoration(
//           labelText: 'Cari Kota/Kabupaten',
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(30),
//             borderSide: BorderSide(color: Colors.grey, width: 1.5),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(30),
//             borderSide: BorderSide(color: colorBackground, width: 2),
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(30),
//             borderSide: BorderSide(color: Colors.grey, width: 1.5),
//           ),
//         ),
//         onChanged: (value) => controller.fetchCities(value),
//       ),
//       Obx(
//         () => Column(
//           children: controller.domisiliList
//               .map((city) => ListTile(
//                     title: Text(city['name']),
//                     onTap: () => controller.onCitySelected(city),
//                   ))
//               .toList(),
//         ),
//       ),
//     ]);
//   }
//
//   // Step Gender
//   Widget _buildGenderStep() {
//     return _buildScrollableColumn(child: [
//       Text(
//         'Setiap perjalanan\nitu unik...',
//         style: GoogleFonts.leagueSpartan(
//             fontSize: 28, fontWeight: FontWeight.bold),
//       ),
//       Text.rich(
//         TextSpan(
//           text: 'Boleh pilih ',
//           style: GoogleFonts.leagueSpartan(
//             fontSize: 14,
//             fontWeight: FontWeight.normal,
//           ),
//           children: [
//             TextSpan(
//               text: 'jenis kelaminmu?',
//               style: GoogleFonts.leagueSpartan(
//                 fontSize: 14,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ],
//         ),
//       ),
//       SizedBox(height: 20),
//       Obx(() => Column(
//             children: [
//               GestureDetector(
//                 onTap: () {
//                   controller.setGender('M'); // Laki-laki
//                 },
//                 child: Container(
//                   width: double.infinity,
//                   padding: EdgeInsets.all(12),
//                   margin: EdgeInsets.only(right: 10),
//                   decoration: BoxDecoration(
//                     color: controller.selectedGender.value == 'M'
//                         ? colorBackground
//                         : Colors.white,
//                     borderRadius: BorderRadius.circular(10),
//                     border: Border.all(
//                       color: controller.selectedGender.value == 'M'
//                           ? colorBackground
//                           : Colors.grey,
//                     ),
//                   ),
//                   child: Text(
//                     'Laki-laki',
//                     style: TextStyle(
//                       color: controller.selectedGender.value == 'M'
//                           ? Colors.white
//                           : Colors.black,
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 10),
//               GestureDetector(
//                 onTap: () {
//                   controller.setGender('F'); // Perempuan
//                 },
//                 child: Container(
//                   width: double.infinity,
//                   padding: EdgeInsets.all(12),
//                   margin: EdgeInsets.only(right: 10),
//                   decoration: BoxDecoration(
//                     color: controller.selectedGender.value == 'F'
//                         ? colorBackground
//                         : Colors.white,
//                     borderRadius: BorderRadius.circular(10),
//                     border: Border.all(
//                       color: controller.selectedGender.value == 'F'
//                           ? colorBackground
//                           : Colors.grey,
//                     ),
//                   ),
//                   child: Text(
//                     'Perempuan',
//                     style: TextStyle(
//                       color: controller.selectedGender.value == 'F'
//                           ? Colors.white
//                           : Colors.black,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           )),
//     ]);
//   }
//
//   // Step Job
//   Widget _buildJobStep() {
//     final Map<String, String> jobType = {
//       '0': 'Lainnya',
//       '1': 'Pelajar',
//       '2': 'Mahasiswa',
//       '3': 'Pegawai Negeri (ASN)',
//       '4': 'Pegawai Swasta/Karyawan Swasta',
//       '5': 'Profesional/Ahli',
//       '6': 'Ibu Rumah Tangga',
//       '7': 'Wiraswasta/Pengusaha',
//       '8': 'Tidak Bekerja',
//     };
//
//     return _buildScrollableColumn(
//       child: [
//         Text(
//           'Hampir selesai!',
//           style: GoogleFonts.leagueSpartan(
//               fontSize: 28, fontWeight: FontWeight.bold),
//         ),
//         Text.rich(
//           TextSpan(
//             text: 'Boleh tahu ',
//             style: GoogleFonts.leagueSpartan(
//                 fontSize: 14, fontWeight: FontWeight.normal),
//             children: [
//               TextSpan(
//                 text: 'apa pekerjaanmu saat ini?',
//                 style: GoogleFonts.leagueSpartan(
//                     fontSize: 14, fontWeight: FontWeight.bold),
//               ),
//             ],
//           ),
//         ),
//         SizedBox(height: 20),
//         Obx(() => Column(
//               children: jobType.entries.map((entry) {
//                 final key = entry.key;
//                 final title = entry.value;
//                 return GestureDetector(
//                   onTap: () {
//                     controller.selectedJobType.value = int.parse(key);
//                   },
//                   child: Container(
//                     width: double.infinity,
//                     margin: EdgeInsets.only(bottom: 10),
//                     padding: EdgeInsets.all(15),
//                     decoration: BoxDecoration(
//                       color: controller.selectedJobType.value == int.parse(key)
//                           ? colorBackground
//                           : Colors.white,
//                       borderRadius: BorderRadius.circular(20),
//                       border: Border.all(
//                         color:
//                             controller.selectedJobType.value == int.parse(key)
//                                 ? colorBackground
//                                 : Colors.black,
//                         width: 1.5,
//                       ),
//                     ),
//                     child: Text(
//                       title,
//                       style: TextStyle(
//                         color:
//                             controller.selectedJobType.value == int.parse(key)
//                                 ? Colors.white
//                                 : Colors.black,
//                       ),
//                     ),
//                   ),
//                 );
//               }).toList(),
//             )),
//         Obx(() => controller.selectedJobType.value == 0
//             ? TextField(
//                 controller: controller.customJobController,
//                 decoration: InputDecoration(
//                   labelText: 'Tuliskan Pekerjaan Lain',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(30),
//                     borderSide: BorderSide(color: Colors.grey, width: 1.5),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(30),
//                     borderSide: BorderSide(color: colorBackground, width: 2),
//                   ),
//                   enabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(30),
//                     borderSide: BorderSide(color: Colors.grey, width: 1.5),
//                   ),
//                 ),
//               )
//             : SizedBox.shrink()),
//       ],
//     );
//   }
//
//   // Step Password
//   Widget _buildPasswordStep() {
//     return _buildScrollableColumn(
//       child: [
//         Text(
//           'Atur kata sandi kamu',
//           style: GoogleFonts.leagueSpartan(
//               fontSize: 28, fontWeight: FontWeight.bold),
//         ),
//         Text(
//           'Buat kata sandi mu agar aman ya!',
//           style: GoogleFonts.leagueSpartan(
//               fontSize: 14, fontWeight: FontWeight.normal),
//         ),
//         SizedBox(height: 20),
//         Obx(
//           () => Column(
//             children: [
//               TextField(
//                 controller: controller.passwordController,
//                 obscureText: !controller.isPasswordVisible.value,
//                 decoration: InputDecoration(
//                   labelText: 'Kata Sandi',
//                   errorText: controller.isPasswordError.value
//                       ? 'Password minimal 8 karakter, huruf kapital dan angka'
//                       : null,
//                   suffixIcon: IconButton(
//                     icon: Icon(controller.isPasswordVisible.value
//                         ? Icons.visibility
//                         : Icons.visibility_off),
//                     onPressed: controller.togglePasswordVisibility,
//                   ),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(30),
//                     borderSide: BorderSide(color: Colors.grey, width: 1.5),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(30),
//                     borderSide: BorderSide(color: colorBackground, width: 2),
//                   ),
//                   enabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(30),
//                     borderSide: BorderSide(color: Colors.grey, width: 1.5),
//                   ),
//                 ),
//                 onChanged: (value) => controller.validatePassword(value),
//               ),
//               SizedBox(height: 16),
//               TextField(
//                 controller: controller.confirmPasswordController,
//                 obscureText: !controller.isConfirmPasswordVisible.value,
//                 decoration: InputDecoration(
//                   labelText: 'Konfirmasi Kata Sandi',
//                   errorText: controller.isConfirmPasswordError.value
//                       ? 'Konfirmasi password tidak cocok'
//                       : null,
//                   suffixIcon: IconButton(
//                     icon: Icon(controller.isConfirmPasswordVisible.value
//                         ? Icons.visibility
//                         : Icons.visibility_off),
//                     onPressed: controller.toggleConfirmPasswordVisibility,
//                   ),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(30),
//                     borderSide: BorderSide(color: Colors.grey, width: 1.5),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(30),
//                     borderSide: BorderSide(color: colorBackground, width: 2),
//                   ),
//                   enabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(30),
//                     borderSide: BorderSide(color: Colors.grey, width: 1.5),
//                   ),
//                 ),
//                 onChanged: (value) => controller.validateConfirmPassword(value),
//               ),
//               SizedBox(height: 16),
//
//               // CheckBox for terms and conditions
//               Obx(
//                 () => Row(
//                   children: [
//                     Checkbox(
//                       value: controller.isAgreed.value,
//                       onChanged: (value) {
//                         if (value != null) {
//                           controller.isAgreed.value = value;
//                           if (value) {
//                             _showTermsAndConditions(Get.context!);
//                           }
//                         }
//                       },
//                     ),
//                     Expanded(
//                       child: Text.rich(
//                         TextSpan(
//                           text: 'Saya telah menyetujui ',
//                           style: GoogleFonts.leagueSpartan(
//                             fontSize: 14,
//                             fontWeight: FontWeight.normal,
//                           ),
//                           children: [
//                             TextSpan(
//                               text: 'term of service',
//                               style: GoogleFonts.leagueSpartan(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             TextSpan(
//                               text: ' dan ',
//                               style: GoogleFonts.leagueSpartan(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.normal,
//                               ),
//                             ),
//                             TextSpan(
//                               text: 'Privacy Policy',
//                               style: GoogleFonts.leagueSpartan(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             TextSpan(
//                               text: ' yang berlaku.',
//                               style: GoogleFonts.leagueSpartan(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.normal,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   // Navigation Button
//   Widget _buildNavigationButton() {
//     return Obx(() => ElevatedButton(
//           onPressed: controller.isLoading.value ? null : _navigateOrRegister,
//           style: ElevatedButton.styleFrom(
//             minimumSize: Size(double.infinity, 50),
//             backgroundColor: colorBackground,
//           ),
//           child: controller.isLoading.value
//               ? CircularProgressIndicator(color: Colors.white)
//               : Text(
//                   'Lanjutkan',
//                   style: GoogleFonts.leagueSpartan(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//         ));
//   }
//
//   // Logic Navigation
//   void _navigateOrRegister() {
//     int currentPage = _pageController.page?.round() ?? 0;
//
//     // Validasi untuk memastikan bahwa setiap halaman diisi sebelum melanjutkan
//     switch (currentPage) {
//       case 0:
//         if (!controller.validateName()) return;
//         break;
//       case 1:
//         if (!controller.isEmailValid()) return;
//         break;
//       case 2:
//         if (!controller.isPhoneNumberValid()) return;
//         break;
//       case 3:
//         if (!controller.isDobValid()) return;
//         break;
//       case 4:
//         if (controller.domisiliController.text.isEmpty) return;
//         break;
//       case 5:
//         // Gender selection doesn't need validation for this demo
//         break;
//       case 6:
//         // Job selection handle
//         if (controller.selectedJobType.value < 0) return;
//         break;
//       case 7:
//         if (!controller.isPasswordValid()) return;
//         break;
//     }
//
//     // Navigasi hanya jika halaman ada
//     if (currentPage == 7) {
//       controller.register();
//     } else {
//       // Melanjutkan ke halaman berikutnya
//       _pageController.nextPage(
//         duration: Duration(milliseconds: 300),
//         curve: Curves.easeInOut,
//       );
//     }
//   }
//
//   // Method for showing terms and conditions
//   void _showTermsAndConditions(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           backgroundColor: Colors.white,
//           title: Text(
//             'SYARAT KETENTUAN PENGGUNAAN DAN KEBIJAKAN PRIVASI',
//             style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
//           ),
//           content: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Aplikasi Mobile Motivasi Penyejuk Hati dari Al-Qur’an\n'
//                   'Versi Terakhir: 6 Desember 2024\n'
//                   'Selamat datang di aplikasi mobile e-book Motivasi Penyejuk Hati dari Al-Qur’an. '
//                   'Syarat dan Ketentuan ini mengatur akses dan penggunaan Aplikasi oleh pengguna ("Anda") '
//                   'yang disediakan oleh [Eli Nur Nirmala Sari] ("Kami"). Dengan mengunduh, menginstal, '
//                   'dan menggunakan Aplikasi ini, Anda menyetujui seluruh syarat dan ketentuan yang berlaku.\n'
//                   'Jika Anda tidak setuju dengan salah satu bagian dari Ketentuan ini, harap segera berhenti menggunakan Aplikasi.\n\n'
//                   '1. Pendahuluan\n'
//                   '1.1 Deskripsi Layanan\n'
//                   'Aplikasi ini menyediakan akses ke e-book Motivasi Penyejuk Hati dari Al-Qur’an, '
//                   'termasuk artikel, konten premium, dan fitur lainnya yang dirancang untuk mendukung pengalaman membaca Anda.\n'
//                   '1.2 Penerimaan Ketentuan\n'
//                   'Dengan menggunakan Aplikasi ini, Anda menyetujui Ketentuan ini, kebijakan privasi, '
//                   'dan semua peraturan lainnya yang kami tetapkan terkait penggunaan layanan.\n\n'
//                   '2. Ketentuan Penggunaan\n'
//                   '2.1 Registrasi Akun\n'
//                   'Anda wajib membuat akun untuk menggunakan beberapa fitur Aplikasi. '
//                   'Data yang diperlukan meliputi nama lengkap, alamat email, dan password.\n'
//                   'Anda bertanggung jawab menjaga kerahasiaan akun Anda dan tidak boleh membagikannya kepada pihak ketiga.\n'
//                   '2.2 Batasan Usia\n'
//                   'Aplikasi ini hanya boleh digunakan oleh individu yang berusia minimal 13 tahun.\n'
//                   'Jika Anda berusia di bawah 18 tahun, Anda harus mendapatkan izin dari orang tua atau wali Anda.\n'
//                   '2.3 Penggunaan yang Dilarang\n'
//                   'You dilarang menggunakan Aplikasi untuk:\n'
//                   'Konten yang melanggar hukum, diskriminatif, atau berisi ujaran kebencian.\n'
//                   'Mendistribusikan ulang konten dari Aplikasi tanpa persetujuan tertulis dari Kami.\n\n'
//                   '3. Fitur Pembayaran\n'
//                   '3.1 Konten Premium dan Transaksi\n'
//                   'Beberapa e-book atau fitur dalam Aplikasi hanya dapat diakses dengan pembelian tertentu '
//                   'menggunakan layanan pembayaran yang terintegrasi (Xendit).\n'
//                   'Semall transaksi bersifat final dan tidak dapat dikembalikan, kecuali terdapat kesalahan teknis pada sistem Kami.\n'
//                   '3.2 Keamanan Pembayaran\n'
//                   'Kami bekerja sama dengan penyedia layanan pembayaran terpercaya untuk memproses transaksi Anda.\n'
//                   'You wajib memastikan informasi pembayaran yang diberikan adalah benar dan akurat.\n\n'
//                   '4. Hak Kekayaan Intelektual\n'
//                   '4.1 Hak Cipta dan Konten\n'
//                   'Semua konten di Aplikasi, termasuk e-book, artikel, desain, logo, dan fitur lainnya, '
//                   'adalam milik Kami atau pemberi lisensi Kami, dan dilindungi oleh undang-undang hak cipta.\n'
//                   'You tidak diperbolehkan menyalin, mendistribusikan, atau memodifikasi konten Aplikasi tanpa izin tertulis dari Kami.\n\n'
//                   '5. Kebijakan Keamanan\n'
//                   '5.1 Data Pengguna\n'
//                   'Kami berkomitmen untuk menjaga keamanan data pribadi Anda. Kebijakan penggunaan data sepenuhnya diatur dalam Kebijakan Privasi Kami.\n'
//                   '5.2 Tanggung Jawab Anda\n'
//                   'You bertanggung jawab atas keamanan perangkat Anda dalam menggunakan Aplikasi, '
//                   'termasuk memastikan perangkat bebas dari virus atau perangkat lunak berbahaya lainnya.\n'
//                   '5.3 Penyalahgunaan Akun\n'
//                   'Kami tidak bertanggung jawab atas akses yang tidak sah ke akun Anda yang disebabkan oleh kelalaian Anda dalam menjaga kerahasiaan data akun Anda.\n\n'
//                   '6. Batasan Tanggung Jawab\n'
//                   '6.1 Kegagalan Sistem atau Layanan\n'
//                   'Kami tidak bertanggung jawab atas kehilangan data, keterlambatan akses, atau kerusakan perangkat '
//                   'yang diakibatkan oleh kegagalan sistem, perangkat lunak, atau koneksi internet Anda.\n'
//                   '6.2 Konten Pihak Ketiga\n'
//                   'Aplikasi ini mungkin menyertakan tautan ke konten pihak ketiga atau layanan eksternal (misalnya, API pembayaran). '
//                   'Kami tidak bertanggung jawab atas kualitas atau keamanan layanan yang disediakan oleh pihak ketiga tersebut.\n'
//                   '6.3 Keakuratan Konten\n'
//                   'Kami berusaha menyediakan konten Islami yang akurat, tetapi Kami tidak memberikan jaminan atau pernyataan '
//                   'bahwa semua konten sepenuhnya bebas dari kesalahan atau sesuai dengan interpretasi individu Anda.\n\n'
//                   '7. Penghentian Layanan\n'
//                   '7.1 Hak Kami\n'
//                   'Kami berhak menangguhkan atau menghentikan akses Anda ke Aplikasi jika Anda melanggar Ketentuan ini, tanpa pemberitahuan sebelumnya.\n'
//                   '7.2 Keputusan Final\n'
//                   'Semall keputusan terkait penghentian akses bersifat final dan tidak dapat diganggu gugat.\n\n'
//                   '8. Perubahan Ketentuan\n'
//                   'Kami dapat memperbarui Ketentuan ini sewaktu-waktu. Jika ada perubahan signifikan, Kami akan memberi tahu Anda '
//                   'melalui Aplikasi atau email terdaftar Anda. Dengan terus menggunakan Aplikasi setelah perubahan diberlakukan, '
//                   'You menyetujui Ketentuan yang diperbarui.\n\n'
//                   '9. Kontak Kami\n'
//                   'Jika Anda memiliki pertanyaan, saran, atau keluhan terkait Aplikasi atau Ketentuan ini, silakan hubungi Kami melalui:\n'
//                   'Email: 3linnsari@gmail.com\n\n'
//                   'KEBIJAKAN PRIVASI\n'
//                   'Aplikasi Mobile Motivasi Penyejuk Hati dari Al-Qur’an\n'
//                   'Versi Terakhir: 6 Desember 2024\n'
//                   'Kami, [Eli Nur Nirmala Sari] ("Kami"), menghargai privasi Anda dan berkomitmen untuk melindungi data pribadi yang Anda berikan saat menggunakan aplikasi mobile Motivasi Penyejuk Hati dari Al-Qur’an'
//                   'an ("Aplikasi"). Kebijakan Privasi ini menjelaskan bagaimana Kami mengumpulkan, menggunakan, menyimpan, dan melindungi informasi pribadi Anda.\n'
//                   'Dengan menggunakan Aplikasi, Anda menyetujui pengumpulan dan penggunaan informasi sebagaimana diatur dalam Kebijakan Privasi ini. Jika Anda tidak setuju, mohon untuk tidak menggunakan Aplikasi ini.\n\n'
//                   '1. Informasi yang Kami Kumpulkan\n'
//                   'Kami mengumpulkan informasi berikut dari pengguna:\n'
//                   '1.1 Informasi Pribadi\n'
//                   'Nama lengkap.\n'
//                   'Alamat email.\n'
//                   'Nomor telepon\n'
//                   'Domisili\n'
//                   'Usia.\n'
//                   'Informasi pembayaran (hanya digunakan saat Anda melakukan pembelian).\n'
//                   '1.2 Informasi Teknis\n'
//                   'Alamat IP.\n'
//                   'Jenis perangkat dan sistem operasi.\n'
//                   'Log aktivitas di Aplikasi (misalnya, halaman yang diakses, waktu penggunaan).\n'
//                   '1.3 Informasi Pihak Ketiga\n'
//                   'Jika Anda mendaftar atau login menggunakan akun media sosial (jika tersedia), Kami dapat mengakses informasi dasar dari akun tersebut, seperti nama dan alamat email.\n\n'
//                   '2. Cara Kami Menggunakan Informasi Anda\n'
//                   'Kami menggunakan data yang dikumpulkan untuk:\n'
//                   '2.1 Memberikan Layanan\n'
//                   'Memproses registrasi akun dan login.\n'
//                   'Mengelola transaksi pembelian konten premium melalui integrasi dengan API Xendit.\n'
//                   'Menyediakan akses ke e-book Islami dan artikel yang relevan.\n'
//                   '2.2 Meningkatkan Pengalaman Pengguna\n'
//                   'Meningkatkan performa Aplikasi berdasarkan data teknis.\n'
//                   'Menyediakan rekomendasi e-book yang sesuai dengan preferensi Anda.\n'
//                   '2.3 Keamanan\n'
//                   'Mendeteksi dan mencegah aktivitas mencurigakan, seperti akses tidak sah atau penyalahgunaan fitur.\n'
//                   'Memastikan perlindungan konten dengan watermark otomatis.\n'
//                   '2.4 Komunikasi\n'
//                   'Mengirimkan pemberitahuan terkait akun, pembaruan Aplikasi, dan penawaran khusus melalui email atau push notification (jika Anda mengizinkan).\n\n'
//                   '3. Bagaimana Kami Melindungi Data Anda\n'
//                   'Kami menerapkan langkah-langkah berikut untuk menjaga keamanan data Anda:\n'
//                   '3.1 Enkripsi\n'
//                   'Semall data pribadi dan informasi pembayaran dienkripsi menggunakan protokol keamanan (seperti HTTPS dan SSL) untuk mencegah akses tidak sah selama transmisi.\n'
//                   '3.2 Pembatasan Akses\n'
//                   'Hanya karyawan yang berwenang yang dapat mengakses data pribadi Anda.\n'
//                   '3.3 Audit Keamanan\n'
//                   'Kami secara rutin memeriksa sistem Kami untuk memastikan tidak ada kerentanan atau ancaman keamanan.\n\n'
//                   '4. Pembagian Informasi\n'
//                   'Kami tidak akan menjual, menyewakan, atau membagikan data pribadi Anda kepada pihak ketiga, kecuali dalam situasi berikut:\n'
//                   '4.1 Layanan Pihak Ketiga\n'
//                   'Penyedia Layanan Pembayaran: Data terkait transaksi akan dibagikan dengan Xendit untuk memproses pembayaran.\n'
//                   'Penyedia Hosting: Data Anda disimpan di server yang disediakan oleh penyedia hosting terpercaya.\n'
//                   '4.2 Persyaratan Hukum\n'
//                   'Kami dapat membagikan data Anda jika diwajibkan oleh hukum atau untuk memenuhi permintaan yang sah dari pihak berwenang (misalnya, polisi atau pengadilan).\n'
//                   '4.3 Perlindungan Hak\n'
//                   'Jika diperlukan untuk melindungi hak, properti, atau keselamatan Kami, pengguna lain, atau masyarakat umum.\n\n'
//                   '5. Cookie dan Teknologi Serupa\n'
//                   'Kami menggunakan cookie dan teknologi serupa untuk meningkatkan pengalaman Anda saat menggunakan Aplikasi. Cookie digunakan untuk:\n'
//                   'Menyimpan preferensi pengguna.\n'
//                   'Menganalisis penggunaan Aplikasi untuk meningkatkan layanan.\n'
//                   'Anda dapat menonaktifkan cookie melalui pengaturan perangkat Anda, tetapi ini mungkin memengaruhi fungsi tertentu dalam Aplikasi.\n\n'
//                   '6. Hak Anda\n'
//                   'You memiliki hak berikut terkait data pribadi Anda:\n'
//                   '6.1 Akses Data\n'
//                   'Anda dapat meminta salinan informasi pribadi yang telah Kami kumpulkan.\n'
//                   '6.2 Perbaikan Data\n'
//                   'Anda dapat meminta Kami untuk memperbarui atau memperbaiki informasi pribadi yang tidak akurat.\n'
//                   '6.3 Penghapusan Data\n'
//                   'Anda dapat meminta penghapusan akun dan data pribadi Anda, kecuali jika data tersebut diperlukan untuk memenuhi kewajiban hukum Kami.\n'
//                   '6.4 Menolak Komunikasi\n'
//                   'Anda dapat memilih untuk berhenti menerima email promosi atau push notification kapan saja melalui pengaturan akun Anda.\n\n'
//                   '7. Penyimpanan Data\n'
//                   'Kami hanya menyimpan data pribadi Anda selama diperlukan untuk tujuan yang telah dijelaskan dalam Kebijakan Privasi ini, atau untuk memenuhi kewajiban hukum Kami.\n'
//                   'Jika Anda menghapus akun, data Anda akan dihapus dari server Kami dalam waktu 30 hari, kecuali data tertentu yang harus disimpan untuk keperluan hukum atau akuntansi.\n\n'
//                   '8. Perubahan Kebijakan Privasi\n'
//                   'Kami dapat memperbarui Kebijakan Privasi ini dari waktu ke waktu. Jika ada perubahan material, Kami akan memberi tahu Anda melalui Aplikasi atau email terdaftar Anda sebelum perubahan diberlakukan.\n'
//                   'Tanggal revisi terakhir akan ditampilkan di bagian atas dokumen ini.\n\n'
//                   '9. Anak-Anak\n'
//                   'Aplikasi ini tidak ditujukan untuk anak-anak di bawah usia 13 tahun. Kami tidak secara sengaja mengumpulkan informasi pribadi dari anak-anak tanpa persetujuan orang tua atau wali mereka. Jika Anda mengetahui bahwa seorang anak telah memberikan data pribadinya tanpa persetujuan, silakan hubungi Kami untuk penghapusan.\n\n'
//                   '10. Kontak Kami\n'
//                   'Jika Anda memiliki pertanyaan, saran, atau keluhan terkait Kebijakan Privasi ini, silakan hubungi Kami melalui:\n'
//                   'Email: 3linnsari@gmail.com',
//                   style: GoogleFonts.poppins(fontSize: 14),
//                 ),
//               ],
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop(); // Menutup modal
//               },
//               child: Text(
//                 'Tutup',
//                 style: GoogleFonts.poppins(
//                   color: Colors.blue,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             TextButton(
//               onPressed: () {
//                 // Setujui syarat dan ketentuan
//                 controller.isAgreed.value = true;
//                 Navigator.of(context).pop();
//               },
//               child: Text(
//                 'Setuju',
//                 style: GoogleFonts.poppins(
//                   color: Colors.green,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   // Function to build scrollable column
//   Widget _buildScrollableColumn({required List<Widget> child}) {
//     return SingleChildScrollView(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisSize: MainAxisSize.min,
//         children: child,
//       ),
//     );
//   }
// }


import 'package:ebookapp/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:ebookapp/app/modules/register/controllers/register_controller.dart';
import 'package:ebookapp/core/constants/constant.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class RegisterPage extends GetView<RegisterController> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/Watermark.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      _buildNameStep(),
                      _buildEmailStep(),
                      _buildPhoneStep(),
                      _buildDobStep(),
                      _buildDomisiliStep(),
                      _buildGenderStep(),
                      _buildJobStep(),
                      _buildPasswordStep(),
                    ],
                  ),
                ),
                _buildNavigationButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // App Bar
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () {
          if (_pageController.page!.round() > 0) {
            _pageController.previousPage(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          }
        },
      ),
      centerTitle: true,
      title: SmoothPageIndicator(
        controller: _pageController,
        count: 8,
        effect: WormEffect(
          activeDotColor: colorBackground,
          dotColor: Colors.grey,
          dotHeight: 8,
          dotWidth: 8,
        ),
      ),
    );
  }

  // Step Name
  Widget _buildNameStep() {
    return _buildScrollableColumn(child: [
      Text(
        'Halo, Kenalan dulu yuk!',
        style: GoogleFonts.leagueSpartan(
          fontSize: 34,
          fontWeight: FontWeight.bold,
        ),
      ),
      Text(
        'Siapa Nama Kamu?',
        style: GoogleFonts.leagueSpartan(
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),
      ),
      SizedBox(height: 20),
      Obx(() => TextField(
        controller: controller.nameController,
        decoration: InputDecoration(
          labelText: 'Nama Lengkap',
          errorText: controller.isNameError.value
              ? 'Nama harus minimal 2 karakter'
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.grey, width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: colorBackground, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.grey, width: 1.5),
          ),
        ),
        onChanged: (value) {
          controller.validateName(); // Called on every change
          // Ambil nama depan dari nama lengkap
          if (value.isNotEmpty) {
            List<String> names = value.split(' ');
            controller.firstName.value = names.first; // Ambil nama depan
          } else {
            controller.firstName.value = ''; // Reset jika kosong
          }
        },
      )),
      SizedBox(height: 20),
      GestureDetector(
        onTap: () {
          Get.toNamed(Routes.login);
        },
        child: Align(
          alignment: Alignment.center,
          child: RichText(
            text: TextSpan(
              text: 'Sudah punya akun? ',
              style: GoogleFonts.leagueSpartan(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
              children: [
                TextSpan(
                  text: 'Login',
                  style: GoogleFonts.leagueSpartan(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      SizedBox(height: 10),
    ]);
  }

  // Step Email
  Widget _buildEmailStep() {
    return _buildScrollableColumn(
      child: [
        Obx(
              () => Text(
            'Terima kasih, ${controller.firstName.value}!',
            style: GoogleFonts.leagueSpartan(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Text.rich(
          TextSpan(
            text: 'Sekarang, ',
            style: GoogleFonts.leagueSpartan(
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),
            children: [
              TextSpan(
                text: 'masukkan email kamu ya!',
                style: GoogleFonts.leagueSpartan(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Text(
          'Kami akan menggunakannya untuk informasi penting nanti.',
          style: GoogleFonts.leagueSpartan(
            fontSize: 14,
            fontWeight: FontWeight.normal,
          ),
        ),
        SizedBox(height: 20),
        Obx(() => TextField(
          controller: controller.emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: 'Email',
            errorText:
            controller.isEmailError.value ? 'Email tidak valid' : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Colors.grey, width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: colorBackground, width: 2),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Colors.grey, width: 1.5),
            ),
          ),
          onChanged: (_) => controller.validateEmail(),
        )),
      ],
    );
  }

  // Step Phone
  Widget _buildPhoneStep() {
    return _buildScrollableColumn(child: [
      Text(
        'Agar kami bisa\nlebih dekat denganmu...',
        style: GoogleFonts.leagueSpartan(
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
      ),
      Text.rich(
        TextSpan(
          text: 'Silahkan, ',
          style: GoogleFonts.leagueSpartan(
            fontSize: 14,
            fontWeight: FontWeight.normal,
          ),
          children: [
            TextSpan(
              text: 'masukkan nomor telepon',
              style: GoogleFonts.leagueSpartan(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(
              text: ' yang aktif ya!',
              style: GoogleFonts.leagueSpartan(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 20),
      Obx(() => TextField(
        controller: controller.phoneNumberController,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          labelText: 'Nomor Telepon',
          errorText: controller.isPhoneError.value
              ? 'Nomor telepon tidak valid'
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.grey, width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: colorBackground, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.grey, width: 1.5),
          ),
        ),
        onChanged: (_) => controller.validatePhoneNumber(),
      )),
    ]);
  }

  // Step Date of Birth
  Widget _buildDobStep() {
    return _buildScrollableColumn(child: [
      Text(
        'Ulang tahunmu spesial!',
        style: GoogleFonts.leagueSpartan(
            fontSize: 28, fontWeight: FontWeight.bold),
      ),
      Text(
        'Kapan hari lahirmu?',
        style: GoogleFonts.leagueSpartan(
            fontSize: 14, fontWeight: FontWeight.normal),
      ),
      SizedBox(height: 20),
      TextField(
        controller: controller.dobController,
        decoration: InputDecoration(
          labelText: 'Pilih Tanggal Lahir',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.grey, width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: colorBackground, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.grey, width: 1.5),
          ),
        ),
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: Get.context!,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
          );
          if (pickedDate != null) {
            controller.dobController.text =
                DateFormat('yyyy-MM-dd').format(pickedDate);
            controller.validateDob();
          }
        },
        readOnly: true,
      ),
    ]);
  }

  // Step City/Domicile
  Widget _buildDomisiliStep() {
    return _buildScrollableColumn(child: [
      Text(
        'Biar kami tahu lebih\nbanyak tentangmu...',
        style: GoogleFonts.leagueSpartan(
            fontSize: 28, fontWeight: FontWeight.bold),
      ),
      Text.rich(
        TextSpan(
          text: 'Kamu tinggal, ',
          style: GoogleFonts.leagueSpartan(
            fontSize: 14,
            fontWeight: FontWeight.normal,
          ),
          children: [
            TextSpan(
              text: 'di kota atau kabupaten mana?',
              style: GoogleFonts.leagueSpartan(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 20),
      TextField(
        controller: controller.domisiliController,
        decoration: InputDecoration(
          labelText: 'Cari Kota/Kabupaten',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.grey, width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: colorBackground, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.grey, width: 1.5),
          ),
        ),
        onChanged: (value) => controller.fetchCities(value),
      ),
      Obx(
            () => Column(
          children: controller.domisiliList
              .map((city) => ListTile(
            title: Text(city['name']),
            onTap: () => controller.onCitySelected(city),
          ))
              .toList(),
        ),
      ),
    ]);
  }

  // Step Gender
  Widget _buildGenderStep() {
    return _buildScrollableColumn(child: [
      Text(
        'Setiap perjalanan\nitu unik...',
        style: GoogleFonts.leagueSpartan(
            fontSize: 28, fontWeight: FontWeight.bold),
      ),
      Text.rich(
        TextSpan(
          text: 'Boleh pilih ',
          style: GoogleFonts.leagueSpartan(
            fontSize: 14,
            fontWeight: FontWeight.normal,
          ),
          children: [
            TextSpan(
              text: 'jenis kelaminmu?',
              style: GoogleFonts.leagueSpartan(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 20),
      Obx(() => Column(
        children: [
          GestureDetector(
            onTap: () {
              controller.setGender('M'); // Laki-laki
            },
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(12),
              margin: EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                color: controller.selectedGender.value == 'M'
                    ? colorBackground
                    : Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: controller.selectedGender.value == 'M'
                      ? colorBackground
                      : Colors.grey,
                ),
              ),
              child: Text(
                'Laki-laki',
                style: TextStyle(
                  color: controller.selectedGender.value == 'M'
                      ? Colors.white
                      : Colors.black,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              controller.setGender('F'); // Perempuan
            },
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(12),
              margin: EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                color: controller.selectedGender.value == 'F'
                    ? colorBackground
                    : Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: controller.selectedGender.value == 'F'
                      ? colorBackground
                      : Colors.grey,
                ),
              ),
              child: Text(
                'Perempuan',
                style: TextStyle(
                  color: controller.selectedGender.value == 'F'
                      ? Colors.white
                      : Colors.black,
                ),
              ),
            ),
          ),
        ],
      )),
    ]);
  }

  // Step Job
  Widget _buildJobStep() {
    final Map<String, String> jobType = {
      '0': 'Lainnya',
      '1': 'Pelajar',
      '2': 'Mahasiswa',
      '3': 'Pegawai Negeri (ASN)',
      '4': 'Pegawai Swasta/Karyawan Swasta',
      '5': 'Profesional/Ahli',
      '6': 'Ibu Rumah Tangga',
      '7': 'Wiraswasta/Pengusaha',
      '8': 'Tidak Bekerja',
    };

    return _buildScrollableColumn(
      child: [
        Text(
          'Hampir selesai!',
          style: GoogleFonts.leagueSpartan(
              fontSize: 28, fontWeight: FontWeight.bold),
        ),
        Text.rich(
          TextSpan(
            text: 'Boleh tahu ',
            style: GoogleFonts.leagueSpartan(
                fontSize: 14, fontWeight: FontWeight.normal),
            children: [
              TextSpan(
                text: 'apa pekerjaanmu saat ini?',
                style: GoogleFonts.leagueSpartan(
                    fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        Obx(() => Column(
          children: jobType.entries.map((entry) {
            final key = entry.key;
            final title = entry.value;
            return GestureDetector(
              onTap: () {
                controller.selectedJobType.value = int.parse(key);
              },
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.only(bottom: 10),
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: controller.selectedJobType.value == int.parse(key)
                      ? colorBackground
                      : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color:
                    controller.selectedJobType.value == int.parse(key)
                        ? colorBackground
                        : Colors.black,
                    width: 1.5,
                  ),
                ),
                child: Text(
                  title,
                  style: TextStyle(
                    color:
                    controller.selectedJobType.value == int.parse(key)
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ),
            );
          }).toList(),
        )),
        Obx(() => controller.selectedJobType.value == 0
            ? TextField(
          controller: controller.customJobController,
          decoration: InputDecoration(
            labelText: 'Tuliskan Pekerjaan Lain',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Colors.grey, width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: colorBackground, width: 2),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Colors.grey, width: 1.5),
            ),
          ),
        )
            : SizedBox.shrink()),
      ],
    );
  }

  // Step Password
  Widget _buildPasswordStep() {
    return _buildScrollableColumn(
      child: [
      Text(
      'Atur kata sandi kamu',
      style: GoogleFonts.leagueSpartan(
          fontSize: 28, fontWeight: FontWeight.bold),
    ),
    Text(
    'Buat kata sandi mu agar aman ya!',
    style: GoogleFonts.leagueSpartan(
    fontSize: 14, fontWeight: FontWeight.normal),
    ),
    SizedBox(height: 20),
    Obx(
    () => Column(
    children: [
    TextField(
    controller: controller.passwordController,
    obscureText: !controller.isPasswordVisible.value,
    decoration: InputDecoration(
    labelText: 'Kata Sandi',
    errorText: controller.isPasswordError.value
    ? 'Password minimal 8 karakter, huruf kapital dan angka'
        : null,
    suffixIcon: IconButton(
    icon: Icon(controller.isPasswordVisible.value
    ? Icons.visibility
        : Icons.visibility_off),
    onPressed: controller.togglePasswordVisibility,
    ),
    border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(30),
    borderSide: BorderSide(color: Colors.grey, width: 1.5),
    ),
    focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(30),
    borderSide: BorderSide(color: colorBackground, width: 2),
    ),
    enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(30),
    borderSide: BorderSide(color: Colors.grey, width: 1.5),
    ),
    ),
    onChanged: (value) => controller.validatePassword(value),
    ),
    SizedBox(height: 16),
    TextField(
    controller: controller.confirmPasswordController,
    obscureText: !controller.isConfirmPasswordVisible.value,
    decoration: InputDecoration(
    labelText: 'Konfirmasi Kata Sandi',
    errorText: controller.isConfirmPasswordError.value
    ? 'Konfirmasi password tidak cocok'
        : null,
    suffixIcon: IconButton(
    icon: Icon(controller.isConfirmPasswordVisible.value
    ? Icons.visibility
        : Icons.visibility_off),
    onPressed: controller.toggleConfirmPasswordVisibility,
    ),
    border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(30),
    borderSide: BorderSide(color: Colors.grey, width: 1.5),
    ),
    focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(30),
    borderSide: BorderSide(color: colorBackground, width: 2),
    ),
    enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(30),
    borderSide: BorderSide(color: Colors.grey, width: 1.5),
    ),
    ),
    onChanged: (value) => controller.validateConfirmPassword(value),
    ),
    SizedBox(height: 16),

      // CheckBox for terms and conditions
      Obx(
            () => Row(
          children: [
            Checkbox(
              value: controller.isAgreed.value,
              onChanged: (value) {
                if (value != null) {
                  controller.isAgreed.value = value;
                  if (value) {
                    _showTermsAndConditions(Get.context!);
                  }
                }
              },
            ),
            Expanded(
              child: Text.rich(
                TextSpan(
                  text: 'Saya telah menyetujui ',
                  style: GoogleFonts.leagueSpartan(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                  children: [
                    TextSpan(
                      text: 'term of service',
                      style: GoogleFonts.leagueSpartan(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: ' dan ',
                      style: GoogleFonts.leagueSpartan(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    TextSpan(
                      text: 'Privacy Policy',
                      style: GoogleFonts.leagueSpartan(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: ' yang berlaku.',
                      style: GoogleFonts.leagueSpartan(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ],
    ),
    ),
      ],
    );
  }

  // Navigation Button
  Widget _buildNavigationButton() {
    return Obx(() => ElevatedButton(
      onPressed: controller.isLoading.value ? null : _navigateOrRegister,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, 50),
        backgroundColor: colorBackground,
      ),
      child: controller.isLoading.value
          ? CircularProgressIndicator(color: Colors.white)
          : Text(
        'Lanjutkan',
        style: GoogleFonts.leagueSpartan(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    ));
  }

  // Logic Navigation
  void _navigateOrRegister() {
    int currentPage = _pageController.page?.round() ?? 0;

    // Validasi untuk memastikan bahwa setiap halaman diisi sebelum melanjutkan
    switch (currentPage) {
      case 0:
        if (!controller.validateName()) return;
        break;
      case 1:
        if (!controller.isEmailValid()) return;
        break;
      case 2:
        if (!controller.isPhoneNumberValid()) return;
        break;
      case 3:
        if (!controller.isDobValid()) return;
        break;
      case 4:
        if (controller.domisiliController.text.isEmpty) return;
        break;
      case 5:
      // Gender selection doesn't need validation for this demo
        break;
      case 6:
      // Job selection handle
        if (controller.selectedJobType.value < 0) return;
        break;
      case 7:
        if (!controller.isPasswordValid()) return;
        break;
    }

    // Navigasi hanya jika halaman ada
    if (currentPage == 7) {
      controller.register();
    } else {
      // Melanjutkan ke halaman berikutnya
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _showTermsAndConditions(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            'SYARAT KETENTUAN PENGGUNAAN DAN KEBIJAKAN PRIVASI',
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Aplikasi Mobile Motivasi Penyejuk Hati dari Al-Qur’an\n'
                  'Versi Terakhir: 6 Desember 2024\n'
                  'Selamat datang di aplikasi mobile e-book Motivasi Penyejuk Hati dari Al-Qur’an. '
                  'Syarat dan Ketentuan ini mengatur akses dan penggunaan Aplikasi oleh pengguna ("Anda") '
                  'yang disediakan oleh [Eli Nur Nirmala Sari] ("Kami"). Dengan mengunduh, menginstal, '
                  'dan menggunakan Aplikasi ini, Anda menyetujui seluruh syarat dan ketentuan yang berlaku.\n'
                  'Jika Anda tidak setuju dengan salah satu bagian dari Ketentuan ini, harap segera berhenti menggunakan Aplikasi.\n\n'
                  '1. Pendahuluan\n'
                  '1.1 Deskripsi Layanan\n'
                  'Aplikasi ini menyediakan akses ke e-book Motivasi Penyejuk Hati dari Al-Qur’an, '
                  'termasuk artikel, konten premium, dan fitur lainnya yang dirancang untuk mendukung pengalaman membaca Anda.\n'
                  '1.2 Penerimaan Ketentuan\n'
                  'Dengan menggunakan Aplikasi ini, Anda menyetujui Ketentuan ini, kebijakan privasi, '
                  'dan semua peraturan lainnya yang kami tetapkan terkait penggunaan layanan.\n\n'
                  '2. Ketentuan Penggunaan\n'
                  '2.1 Registrasi Akun\n'
                  'Anda wajib membuat akun untuk menggunakan beberapa fitur Aplikasi. '
                  'Data yang diperlukan meliputi nama lengkap, alamat email, dan password.\n'
                  'Anda bertanggung jawab menjaga kerahasiaan akun Anda dan tidak boleh membagikannya kepada pihak ketiga.\n'
                  '2.2 Batasan Usia\n'
                  'Aplikasi ini hanya boleh digunakan oleh individu yang berusia minimal 13 tahun.\n'
                  'Jika Anda berusia di bawah 18 tahun, Anda harus mendapatkan izin dari orang tua atau wali Anda.\n'
                  '2.3 Penggunaan yang Dilarang\n'
                  'You dilarang menggunakan Aplikasi untuk:\n'
                  'Konten yang melanggar hukum, diskriminatif, atau berisi ujaran kebencian.\n'
                  'Mendistribusikan ulang konten dari Aplikasi tanpa persetujuan tertulis dari Kami.\n\n'
                  '3. Fitur Pembayaran\n'
                  '3.1 Konten Premium dan Transaksi\n'
                  'Beberapa e-book atau fitur dalam Aplikasi hanya dapat diakses dengan pembelian tertentu '
                  'menggunakan layanan pembayaran yang terintegrasi (Xendit).\n'
                  'Semall transaksi bersifat final dan tidak dapat dikembalikan, kecuali terdapat kesalahan teknis pada sistem Kami.\n'
                  '3.2 Keamanan Pembayaran\n'
                  'Kami bekerja sama dengan penyedia layanan pembayaran terpercaya untuk memproses transaksi Anda.\n'
                  'You wajib memastikan informasi pembayaran yang diberikan adalah benar dan akurat.\n\n'
                  '4. Hak Kekayaan Intelektual\n'
                  '4.1 Hak Cipta dan Konten\n'
                  'Semua konten di Aplikasi, termasuk e-book, artikel, desain, logo, dan fitur lainnya, '
                  'adalam milik Kami atau pemberi lisensi Kami, dan dilindungi oleh undang-undang hak cipta.\n'
                  'You tidak diperbolehkan menyalin, mendistribusikan, atau memodifikasi konten Aplikasi tanpa izin tertulis dari Kami.\n\n'
                  '5. Kebijakan Keamanan\n'
                  '5.1 Data Pengguna\n'
                  'Kami berkomitmen untuk menjaga keamanan data pribadi Anda. Kebijakan penggunaan data sepenuhnya diatur dalam Kebijakan Privasi Kami.\n'
                  '5.2 Tanggung Jawab Anda\n'
                  'You bertanggung jawab atas keamanan perangkat Anda dalam menggunakan Aplikasi, '
                  'termasuk memastikan perangkat bebas dari virus atau perangkat lunak berbahaya lainnya.\n'
                  '5.3 Penyalahgunaan Akun\n'
                  'Kami tidak bertanggung jawab atas akses yang tidak sah ke akun Anda yang disebabkan oleh kelalaian Anda dalam menjaga kerahasiaan data akun Anda.\n\n'
                  '6. Batasan Tanggung Jawab\n'
                  '6.1 Kegagalan Sistem atau Layanan\n'
                  'Kami tidak bertanggung jawab atas kehilangan data, keterlambatan akses, atau kerusakan perangkat '
                  'yang diakibatkan oleh kegagalan sistem, perangkat lunak, atau koneksi internet Anda.\n'
                  '6.2 Konten Pihak Ketiga\n'
                  'Aplikasi ini mungkin menyertakan tautan ke konten pihak ketiga atau layanan eksternal (misalnya, API pembayaran). '
                  'Kami tidak bertanggung jawab atas kualitas atau keamanan layanan yang disediakan oleh pihak ketiga tersebut.\n'
                  '6.3 Keakuratan Konten\n'
                  'Kami berusaha menyediakan konten Islami yang akurat, tetapi Kami tidak memberikan jaminan atau pernyataan '
                  'bahwa semua konten sepenuhnya bebas dari kesalahan atau sesuai dengan interpretasi individu Anda.\n\n'
                  '7. Penghentian Layanan\n'
                  '7.1 Hak Kami\n'
                  'Kami berhak menangguhkan atau menghentikan akses Anda ke Aplikasi jika Anda melanggar Ketentuan ini, tanpa pemberitahuan sebelumnya.\n'
                  '7.2 Keputusan Final\n'
                  'Semall keputusan terkait penghentian akses bersifat final dan tidak dapat diganggu gugat.\n\n'
                  '8. Perubahan Ketentuan\n'
                  'Kami dapat memperbarui Ketentuan ini sewaktu-waktu. Jika ada perubahan signifikan, Kami akan memberi tahu Anda '
                  'melalui Aplikasi atau email terdaftar Anda. Dengan terus menggunakan Aplikasi setelah perubahan diberlakukan, '
                  'You menyetujui Ketentuan yang diperbarui.\n\n'
                  '9. Kontak Kami\n'
                  'Jika Anda memiliki pertanyaan, saran, atau keluhan terkait Aplikasi atau Ketentuan ini, silakan hubungi Kami melalui:\n'
                  'Email: 3linnsari@gmail.com\n\n'
                  'KEBIJAKAN PRIVASI\n'
                  'Aplikasi Mobile Motivasi Penyejuk Hati dari Al-Qur’an\n'
                  'Versi Terakhir: 6 Desember 2024\n'
                  'Kami, [Eli Nur Nirmala Sari] ("Kami"), menghargai privasi Anda dan berkomitmen untuk melindungi data pribadi yang Anda berikan saat menggunakan aplikasi mobile Motivasi Penyejuk Hati dari Al-Qur’an'
                  'an ("Aplikasi"). Kebijakan Privasi ini menjelaskan bagaimana Kami mengumpulkan, menggunakan, menyimpan, dan melindungi informasi pribadi Anda.\n'
                  'Dengan menggunakan Aplikasi, Anda menyetujui pengumpulan dan penggunaan informasi sebagaimana diatur dalam Kebijakan Privasi ini. Jika Anda tidak setuju, mohon untuk tidak menggunakan Aplikasi ini.\n\n'
                  '1. Informasi yang Kami Kumpulkan\n'
                  'Kami mengumpulkan informasi berikut dari pengguna:\n'
                  '1.1 Informasi Pribadi\n'
                  'Nama lengkap.\n'
                  'Alamat email.\n'
                  'Nomor telepon\n'
                  'Domisili\n'
                  'Usia.\n'
                  'Informasi pembayaran (hanya digunakan saat Anda melakukan pembelian).\n'
                  '1.2 Informasi Teknis\n'
                  'Alamat IP.\n'
                  'Jenis perangkat dan sistem operasi.\n'
                  'Log aktivitas di Aplikasi (misalnya, halaman yang diakses, waktu penggunaan).\n'
                  '1.3 Informasi Pihak Ketiga\n'
                  'Jika Anda mendaftar atau login menggunakan akun media sosial (jika tersedia), Kami dapat mengakses informasi dasar dari akun tersebut, seperti nama dan alamat email.\n\n'
                  '2. Cara Kami Menggunakan Informasi Anda\n'
                  'Kami menggunakan data yang dikumpulkan untuk:\n'
                  '2.1 Memberikan Layanan\n'
                  'Memproses registrasi akun dan login.\n'
                  'Mengelola transaksi pembelian konten premium melalui integrasi dengan API Xendit.\n'
                  'Menyediakan akses ke e-book Islami dan artikel yang relevan.\n'
                  '2.2 Meningkatkan Pengalaman Pengguna\n'
                  'Meningkatkan performa Aplikasi berdasarkan data teknis.\n'
                  'Menyediakan rekomendasi e-book yang sesuai dengan preferensi Anda.\n'
                  '2.3 Keamanan\n'
                  'Mendeteksi dan mencegah aktivitas mencurigakan, seperti akses tidak sah atau penyalahgunaan fitur.\n'
                  'Memastikan perlindungan konten dengan watermark otomatis.\n'
                  '2.4 Komunikasi\n'
                  'Mengirimkan pemberitahuan terkait akun, pembaruan Aplikasi, dan penawaran khusus melalui email atau push notification (jika Anda mengizinkan).\n\n'
                  '3. Bagaimana Kami Melindungi Data Anda\n'
                  'Kami menerapkan langkah-langkah berikut untuk menjaga keamanan data Anda:\n'
                  '3.1 Enkripsi\n'
                  'Semall data pribadi dan informasi pembayaran dienkripsi menggunakan protokol keamanan (seperti HTTPS dan SSL) untuk mencegah akses tidak sah selama transmisi.\n'
                  '3.2 Pembatasan Akses\n'
                  'Hanya karyawan yang berwenang yang dapat mengakses data pribadi Anda.\n'
                  '3.3 Audit Keamanan\n'
                  'Kami secara rutin memeriksa sistem Kami untuk memastikan tidak ada kerentanan atau ancaman keamanan.\n\n'
                  '4. Pembagian Informasi\n'
                  'Kami tidak akan menjual, menyewakan, atau membagikan data pribadi Anda kepada pihak ketiga, kecuali dalam situasi berikut:\n'
                  '4.1 Layanan Pihak Ketiga\n'
                  'Penyedia Layanan Pembayaran: Data terkait transaksi akan dibagikan dengan Xendit untuk memproses pembayaran.\n'
                  'Penyedia Hosting: Data Anda disimpan di server yang disediakan oleh penyedia hosting terpercaya.\n'
                  '4.2 Persyaratan Hukum\n'
                  'Kami dapat membagikan data Anda jika diwajibkan oleh hukum atau untuk memenuhi permintaan yang sah dari pihak berwenang (misalnya, polisi atau pengadilan).\n'
                  '4.3 Perlindungan Hak\n'
                  'Jika diperlukan untuk melindungi hak, properti, atau keselamatan Kami, pengguna lain, atau masyarakat umum.\n\n'
                  '5. Cookie dan Teknologi Serupa\n'
                  'Kami menggunakan cookie dan teknologi serupa untuk meningkatkan pengalaman Anda saat menggunakan Aplikasi. Cookie digunakan untuk:\n'
                  'Menyimpan preferensi pengguna.\n'
                  'Menganalisis penggunaan Aplikasi untuk meningkatkan layanan.\n'
                  'Anda dapat menonaktifkan cookie melalui pengaturan perangkat Anda, tetapi ini mungkin memengaruhi fungsi tertentu dalam Aplikasi.\n\n'
                  '6. Hak Anda\n'
                  'You memiliki hak berikut terkait data pribadi Anda:\n'
                  '6.1 Akses Data\n'
                  'Anda dapat meminta salinan informasi pribadi yang telah Kami kumpulkan.\n'
                  '6.2 Perbaikan Data\n'
                  'Anda dapat meminta Kami untuk memperbarui atau memperbaiki informasi pribadi yang tidak akurat.\n'
                  '6.3 Penghapusan Data\n'
                  'Anda dapat meminta penghapusan akun dan data pribadi Anda, kecuali jika data tersebut diperlukan untuk memenuhi kewajiban hukum Kami.\n'
                  '6.4 Menolak Komunikasi\n'
                  'Anda dapat memilih untuk berhenti menerima email promosi atau push notification kapan saja melalui pengaturan akun Anda.\n\n'
                  '7. Penyimpanan Data\n'
                  'Kami hanya menyimpan data pribadi Anda selama diperlukan untuk tujuan yang telah dijelaskan dalam Kebijakan Privasi ini, atau untuk memenuhi kewajiban hukum Kami.\n'
                  'Jika Anda menghapus akun, data Anda akan dihapus dari server Kami dalam waktu 30 hari, kecuali data tertentu yang harus disimpan untuk keperluan hukum atau akuntansi.\n\n'
                  '8. Perubahan Kebijakan Privasi\n'
                  'Kami dapat memperbarui Kebijakan Privasi ini dari waktu ke waktu. Jika ada perubahan material, Kami akan memberi tahu Anda melalui Aplikasi atau email terdaftar Anda sebelum perubahan diberlakukan.\n'
                  'Tanggal revisi terakhir akan ditampilkan di bagian atas dokumen ini.\n\n'
                  '9. Anak-Anak\n'
                  'Aplikasi ini tidak ditujukan untuk anak-anak di bawah usia 13 tahun. Kami tidak secara sengaja mengumpulkan informasi pribadi dari anak-anak tanpa persetujuan orang tua atau wali mereka. Jika Anda mengetahui bahwa seorang anak telah memberikan data pribadinya tanpa persetujuan, silakan hubungi Kami untuk penghapusan.\n\n'
                  '10. Kontak Kami\n'
                  'Jika Anda memiliki pertanyaan, saran, atau keluhan terkait Kebijakan Privasi ini, silakan hubungi Kami melalui:\n'
                  'Email: 3linnsari@gmail.com',
                  style: GoogleFonts.poppins(fontSize: 14),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Menutup modal
              },
              child: Text(
                'Tutup',
                style: GoogleFonts.poppins(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                // Setujui syarat dan ketentuan
                controller.isAgreed.value = true;
                Navigator.of(context).pop();
              },
              child: Text(
                'Setuju',
                style: GoogleFonts.poppins(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // Function to build scrollable column
  Widget _buildScrollableColumn({required List<Widget> child}) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: child,
      ),
    );
  }
}