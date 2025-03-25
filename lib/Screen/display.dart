import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_cart_app/providers/paginationProvider.dart';

import '../models/product.dart';

class ProductGridScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(productPaginationProvider);
    final notifier = ref.read(productPaginationProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: Text("Products")),
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
                        childAspectRatio: 0.8,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                      ),
                      itemCount: state.products.length,
                      itemBuilder: (context, index) {
                        final product = state.products[index];
                        return ProductCard(product: product);
                      },
                    ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed:
                      state.currentPage > 1 ? notifier.previousPage : null,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
                  child: Text(
                    "Previous",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Text("Page ${state.currentPage}"),
                ElevatedButton(
                  onPressed: state.hasMore ? notifier.nextPage : null,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
                  child: Text("Next", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Product Card Widget
class ProductCard extends StatelessWidget {
  final Product product;
  ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image.network(
              product.thumbnail,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  "₹${product.price.toStringAsFixed(2)}",
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  "${product.discountPercentage}% OFF",
                  style: TextStyle(color: Colors.red, fontSize: 12),
                ),
                SizedBox(height: 5),
                ElevatedButton(
                  onPressed: () {
                    // Add to cart logic
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
                  child: Text("Add"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
