import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
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
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(const MyApp());
  });
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
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.linear(1.0),
          ),
          child: child!,
        );
      },
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: SplashScreen(),
    );
  }
}


