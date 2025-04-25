import 'package:flutter/material.dart';

const String imageDirectory = 'assets/images/';
const String imageURL = 'https://trustcollect.qrbdl.com/';
const String baseUrl = 'https://motivasiislami.com';
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
    BoxShadow(blurRadius: 20, color: colorBlack.withOpacity(0.2));

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
    'assets/audio/PenyejukHati2.mp3',
    'assets/audio/PenyejukHati3.mp3',
    'assets/audio/PenyejukHati4.mp3',
    'assets/audio/PenyejukHati5.mp3',
    'assets/audio/PenyejukHati6.mp3',
    'assets/audio/PenyejukHati7.mp3',
    'assets/audio/PenyejukHati8.mp3',
    'assets/audio/PenyejukHati9.mp3',
    'assets/audio/PenyejukHati10.mp3'
  ];

  // Daftar Wallpaper
  static const List<String> wallpapers = [
    'assets/videos/Wallpaper01.mp4',
    'assets/videos/Wallpaper02.mp4',
    'assets/videos/Wallpaper03.mp4',
    'assets/videos/Wallpaper04.mp4',
    'assets/videos/Wallpaper05.mp4',
    'assets/videos/Wallpaper06.mp4',
    'assets/videos/Wallpaper07.mp4',
    'assets/videos/Wallpaper08.mp4',
    'assets/videos/Wallpaper09.mp4',
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
