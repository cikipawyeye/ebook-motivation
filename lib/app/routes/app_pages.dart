import 'package:ebookapp/app/modules/home/bindings/home_binding.dart';
import 'package:ebookapp/app/modules/home/views/home_view.dart';
import 'package:ebookapp/app/modules/login/bindings/login_binding.dart';
import 'package:ebookapp/app/modules/login/views/login_view.dart';
import 'package:ebookapp/app/modules/motivasi/bindings/motivasi_binding.dart';
import 'package:ebookapp/app/modules/motivation_detail_page/views/motivation_detail_page_view.dart';
import 'package:ebookapp/app/modules/register/bindings/register_binding.dart';
import 'package:ebookapp/app/modules/register/views/register_view.dart';
import 'package:get/get.dart';
import '../modules/motivasi/views/motivasi_view.dart';   

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.login;

  static final routes = [
    GetPage(
      name: _Paths.home,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.login,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.register,
      page: () => RegisterPage(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.motivasi,  // Rute untuk Motivasi
      page: () => MotivasiView(),
      binding: MotivasiBinding(),
    ),
    GetPage(
      name: _Paths.motivationDetailPage,  // Rute untuk Halaman Detail Motivasi
      page: () => MotivationDetailPage(),
      binding: MotivasiBinding(),
    ),
  ];
}
