import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final productPaginationProvider =
    StateNotifierProvider<ProductPaginationNotifier, ProductPaginationState>(
      (ref) => ProductPaginationNotifier(),
    );

class ProductPaginationState {
  final List<Product> products;
  final int currentPage;
  final bool isLoading;

  ProductPaginationState({
    required this.products,
    required this.currentPage,
    required this.isLoading,
  });

  ProductPaginationState copyWith({
    List<Product>? products,
    int? currentPage,
    bool? isLoading,
  }) {
    return ProductPaginationState(
      products: products ?? this.products,
      currentPage: currentPage ?? this.currentPage,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class ProductPaginationNotifier extends StateNotifier<ProductPaginationState> {
  ProductPaginationNotifier()
    : super(
        ProductPaginationState(products: [], currentPage: 0, isLoading: false),
      );

  final int _limit = 10;

  Future<void> fetchProducts(int page) async {
    state = state.copyWith(isLoading: true);

    final url =
        'https://dummyjson.com/products?limit=$_limit&skip=${page * _limit}';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<Product> newProducts =
          (data['products'] as List).map((e) => Product.fromJson(e)).toList();

      state = ProductPaginationState(
        products: newProducts,
        currentPage: page,
        isLoading: false,
      );
    } else {
      state = state.copyWith(isLoading: false);
    }
  }

  void nextPage() {
    fetchProducts(state.currentPage + 1);
  }

  void previousPage() {
    if (state.currentPage > 0) {
      fetchProducts(state.currentPage - 1);
    }
  }
}

class Product {
  final int id;
  final String title;
  final String thumbnail;

  Product({required this.id, required this.title, required this.thumbnail});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      thumbnail: json['thumbnail'],
    );
  }
}
