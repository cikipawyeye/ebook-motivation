// import 'package:ebookapp/app/modules/register/controllers/register_controller.dart';
// import 'package:ebookapp/app/routes/app_pages.dart';
// import 'package:ebookapp/core/constants/constant.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';

// class SetPasswordView extends GetView<RegisterController> {
//   const SetPasswordView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final _formKey = GlobalKey<FormState>();

//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Container(
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage('assets/images/Watermark.png'),
//             fit: BoxFit.cover,
//           ),
//         ),
//         child: Center(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   const SizedBox(height: 80),
//                   Text(
//                     'Atur kata sandi',
//                     style: GoogleFonts.leagueSpartan(
//                       fontSize: 28,
//                       fontWeight: FontWeight.bold,
//                     ),
//                     textAlign: TextAlign.start,
//                   ),
//                   Text(
//                     'Data yang di isi hanya dapat dilihat oleh kamu\ndan tim support kami.',
//                     style: GoogleFonts.leagueSpartan(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w500,
//                     ),
//                     textAlign: TextAlign.start,
//                   ),
//                   const SizedBox(height: 20),
//                   // Kata Sandi
//                   Obx(() => TextFormField(
//                         controller: controller.passwordController,
//                         decoration: InputDecoration(
//                           labelText: 'Kata Sandi',
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                           labelStyle: GoogleFonts.leagueSpartan(),
//                           errorText: controller.isPasswordValid.value
//                               ? null
//                               : 'Kata sandi harus minimal 8 karakter dan mengandung huruf kapital',
//                           suffixIcon: IconButton(
//                             icon: Icon(
//                               controller.isPasswordVisible.value
//                                   ? Icons.visibility
//                                   : Icons.visibility_off,
//                               color: Colors.grey,
//                             ),
//                             onPressed: () {
//                               controller.togglePasswordVisibility();
//                             },
//                           ),
//                         ),
//                         obscureText: !controller.isPasswordVisible.value,
//                         onChanged: (value) {
//                           controller.validatePassword(value);
//                         },
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Kata sandi tidak boleh kosong';
//                           }
//                           return null;
//                         },
//                       )),
//                   const SizedBox(height: 16),
//                   // Konfirmasi Kata Sandi
//                   Obx(() => TextFormField(
//                         controller: controller.confirmPasswordController,
//                         decoration: InputDecoration(
//                           labelText: 'Konfirmasi Kata Sandi',
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                           labelStyle: GoogleFonts.leagueSpartan(),
//                           errorText: controller.isConfirmPasswordValid.value
//                               ? null
//                               : 'Kata sandi tidak cocok',
//                           suffixIcon: IconButton(
//                             icon: Icon(
//                               controller.isConfirmPasswordVisible.value
//                                   ? Icons.visibility
//                                   : Icons.visibility_off,
//                               color: Colors.grey,
//                             ),
//                             onPressed: () {
//                               controller.toggleConfirmPasswordVisibility();
//                             },
//                           ),
//                         ),
//                         obscureText: !controller.isConfirmPasswordVisible.value,
//                         onChanged: (value) {
//                           controller.validateConfirmPassword(value);
//                         },
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Konfirmasi kata sandi tidak boleh kosong';
//                           }
//                           return null;
//                         },
//                       )),
//                   const SizedBox(height: 16),
//                   // Checkbox untuk setuju dengan kebijakan
//                   Row(
//                     children: [
                  //     Obx(() => Checkbox(
                  //           value: controller.isAgreed.value,
                  //           onChanged: (value) {
                  //             if (value != null) {
                  //               controller.isAgreed.value = value;
                  //               _showTermsAndConditions(context);
                  //             }
                  //           },
                  //         )),
                  //     Expanded(
                  //       child: Text(
                  //         'Menerima ketentuan dan kebijakan privasi',
                  //         style: GoogleFonts.poppins(),
                  //       ),
                  //     ),
                  //   ],
                  // ),
//                   const SizedBox(height: 300),
//                   // Tombol Buat Akun
//                   ElevatedButton(
//                     onPressed: () async {
//                       if (!controller.isPasswordValid.value) {
//                         Get.snackbar(
//                           'Gagal!',
//                           'Kata sandi harus minimal 8 karakter dan mengandung huruf kapital',
//                           snackPosition: SnackPosition.BOTTOM,
//                           backgroundColor: Colors.red,
//                           colorText: Colors.white,
//                         );
//                         return;
//                       }

//                       if (!controller.isConfirmPasswordValid.value) {
//                         Get.snackbar(
//                           'Gagal!',
//                           'Kata sandi tidak cocok',
//                           snackPosition: SnackPosition.BOTTOM,
//                           backgroundColor: Colors.red,
//                           colorText: Colors.white,
//                         );
//                         return;
//                       }

//                       if (!controller.isAgreed.value) {
//                         Get.snackbar(
//                           'Gagal!',
//                           'Anda harus menyetujui ketentuan dan kebijakan privasi',
//                           snackPosition: SnackPosition.BOTTOM,
//                           backgroundColor: Colors.red,
//                           colorText: Colors.white,
//                         );
//                         return;
//                       }

//                       if (_formKey.currentState!.validate()) {
//                         await controller.register();
//                         if (controller.errorMessage.value.isEmpty) {
//                           Get.offAllNamed(Routes.successRegis);
//                         } else {
//                           Get.snackbar('Gagal!', controller.errorMessage.value);
//                         }
//                       } else {
//                         Get.snackbar(
//                             'Gagal!', 'Harap lengkapi semua field yang wajib.');
//                       }
//                     },
//                     child: Text(
//                       'Buat akun',
//                       style: GoogleFonts.leagueSpartan(
//                           color: Colors.white, fontSize: 20),
//                     ),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Color(
//                           0xFF32497B), // Ganti dengan colorBackground jika ada
//                       minimumSize: const Size(double.infinity, 50),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

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
//                   'Email: motivasi.ph@gmail.com\n\n'
//                   'KEBIJAKAN PRIVASI\n'
//                   'Aplikasi Mobile Motivasi Penyejuk Hati dari Al-Qur’an\n'
//                   'Versi Terakhir: 6 Desember 2024\n'
//                   'Kami, [Eli Nur Nirmala Sari] ("Kami"), menghargai privasi Anda dan berkomitmen untuk melindungi data pribadi yang Anda berikan saat menggunakan aplikasi mobile Motivasi Penyejuk Hati dari Al-Quran'
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
//                   'Email: motivasi.ph@gmail.com',
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
//           ],
//         );
//       },
//     );
//   }
// }
