import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_cart_app/providers/paginationProvider.dart';

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
                                child: Text(
                                  product.title,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: state.currentPage > 0 ? notifier.previousPage : null,
                child: Text("Previous"),
              ),
              Text("Page ${state.currentPage + 1}"),
              TextButton(onPressed: notifier.nextPage, child: Text("Next")),
            ],
          ),
        ],
      ),
    );
  }
}
