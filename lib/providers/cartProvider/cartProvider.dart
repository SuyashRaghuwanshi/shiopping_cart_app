import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_cart_app/providers/cartProvider/cartNotifier.dart';
import 'package:shopping_cart_app/providers/cartProvider/cartState.dart';

final cartProvider = StateNotifierProvider<CartNotifier, CartState>((ref) {
  return CartNotifier();
});
