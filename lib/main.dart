import 'package:ebookapp/app/modules/splash_screen/controllers/background_audio_controller.dart';
import 'package:ebookapp/core/global_lifecycle_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Get.put(BackgroundAudioController());

  WidgetsBinding.instance.addObserver(GlobalLifecycleObserver());

  runApp(
    ScreenUtilInit(
      designSize: const Size(375, 812), // Ukuran desain untuk iPhone 13 Pro
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Ebook Apps",
          initialRoute: AppPages.initial,
          getPages: AppPages.routes,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
        );
      },
    ),
  );
}
