import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/cartProvider.dart';

class CartScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider).cartItems;
    final cartNotifier = ref.read(cartProvider.notifier);

    double totalPrice = cartItems.fold(
      0,
      (sum, item) => sum + (item.price * item.quantity),
    );

    return Scaffold(
      appBar: AppBar(title: Text("Shopping Cart")),
      body:
          cartItems.isEmpty
              ? Center(child: Text("Your cart is empty"))
              : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        final product = cartItems[index];

                        return Card(
                          margin: EdgeInsets.all(8),
                          child: ListTile(
                            leading: Image.network(
                              product.thumbnail,
                              width: 50,
                              height: 50,
                            ),
                            title: Text(product.title),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "₹${(product.price * product.quantity).toStringAsFixed(2)}",
                                ),
                                Text("Quantity: ${product.quantity}"),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 16,
                                    ),
                                    Text(product.rating.toString()),
                                  ],
                                ),
                                Text("Review: ${product.review}"),
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(
                                    Icons.remove_circle,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    cartNotifier.removeFromCart(product.id);
                                  },
                                ),
                                Text("${product.quantity}"),
                                IconButton(
                                  icon: Icon(
                                    Icons.add_circle,
                                    color: Colors.green,
                                  ),
                                  onPressed: () {
                                    cartNotifier.addToCart(product);
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Total: ₹${totalPrice.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
    );
  }
}
