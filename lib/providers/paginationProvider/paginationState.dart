import 'package:shopping_cart_app/models/product.dart';

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
