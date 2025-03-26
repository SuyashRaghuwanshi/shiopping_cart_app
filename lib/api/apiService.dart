import "dart:convert";
import "dart:developer";

import "package:http/http.dart" as http;

class Apiservice {
  static const String baseUrl = "https://dummyjson.com/products";
  static const int limit = 10;

  Future<dynamic> fetchProducts(int page) async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl?limit=$limit&skip=${(page - 1) * limit}"),
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return jsonData;
      } else {
        log("Error: Status Code ${response.statusCode}");
      }
    } catch (e) {
      log("Error fetching products: $e");
    }
  }
}
