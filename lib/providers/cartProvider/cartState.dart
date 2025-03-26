import 'package:shopping_cart_app/models/cartItem.dart';

class CartState {
  final List<CartItem> cartItems;

  CartState({required this.cartItems});

  CartState copyWith({List<CartItem>? cartItems}) {
    return CartState(cartItems: cartItems ?? this.cartItems);
  }
}
