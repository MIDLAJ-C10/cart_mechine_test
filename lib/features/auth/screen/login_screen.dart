import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/color_constant.dart';
import '../../../main.dart';
import '../controller/auth_controller.dart';

// class LoginScreen extends StatelessWidget {
//   LoginScreen({super.key});
//
//   final AuthController controller = Get.find<AuthController>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         foregroundColor: ColorConst.white,
//         toolbarHeight: width * 0.22,
//         backgroundColor: ColorConst.primaryColor,
//         surfaceTintColor: ColorConst.primaryColor,
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [
//               Theme.of(context).colorScheme.primary.withOpacity(0.1),
//               Theme.of(context).colorScheme.secondary.withOpacity(0.05),
//               Theme.of(context).colorScheme.surface,
//             ],
//           ),
//         ),
//         child: SafeArea(
//           child: Center(
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.symmetric(horizontal: 24),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   // Modern Logo Container
//                   Container(
//                     padding: const EdgeInsets.all(24),
//                     decoration: BoxDecoration(
//                       color: Theme.of(context).colorScheme.primary,
//                       borderRadius: BorderRadius.circular(24),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
//                           blurRadius: 20,
//                           offset: const Offset(0, 10),
//                         ),
//                       ],
//                     ),
//                     child: Icon(
//                       Icons.storefront_rounded,
//                       size: 48,
//                       color: Colors.white,
//                     ),
//                   ),
//                   const SizedBox(height: 32),
//
//                   // Modern Title
//                   Text(
//                     "Welcome Back!",
//                     style: Theme.of(context).textTheme.headlineLarge?.copyWith(
//                       fontWeight: FontWeight.w800,
//                       letterSpacing: -0.5,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     "Discover amazing products and deals",
//                     style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//                       color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ),
//                   const SizedBox(height: 48),
//
//                   // Modern Form Container
//                   Container(
//                     padding: const EdgeInsets.all(24),
//                     decoration: BoxDecoration(
//                       color: Theme.of(context).colorScheme.surface,
//                       borderRadius: BorderRadius.circular(20),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.05),
//                           blurRadius: 20,
//                           offset: const Offset(0, 4),
//                         ),
//                       ],
//                       border: Border.all(
//                         color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
//                       ),
//                     ),
//                     child: Column(
//                       children: [
//                         // Modern Username Field
//                         Container(
//                           decoration: BoxDecoration(
//                             color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
//                             borderRadius: BorderRadius.circular(16),
//                           ),
//                           child: TextField(
//                             controller: controller.usernameController,
//                             style: const TextStyle(fontSize: 16),
//                             decoration: InputDecoration(
//                               labelText: "Username or Email",
//                               labelStyle: TextStyle(
//                                 color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
//                                 fontWeight: FontWeight.w500,
//                               ),
//                               prefixIcon: Container(
//                                 margin: const EdgeInsets.all(12),
//                                 padding: const EdgeInsets.all(8),
//                                 decoration: BoxDecoration(
//                                   color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
//                                   borderRadius: BorderRadius.circular(8),
//                                 ),
//                                 child: Icon(
//                                   Icons.person_rounded,
//                                   color: Theme.of(context).colorScheme.primary,
//                                   size: 20,
//                                 ),
//                               ),
//                               border: InputBorder.none,
//                               contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 20),
//
//                         // Modern Password Field
//                         Container(
//                           decoration: BoxDecoration(
//                             color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
//                             borderRadius: BorderRadius.circular(16),
//                           ),
//                           child: Obx(
//                                 () => TextField(
//                               controller: controller.passwordController,
//                               obscureText: controller.isPasswordHidden.value,
//                               style: const TextStyle(fontSize: 16),
//                               decoration: InputDecoration(
//                                 labelText: "Password",
//                                 labelStyle: TextStyle(
//                                   color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                                 prefixIcon: Container(
//                                   margin: const EdgeInsets.all(12),
//                                   padding: const EdgeInsets.all(8),
//                                   decoration: BoxDecoration(
//                                     color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
//                                     borderRadius: BorderRadius.circular(8),
//                                   ),
//                                   child: Icon(
//                                     Icons.lock_rounded,
//                                     color: Theme.of(context).colorScheme.primary,
//                                     size: 20,
//                                   ),
//                                 ),
//                                 suffixIcon: IconButton(
//                                   icon: Icon(
//                                     controller.isPasswordHidden.value
//                                         ? Icons.visibility_off_rounded
//                                         : Icons.visibility_rounded,
//                                     color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
//                                   ),
//                                   onPressed: () {
//                                     controller.isPasswordHidden.toggle();
//                                   },
//                                 ),
//                                 border: InputBorder.none,
//                                 contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
//                               ),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 24),
//
//                         SizedBox(
//                           width: double.infinity,
//                           height: 56,
//                           child: ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Theme.of(context).colorScheme.primary,
//                               foregroundColor: Colors.white,
//                               elevation: 0,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(16),
//                               ),
//                               shadowColor: Theme.of(context).colorScheme.primary.withOpacity(0.3),
//                             ),
//                             onPressed: () => controller.login(
//                               controller.usernameController.text,
//                               controller.passwordController.text,
//                             ),
//                             child: Obx(
//                                   () => controller.isLoading.value
//                                   ? const SizedBox(
//                                 width: 24,
//                                 height: 24,
//                                 child: CircularProgressIndicator(
//                                   color: Colors.white,
//                                   strokeWidth: 2.5,
//                                 ),
//                               )
//                                   : Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   const Text(
//                                     "Sign In",
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.w600,
//                                     ),
//                                   ),
//                                   const SizedBox(width: 8),
//                                   Icon(
//                                     Icons.arrow_forward_rounded,
//                                     size: 20,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 32),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
// }

class Login extends StatelessWidget {
  Login({super.key});

  final AuthController controller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    bool eye = false;
    return Scaffold(
      appBar: AppBar(
        foregroundColor: ColorConst.white,
        toolbarHeight: width * 0.2,
        backgroundColor: ColorConst.primaryColor,
        surfaceTintColor: ColorConst.primaryColor,
      ),
      backgroundColor: ColorConst.primaryColor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "LoopCart",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: CupertinoColors.white,
                fontSize: width * 0.1,
              ),
            ),
            SizedBox(height: width * 0.1),
            Container(
              height: width * 1.563,
              width: width * 1,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(width * 0.1),
                  topRight: Radius.circular(width * 0.1),
                ),
                color: CupertinoColors.white,
              ),
              child: Padding(
                padding: EdgeInsets.all(width * 0.05),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Welcome Back",
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: width * 0.08,
                        color: ColorConst.black,
                      ),
                    ),
                    Text(
                      "Enter your details below",
                      style: TextStyle(
                        fontSize: width * 0.04,
                        color: ColorConst.black,
                      ),
                    ),
                    SizedBox(
                      height: width * 0.13,

                      child: TextFormField(
                        controller: controller.usernameController,
                        style: TextStyle(color: ColorConst.black),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: "Email",
                          hintText: "enter Email Address",
                          hintStyle: TextStyle(color: ColorConst.black),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: ColorConst.black),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: width * 0.13,
                      child: TextFormField(
                        controller: controller.passwordController,
                        style: TextStyle(color: ColorConst.black),
                        obscureText: true,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          labelText: "Password",
                          labelStyle: TextStyle(
                            color: ColorConst.black.withOpacity(0.5),
                          ),
                          hintText: "Enter password",
                          hintStyle: TextStyle(
                            color: ColorConst.black.withOpacity(0.5),
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              eye = !eye;
                            },
                            child: Icon(
                              Icons.visibility_off,
                              color: ColorConst.black,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: ColorConst.black),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.login(
                          controller.usernameController.text,
                          controller.passwordController.text,
                        );
                      },
                      child: Container(
                        height: width * 0.15,
                        width: width * 1,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(width * 0.03),
                          color: ColorConst.primaryColor,
                        ),
                        child: Center(
                          child: Text(
                            "Log In",
                            style: TextStyle(
                              fontSize: width * 0.04,
                              fontWeight: FontWeight.w800,
                              color: ColorConst.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
