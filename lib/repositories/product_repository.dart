import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';

class ProductRepository {
  final String _baseUrl = 'https://interview.gdev.gosbfy.com/api/collections/Products/records';

  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List<Product> products = [];

      if (data['items'] != null) {
        for (var item in data['items']) {
          products.add(Product.fromJson(item));
        }
      }

      return products;
    } else {
      throw Exception('Failed to load products');
    }
  }
}
