// Riverpod Provider
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_cart_app/providers/paginationProvider/paginationNotifier.dart';
import 'package:shopping_cart_app/providers/paginationProvider/paginationState.dart';

final productPaginationProvider =
    StateNotifierProvider<PaginationNotifier, PaginationState>(
      (ref) => PaginationNotifier(),
    );
