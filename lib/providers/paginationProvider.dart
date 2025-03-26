import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../models/product.dart';

class PaginationState {
  final List<Product> products;
  final bool isLoading;
  final int currentPage;
  final bool hasMore;

  PaginationState({
    required this.products,
    required this.isLoading,
    required this.currentPage,
    required this.hasMore,
  });

  PaginationState copyWith({
    List<Product>? products,
    bool? isLoading,
    int? currentPage,
    bool? hasMore,
  }) {
    return PaginationState(
      products: products ?? this.products,
      isLoading: isLoading ?? this.isLoading,
      currentPage: currentPage ?? this.currentPage,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}

class PaginationNotifier extends StateNotifier<PaginationState> {
  static const String baseUrl = "https://dummyjson.com/products";
  static const int limit = 15;

  PaginationNotifier()
    : super(
        PaginationState(
          products: [],
          isLoading: false,
          currentPage: 1, // ✅ Start from page 1
          hasMore: true,
        ),
      ) {
    fetchProducts(1);
  }

  Future<void> fetchProducts(int page) async {
    if (state.isLoading) return;

    state = state.copyWith(isLoading: true);

    try {
      final response = await http.get(
        Uri.parse("$baseUrl?limit=$limit&skip=${(page - 1) * limit}"),
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final List<Product> newProducts =
            (jsonData['products'] as List)
                .map((e) => Product.fromJson(e))
                .toList();

        int totalProducts = jsonData['total']; // ✅ Extract total count

        print("Fetched ${newProducts.length} products for page $page");

        state = PaginationState(
          products: newProducts, // ✅ Replace previous list
          isLoading: false,
          currentPage: page,
          hasMore: (page * limit) < totalProducts, // ✅ Correct check
        );
      }
    } catch (e) {
      print("Error fetching products: $e");
      state = state.copyWith(isLoading: false);
    }
  }

  void nextPage() {
    if (!state.hasMore) {
      print("No more products to load.");
      return;
    }

    int nextPage = state.currentPage + 1;
    print("Fetching next page: $nextPage"); // Debugging
    fetchProducts(nextPage);
  }

  void previousPage() {
    if (state.currentPage > 1) {
      int prevPage = state.currentPage - 1;
      print("Fetching previous page: $prevPage"); // Debugging
      fetchProducts(prevPage);
    }
  }
}

// Riverpod Provider
final productPaginationProvider =
    StateNotifierProvider<PaginationNotifier, PaginationState>(
      (ref) => PaginationNotifier(),
    );
