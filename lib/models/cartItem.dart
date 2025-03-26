class CartItem {
  final int id;
  final String title;
  final double price;
  final int quantity;
  final String thumbnail;
  final String review;
  final double rating;

  CartItem({
    required this.id,
    required this.title,
    required this.price,
    required this.quantity,
    required this.thumbnail,
    required this.review,
    required this.rating,
  });

  CartItem copyWith({int? quantity}) {
    return CartItem(
      id: id,
      title: title,
      price: price,
      quantity: quantity ?? this.quantity,
      thumbnail: thumbnail,
      review: review,
      rating: rating,
    );
  }
}
