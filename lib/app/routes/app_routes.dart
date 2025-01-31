part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const home = _Paths.home;
  static const login = _Paths.login;
  static const register = _Paths.register;
  static const motivasi = _Paths.motivasi;
  static const motivationContents = _Paths.motivationContents;
  static const pengingat = _Paths.pengingat;
  static const settings = _Paths.settings;
  static const motivationDetailPage = _Paths
      .motivationDetailPage; // Menambahkan rute untuk halaman detail motivasi
}

abstract class _Paths {
  _Paths._();
  static const home = '/home';
  static const login = '/login';
  static const register = '/register';
  static const motivasi = '/motivasi'; // Pastikan ini sesuai dengan rute di UI
  static const motivationContents = '/motivation/contents';
  static const pengingat = '/pengingat';
  static const settings = '/settings';
  static const motivationDetailPage =
      '/motivation-detail-page'; // Menambahkan path untuk halaman detail motivasi
}
