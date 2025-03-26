import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_cart_app/api/apiService.dart';
import 'package:shopping_cart_app/models/product.dart';
import 'package:shopping_cart_app/providers/paginationProvider/paginationState.dart';

class PaginationNotifier extends StateNotifier<PaginationState> {
  static const String baseUrl = "https://dummyjson.com/products";
  static const int limit = 10;

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
      final apiService = Apiservice();
      final jsonData = await apiService.fetchProducts(page);
      final List<Product> newProducts =
          (jsonData['products'] as List)
              .map((e) => Product.fromJson(e))
              .toList();

      int totalProducts = jsonData['total'];

      print("Fetched ${newProducts.length} products for page $page");
      print("Existing products count before update: ${state.products.length}");

      state = state.copyWith(
        products: page == 1 ? newProducts : [...newProducts],
        isLoading: false,
        currentPage: page,
        hasMore: (page * limit) < totalProducts,
      );

      print("Updated products count: ${state.products.length}");
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
