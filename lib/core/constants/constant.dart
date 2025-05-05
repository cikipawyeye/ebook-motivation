import 'package:flutter/material.dart';

const String imageDirectory = 'assets/images/';
const String imageURL = 'https://trustcollect.qrbdl.com/';
const String baseUrl = 'https://motivasiislami.com'; // Prod
// const String baseUrl = 'https://ebook.dev.whatthefun.id'; // Dev
const String kBase64Extend = 'data:image/jpeg;base64,';
const String kBase64ExtendVideo = 'data:video/mp4;base64,';
const String kBase64ExtendAudio = 'data:audio/mp3;base64,';

const colorPrimary = Color(0xFF00A19D);
const colorSecondary = Color(0xFFFFB344);
const colorTernary = Color(0xFFE05D5D);
const colorWhite = Colors.white;
const colorBlack = Colors.black;
const colorBackground = Color(0xFF32497B);

const colorError = Color(0xFFFF2424);
const colorSuccess = Color(0xFF2EB843);
const colorWarning = Color(0xFFF14705);
const colorInfo = Color.fromARGB(255, 243, 249, 79);

//FontWeight
const weight400 = FontWeight.w400;
const weight500 = FontWeight.w500;
const weight600 = FontWeight.w600;
const weight800 = FontWeight.w800;
const weightBold = FontWeight.bold;

//SizedBox Height
const height4 = SizedBox(height: 4);
const heigh8 = SizedBox(height: 8);
const heigh16 = SizedBox(height: 16);
const heigh20 = SizedBox(height: 20);
const heigh24 = SizedBox(height: 24);

//SizedBox Width
const width4 = SizedBox(width: 4);
const width8 = SizedBox(width: 8);
const width16 = SizedBox(width: 16);
const width20 = SizedBox(width: 20);
const width24 = SizedBox(width: 24);

// Box Shadow

BoxShadow customShadow =
    BoxShadow(blurRadius: 20, color: colorBlack.withValues(alpha: 0.2));

//Axis Alignment
const crossAxisCenter = CrossAxisAlignment.center;
const crossAxisEnd = CrossAxisAlignment.end;
const crossAxisStart = CrossAxisAlignment.start;

const mainAxisCenter = MainAxisAlignment.center;
const mainAxisStart = MainAxisAlignment.start;
const mainAxisBetween = MainAxisAlignment.spaceBetween;
const mainAxisAround = MainAxisAlignment.spaceAround;
const mainAxisEnd = MainAxisAlignment.end;

BoxDecoration containerBoxDecoration(
    {double? borderRadius, Color? color, List<BoxShadow>? boxShadow}) {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(borderRadius!),
    color: color,
    boxShadow: boxShadow,
  );
}

// Paths Assets
class AssetPaths {
  static const String audioFolder = 'assets/audio/';
  static const String videoFolder = 'assets/videos/';
  static const String pictureFolder = 'assets/pictures/';

  // Daftar Musik
  static const List<String> musicTracks = [
    'assets/audio/PenyejukHati1.mp3',
    // 'assets/audio/PenyejukHati2.mp3',
    // 'assets/audio/PenyejukHati3.mp3',
    // 'assets/audio/PenyejukHati4.mp3',
    // 'assets/audio/PenyejukHati5.mp3',
    // 'assets/audio/PenyejukHati6.mp3',
    // 'assets/audio/PenyejukHati7.mp3',
    // 'assets/audio/PenyejukHati8.mp3',
    // 'assets/audio/PenyejukHati9.mp3',
    // 'assets/audio/PenyejukHati10.mp3'
  ];

  // Daftar Wallpaper
  static const List<String> wallpapers = [
    // 'assets/videos/Wallpaper01.mp4',
    // 'assets/videos/Wallpaper02.mp4',
    // 'assets/videos/Wallpaper03.mp4',
    // 'assets/videos/Wallpaper04.mp4',
    // 'assets/videos/Wallpaper05.mp4',
    // 'assets/videos/Wallpaper06.mp4',
    // 'assets/videos/Wallpaper07.mp4',
    // 'assets/videos/Wallpaper08.mp4',
    // 'assets/videos/Wallpaper09.mp4',
    // 'assets/pictures/Wallpaper_img_01.jpg',
    // 'assets/pictures/Wallpaper_img_02.jpg',
    // 'assets/pictures/Wallpaper_img_03.jpg',
    // 'assets/pictures/Wallpaper_img_04.jpg',
    // 'assets/pictures/Wallpaper_img_05.jpg',
    // 'assets/pictures/Wallpaper_img_06.jpg',
    // 'assets/pictures/Wallpaper_img_07.jpg',
    // 'assets/pictures/Wallpaper_img_08.jpg',
    'assets/pictures/Wallpaper_img_09.jpg',
  ];

  static const List<String> wallpapersImgGif = [
    'assets/gif/Wallpaper01.gif',
    'assets/gif/Wallpaper02.gif',
    'assets/gif/Wallpaper03.gif',
    'assets/gif/Wallpaper04.gif',
    'assets/gif/Wallpaper05.gif',
    'assets/gif/Wallpaper06.gif',
    'assets/gif/Wallpaper07.gif',
    'assets/gif/Wallpaper08.gif',
    'assets/gif/Wallpaper09.gif',
    'assets/pictures/Wallpaper_img_01.jpg',
    'assets/pictures/Wallpaper_img_02.jpg',
    'assets/pictures/Wallpaper_img_03.jpg',
    'assets/pictures/Wallpaper_img_04.jpg',
    'assets/pictures/Wallpaper_img_05.jpg',
    'assets/pictures/Wallpaper_img_06.jpg',
    'assets/pictures/Wallpaper_img_07.jpg',
    'assets/pictures/Wallpaper_img_08.jpg',
    'assets/pictures/Wallpaper_img_09.jpg',
  ];
}

const userJob = {
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

const errorTitle = 'Oops! Sepertinya ada sedikit kendala';
const errorDescription =
    'Jangan khawatir—bukan salah Anda! Sesuatu tidak berjalan sebagaimana mestinya, tapi kami sedang mengatasinya.';

const privacyPolicy =
    'Selamat datang di aplikasi mobile e-book Motivasi Penyejuk Hati. '
    'Syarat dan Ketentuan ini mengatur akses dan penggunaan Aplikasi oleh pengguna ("Anda") '
    'yang disediakan oleh [Eli Nur Nirmala Sari] ("Kami"). Dengan mengunduh, menginstal, '
    'dan menggunakan Aplikasi ini, Anda menyetujui seluruh syarat dan ketentuan yang berlaku.\n'
    'Jika Anda tidak setuju dengan salah satu bagian dari Ketentuan ini, harap segera berhenti menggunakan Aplikasi.\n\n'
    '1. Pendahuluan\n'
    '1.1 Deskripsi Layanan\n'
    'Aplikasi ini menyediakan akses ke e-book Motivasi Penyejuk Hati, '
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
    'Anda dilarang menggunakan Aplikasi untuk:\n'
    'Konten yang melanggar hukum, diskriminatif, atau berisi ujaran kebencian.\n'
    'Mendistribusikan ulang konten dari Aplikasi tanpa persetujuan tertulis dari Kami.\n\n'
    '3. Fitur Pembayaran\n'
    '3.1 Konten Premium dan Transaksi\n'
    'Beberapa e-book atau fitur dalam Aplikasi hanya dapat diakses dengan pembelian tertentu '
    'menggunakan layanan pembayaran yang terintegrasi (Xendit).\n'
    'Semua transaksi bersifat final dan tidak dapat dikembalikan, kecuali terdapat kesalahan teknis pada sistem Kami.\n'
    '3.2 Keamanan Pembayaran\n'
    'Kami bekerja sama dengan penyedia layanan pembayaran terpercaya untuk memproses transaksi Anda.\n'
    'Anda wajib memastikan informasi pembayaran yang diberikan adalah benar dan akurat.\n\n'
    '4. Hak Kekayaan Intelektual\n'
    '4.1 Hak Cipta dan Konten\n'
    'Semua konten di Aplikasi, termasuk e-book, artikel, desain, logo, dan fitur lainnya, '
    'adalah milik Kami atau pemberi lisensi Kami, dan dilindungi oleh undang-undang hak cipta.\n'
    'Anda tidak diperbolehkan menyalin, mendistribusikan, atau memodifikasi konten Aplikasi tanpa izin tertulis dari Kami.\n\n'
    '5. Kebijakan Keamanan\n'
    '5.1 Data Pengguna\n'
    'Kami berkomitmen untuk menjaga keamanan data pribadi Anda. Kebijakan penggunaan data sepenuhnya diatur dalam Kebijakan Privasi Kami.\n'
    '5.2 Tanggung Jawab Anda\n'
    'Anda bertanggung jawab atas keamanan perangkat Anda dalam menggunakan Aplikasi, '
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
    'Semua keputusan terkait penghentian akses bersifat final dan tidak dapat diganggu gugat.\n\n'
    '8. Perubahan Ketentuan\n'
    'Kami dapat memperbarui Ketentuan ini sewaktu-waktu. Jika ada perubahan signifikan, Kami akan memberitahu Anda '
    'melalui Aplikasi atau email terdaftar Anda. Dengan terus menggunakan Aplikasi setelah perubahan diberlakukan, '
    'Anda menyetujui Ketentuan yang diperbarui.\n\n'
    '9. Kontak Kami\n'
    'Jika Anda memiliki pertanyaan, saran, atau keluhan terkait Aplikasi atau Ketentuan ini, silakan hubungi Kami melalui:\n'
    'Email: 3linnsari@gmail.com\n\n'
    'KEBIJAKAN PRIVASI\n'
    'Aplikasi Mobile Motivasi Penyejuk Hati\n'
    'Versi Terakhir: 6 Desember 2024\n'
    'Kami, [Eli Nur Nirmala Sari] ("Kami"), menghargai privasi Anda dan berkomitmen untuk melindungi data pribadi yang Anda berikan saat menggunakan aplikasi mobile Motivasi Penyejuk Hati ("Aplikasi"). Kebijakan Privasi ini menjelaskan bagaimana Kami mengumpulkan, menggunakan, menyimpan, dan melindungi informasi pribadi Anda.\n'
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
    'Semua data pribadi dan informasi pembayaran dienkripsi menggunakan protokol keamanan (seperti HTTPS dan SSL) untuk mencegah akses tidak sah selama transmisi.\n'
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
    'Anda memiliki hak berikut terkait data pribadi Anda:\n'
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
    'Email: 3linnsari@gmail.com';
