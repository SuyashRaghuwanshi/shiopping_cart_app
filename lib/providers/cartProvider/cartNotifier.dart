import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_cart_app/providers/cartProvider/cartState.dart';
import 'package:shopping_cart_app/models/cartItem.dart';

class CartNotifier extends StateNotifier<CartState> {
  CartNotifier() : super(CartState(cartItems: []));

  void addToCart(CartItem item) {
    List<CartItem> updatedCart = List.from(state.cartItems);
    int index = updatedCart.indexWhere((cartItem) => cartItem.id == item.id);

    print("Adding item: ${item.id}, Current Cart: ${updatedCart.length}");

    if (index != -1) {
      print("Item already in cart, updating quantity...");
      updatedCart[index] = updatedCart[index].copyWith(
        quantity: updatedCart[index].quantity + 1,
      );
    } else {
      print("Item not in cart, adding new item...");
      updatedCart.add(item);
    }

    state = state.copyWith(cartItems: updatedCart);
    print("Cart updated, New Cart Length: ${state.cartItems.length}");
  }

  void removeFromCart(int id) {
    List<CartItem> updatedCart = List.from(state.cartItems);
    int index = updatedCart.indexWhere((item) => item.id == id);

    if (index != -1) {
      if (updatedCart[index].quantity > 1) {
        // Reduce quantity if greater than 1
        updatedCart[index] = updatedCart[index].copyWith(
          quantity: updatedCart[index].quantity - 1,
        );
      } else {
        // Remove if quantity becomes 1
        updatedCart.removeAt(index);
      }
    }

    state = state.copyWith(cartItems: updatedCart);
  }

  void clearCart() {
    state = state.copyWith(cartItems: []);
  }
}
