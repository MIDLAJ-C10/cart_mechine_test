import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../core/constants/api_constant.dart';
import '../../../models/product_list_model.dart';

class ProductRepository {
  final String baseUrl = "https://fakestoreapi.com";

  Future<List<Product>> fetchProducts() async {
    final url = Uri.parse(ApiConstant.product_list);
    final response = await http.get(url);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final List data = jsonDecode(response.body);
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load products: ${response.body}");
    }
  }


  Future<Product> fetchProductById(int id) async {
    final url = Uri.parse("${ApiConstant.product_list}/$id");
    final response = await http.get(url);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final data = jsonDecode(response.body);
      return Product.fromJson(data);
    } else {
      throw Exception("Failed to load product: ${response.body}");
    }
  }

}
