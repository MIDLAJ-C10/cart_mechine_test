import 'package:get/get.dart';
import '../../../models/product_list_model.dart';

import '../repository/product_repository.dart';

class ProductController extends GetxController {
  final ProductRepository repository;
  ProductController(this.repository);

  var isLoading = false.obs;
  var products = <Product>[].obs;
  var errorMessage = "".obs;
  var selectedProduct = Rxn<Product>();

  var quantity = 1.obs;
  var isFavorite = false.obs;


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



  void toggleFavorite() => isFavorite.value = !isFavorite.value;
  void increaseQuantity() => quantity.value++;
  void decreaseQuantity() {
    if (quantity.value > 1) quantity.value--;
  }


}
