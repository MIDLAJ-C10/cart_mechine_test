import 'package:get/get.dart';
import '../../../models/product_list_model.dart';

import '../repository/product_repository.dart';

class ProductController extends GetxController {
  final ProductRepository repository;
  ProductController(this.repository);

  var isLoading = false.obs;
  var products = <Product>[].obs;
  var errorMessage = "".obs;

  Future<void> loadProducts() async {
    try {
      isLoading.value = true;
      products.value = await repository.fetchProducts();
      errorMessage.value = "";
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }


  var selectedProduct = Rxn<Product>();

  Future<void> loadProductDetails(int id) async {
    try {
      isLoading.value = true;
      selectedProduct.value = await repository.fetchProductById(id);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

}
