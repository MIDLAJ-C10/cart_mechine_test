import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/color_constant.dart';
import '../../../main.dart';
import '../../home/screen/product_list.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
    _initSplash();
  }

  void _initSplash() async {
    await Future.delayed(const Duration(seconds: 3));
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");

    if (token != null && token.isNotEmpty) {
      Get.offAll(
            () => ProductListScreen(),
        transition: Transition.fadeIn,
        duration: const Duration(milliseconds: 400),
      );
    } else {
      Get.offAll(
            () => Login(),
        transition: Transition.fadeIn,
        duration: const Duration(milliseconds: 400),
      );
    }
  }



  @override
  void dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorConst.primaryColor,
        body: Center(child: Text("Loop Cart",style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: width*0.1,
            color: ColorConst.white
        ),)),
       );
  }
}

