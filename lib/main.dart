import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pokak/core/rote/app_pages.dart';
import 'package:pokak/features/auth/screen/login_screen.dart';

import 'features/auth/controller/auth_controller.dart';
import 'features/auth/repository/auth_repository.dart';
import 'features/auth/screen/splash.dart';
import 'features/home/controller/product_controlelr.dart';
import 'features/home/repository/product_repository.dart';

late double height;
late double width;

void main() {
  Get.put(AuthController(AuthRepository()));
  Get.put(ProductController(ProductRepository()));
  runApp(DevicePreview(
      enabled: !kReleaseMode,
      builder:(context) =>  const MyApp(),));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    height=MediaQuery.of(context).size.height;
    width=MediaQuery.of(context).size.width;
    return GetMaterialApp(
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      getPages: AppPage.routes,
      title: 'Flutter Demo',
      home: SplashScreen(),
    );
  }
}


