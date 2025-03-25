import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_cart_app/models/product.dart';
import 'package:shopping_cart_app/providers/paginationProvider.dart';

class CartState {
  final List<Product> cartItems;
  CartState({required this.cartItems});
}

class CartNotifier extends StateNotifier<CartState> {
  CartNotifier() : super(CartState(cartItems: []));

  void addToCart(Product product) {
    state = CartState(cartItems: [...state.cartItems, product]);
  }

  void removeFromCart(Product product) {
    state = CartState(
      cartItems:
          state.cartItems.where((item) => item.id != product.id).toList(),
    );
  }
}

final cartProvider = StateNotifierProvider<CartNotifier, CartState>((ref) {
  return CartNotifier();
});
