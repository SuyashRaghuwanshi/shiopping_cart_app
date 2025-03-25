import "dart:convert";

import "package:http/http.dart" as http;
import "package:shopping_cart_app/models/product.dart";

class Apiservice {
  static const String url = "https://dummyjson.com/products";

  Future<Product> fetch() async {
    final res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      return Product.fromJson(jsonDecode(res.body));
    } else {
      throw Exception('Failed to load product');
    }
  }
}
