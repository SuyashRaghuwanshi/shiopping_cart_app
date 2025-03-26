import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_cart_app/Screen/cartScreen.dart';
import 'package:shopping_cart_app/providers/cartProvider/cartProvider.dart';
import 'package:shopping_cart_app/providers/paginationProvider/paginationProvider.dart';
import 'package:shopping_cart_app/widgets/display.dart';

class ProductGridScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(productPaginationProvider);
    final notifier = ref.read(productPaginationProvider.notifier);
    final cartNotifier = ref.read(cartProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text("Shopping Cart"),
        leading: Consumer(
          builder: (context, ref, child) {
            final cartItems = ref.watch(cartProvider).cartItems.length;
            return Stack(
              alignment: Alignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.shopping_cart),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CartScreen()),
                    );
                  },
                ),
                if (cartItems > 0)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: CircleAvatar(
                      radius: 10,
                      backgroundColor: Colors.red,
                      child: Text(
                        cartItems.toString(),
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
      body: Column(
        children: [
          Display(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed:
                      state.currentPage > 1 ? notifier.previousPage : null,
                  child: Text("Previous"),
                ),
                Text("Page ${state.currentPage}"),
                ElevatedButton(
                  onPressed: state.hasMore ? notifier.nextPage : null,
                  child: Text("Next"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
