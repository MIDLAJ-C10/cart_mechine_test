import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../../features/home/screen/product_list.dart';
import '../../features/home/screen/product_details.dart';
import 'app_rote.dart';

class AppPage{
  static final routes=[
    GetPage(
        name: Routes.PRODUCT,
        page: () => ProductListScreen()
    ),

    GetPage(
        name: Routes.PRODUCT_DETAILS,
        page: () => ProductDetailsScreen(productId: Get.arguments ,),
    ),


  ];
}