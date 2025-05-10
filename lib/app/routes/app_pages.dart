import 'package:ebookapp/app/modules/account_upgrade/bindings/account_status_binding.dart';
import 'package:ebookapp/app/modules/account_upgrade/bindings/create_payment_binding.dart';
import 'package:ebookapp/app/modules/account_upgrade/bindings/payment_detail_binding.dart';
import 'package:ebookapp/app/modules/account_upgrade/views/account_status_view.dart';
import 'package:ebookapp/app/modules/account_upgrade/views/create_payment_view.dart';
import 'package:ebookapp/app/modules/account_upgrade/views/payment_detail_view.dart';
import 'package:ebookapp/app/modules/login/views/forgot_password.dart';
import 'package:ebookapp/app/modules/login/views/success_forgot.dart';
import 'package:ebookapp/app/modules/login/views/welcome_back_view.dart';
import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/register/views/success_register.dart';
import '../modules/settings/bindings/settings_binding.dart';
import '../modules/settings/views/change_password.dart';
import '../modules/settings/views/my_account.dart';
import '../modules/settings/views/settings_theme.dart';
import '../modules/settings/views/settings_view.dart';
import '../modules/splash_screen/bindings/splash_screen_binding.dart';
import '../modules/splash_screen/views/splash_screen_view.dart';
import '../modules/ticket_premium/bindings/ticket_premium_binding.dart';
import '../modules/ticket_premium/views/ticket_premium_view.dart';
import '../modules/wallpaper_music/bindings/wallpaper_music_binding.dart';
import '../modules/wallpaper_music/views/wallpaper_music_view.dart';
import '../modules/content/bindings/content_binding.dart';
import '../modules/content/views/content_view.dart';

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
    GetPage(
      name: _Paths.contents, // Rute untuk Motivasi
      page: () => ContentView(),
      binding: ContentBinding(),
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
    GetPage(
      name: _Paths.accountStatus,
      page: () => AccountStatusView(),
      binding: AccountStatusBinding(),
    ),
    GetPage(
      name: _Paths.createPayment,
      page: () => CreatePaymentView(),
      binding: CreatePaymentBinding(),
    ),
    GetPage(
      name: _Paths.paymentInfo,
      page: () => PaymentDetailView(),
      binding: PaymentDetailBinding(),
    ),
    GetPage(
      name: _Paths.welcomeBack,
      page: () => WelcomeBackView(),
    ),
  ];
}
