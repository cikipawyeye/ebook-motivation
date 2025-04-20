import 'package:ebookapp/app/modules/login/views/forgot_password.dart';
import 'package:ebookapp/app/modules/login/views/success_forgot.dart';
import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/coba_premium.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/motivasi/bindings/content_binding.dart';
import '../modules/motivasi/bindings/content_binding_drop.dart';
import '../modules/motivasi/bindings/motivasi_binding.dart';
import '../modules/motivasi/views/content_view.dart';
import '../modules/motivasi/views/content_view_drop.dart';
import '../modules/motivasi/views/content_view_push.dart';
import '../modules/motivasi/views/motivasi_view.dart';
import '../modules/motivation_detail_page/views/motivation_detail_page_view.dart';
import '../modules/pengingat/bindings/pengingat_binding.dart';
import '../modules/pengingat/views/content_pengingat_view.dart';
import '../modules/pengingat/views/pengingat_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/register/views/success_register.dart';
import '../modules/settings/bindings/settings_binding.dart';
import '../modules/settings/views/change_password.dart';
import '../modules/settings/views/detail_payment.dart';
import '../modules/settings/views/my_account.dart';
import '../modules/settings/views/payment_page.dart';
import '../modules/settings/views/settings_theme.dart';
import '../modules/settings/views/settings_view.dart';
import '../modules/settings/views/upgrade_account.dart';
import '../modules/splash_screen/bindings/splash_screen_binding.dart';
import '../modules/splash_screen/views/splash_screen_view.dart';
import '../modules/ticket_premium/bindings/ticket_premium_binding.dart';
import '../modules/ticket_premium/views/ticket_premium_view.dart';
import '../modules/wallpaper_music/bindings/wallpaper_music_binding.dart';
import '../modules/wallpaper_music/views/wallpaper_music_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.splashScreen;

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
      name: _Paths.forgotPassword,
      page: () => ForgotPassword(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.successRegis,
      page: () => SuccessRegister(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.successForgot,
      page: () => SuccessPassword(),
      binding: RegisterBinding(),
    ),
    // GetPage(
    //     name: _Paths.confirmPass,
    //     page: () => SetPasswordView(),
    //     binding: RegisterBinding()),
    GetPage(
      name: _Paths.motivasi, // Rute untuk Motivasi
      page: () => MotivasiView(),
      binding: MotivasiBinding(),
    ),
    GetPage(
      name: _Paths.motivationDetailPage, // Rute untuk Halaman Detail Motivasi
      page: () => MotivationDetailPage(),
      binding: MotivasiBinding(),
    ),
    GetPage(
      name: _Paths.motivationContents, // Rute untuk Halaman Detail Motivasi
      page: () => ContentView(),
      binding: ContentBinding(),
    ),
    GetPage(
      name: _Paths.motivationContentsDrop, // Rute untuk Halaman Detail Motivasi
      page: () => ContentViewDrop(),
      binding: ContentBindingDrop(),
    ),
    GetPage(
        name: _Paths.contentViewPush,
        page: () => ContentViewPush(),
        binding: ContentBindingDrop()),
    GetPage(
      name: _Paths.pengingatContents,
      page: () => ContentPengingatView(),
      binding: PengingatBinding(),
    ),
    GetPage(
      name: _Paths.pengingat, // Rute untuk Motivasi
      page: () => PengingatView(),
      binding: PengingatBinding(),
    ),
    GetPage(
      name: _Paths.settings,
      page: () => SettingsView(),
      binding: SettingsBinding(), // Perbaikan di sini
    ),
    GetPage(
      name: _Paths.myAccount,
      page: () => AccountSettings(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: _Paths.settingsTheme,
      page: () => SettingsTheme(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: _Paths.changePass,
      page: () => ChangePassword(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: _Paths.upgradeAccount,
      page: () => UpgradeAccount(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: _Paths.paymentDetail,
      page: () => PaymentDetail(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: _Paths.paymentPage,
      page: () => PaymentPage(),
      binding: SettingsBinding(),
    ),
    GetPage(
        name: _Paths.tryPremium,
        page: () => CobaPremium(),
        binding: SettingsBinding()),
    GetPage(
      name: _Paths.ticketPremium,
      page: () => const TicketPremiumView(),
      binding: TicketPremiumBinding(),
    ),
    GetPage(
      name: _Paths.splashScreen,
      page: () => const SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: _Paths.wallpaperMusic,
      page: () => WallpaperMusicView(),
      binding: WallpaperMusicBinding(),
    ),
  ];
}
