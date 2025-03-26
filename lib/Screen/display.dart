import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_cart_app/Screen/cartScreen.dart';
import 'package:shopping_cart_app/models/cartItem.dart';
import 'package:shopping_cart_app/models/product.dart';
import 'package:shopping_cart_app/providers/cartProvider.dart';
import 'package:shopping_cart_app/providers/paginationProvider.dart';

class ProductGridScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(productPaginationProvider);
    final notifier = ref.read(productPaginationProvider.notifier);
    final cartNotifier = ref.read(cartProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text("Products"),
        leading: Consumer(
          builder: (context, ref, child) {
            final cartItems = ref.watch(cartProvider).cartItems.length;
            return Stack(
              children: [
                IconButton(
                  icon: Icon(Icons.shopping_cart),
                  onPressed: () {
                    // Navigate to cart screen
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
          Expanded(
            child:
                state.isLoading
                    ? Center(child: CircularProgressIndicator())
                    : GridView.builder(
                      padding: EdgeInsets.all(8),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.75,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                      ),
                      itemCount: state.products.length,
                      itemBuilder: (context, index) {
                        final Product product = state.products[index];
                        return Card(
                          child: Column(
                            children: [
                              Expanded(
                                child: Image.network(
                                  product.thumbnail,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product.title,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "\$${product.price.toStringAsFixed(2)}",
                                          style: TextStyle(
                                            color: Colors.red,
                                            decoration:
                                                TextDecoration.lineThrough,
                                          ),
                                        ),
                                        SizedBox(width: 20),
                                        Text(
                                          "\$${(product.price * (1 - product.discountPercentage / 100)).toStringAsFixed(2)}",
                                          style: TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            final cartNotifier = ref.read(
                                              cartProvider.notifier,
                                            );
                                            cartNotifier.addToCart(
                                              CartItem(
                                                id: product.id,
                                                title: product.title,
                                                price:
                                                    product.price *
                                                    (1 -
                                                        (product.discountPercentage /
                                                            100)),
                                                quantity: 1, // Start with 1
                                                thumbnail: product.thumbnail,
                                                review:
                                                    product.reviews.isNotEmpty
                                                        ? product
                                                            .reviews[0]
                                                            .comment
                                                        : "No reviews",
                                                rating: product.rating,
                                              ),
                                            );

                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  "${product.title} added to cart!",
                                                ),
                                              ),
                                            );
                                          },
                                          child: Text("Add to Cart"),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
          ),
        ],
      ),
    );
  }
}
