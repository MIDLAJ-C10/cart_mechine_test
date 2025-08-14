import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/auth_model.dart';
import '../../home/screen/product_list.dart';
import '../repository/auth_repository.dart';

class AuthController extends GetxController {
  final AuthRepository repository;
  AuthController(this.repository);
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final isPasswordHidden = true.obs;
  final isLoading = false.obs;

  Future<void> login(String username, String password) async {

    if (kDebugMode) {
      print("Login attempt with $username / $password");
    }
    try {
      isLoading.value = true;
      final request = LoginRequestModel(username: username, password: password);
      final result = await repository.login(request);

      if (kDebugMode) {
        print(" Login success! Token.........: ${result.token}");
      } // Debug log
      Get.snackbar("Success", "Login Successful",
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
      );

      await Future.delayed(const Duration(milliseconds: 300));
      Get.offAll(() => ProductListScreen());
    } catch (e) {
      if (kDebugMode) {
        print("Login error.....: ${e.toString()}");
      } // More detailed error
      Get.snackbar('Login Field ', 'please Try Again ...',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.all(16),
        borderRadius: 12,);
    } finally {
      isLoading.value = false;
    }
  }
}
