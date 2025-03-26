import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_cart_app/models/product.dart';
import 'package:shopping_cart_app/models/cartItem.dart';
import 'package:shopping_cart_app/providers/cartProvider/cartProvider.dart';
import 'package:shopping_cart_app/providers/paginationProvider/paginationProvider.dart';

class Display extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(productPaginationProvider);
    final cartNotifier = ref.read(cartProvider.notifier);

    return Expanded(
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
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "\$${product.price.toStringAsFixed(2)}",
                                    style: TextStyle(
                                      color: Colors.red,
                                      decoration: TextDecoration.lineThrough,
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
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      cartNotifier.addToCart(
                                        CartItem(
                                          id: product.id,
                                          title: product.title,
                                          price:
                                              product.price *
                                              (1 -
                                                  (product.discountPercentage /
                                                      100)),
                                          quantity: 1,
                                          thumbnail: product.thumbnail,
                                          review:
                                              product.reviews.isNotEmpty
                                                  ? product.reviews[0].comment
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
    );
  }
}
