// ignore: file_names
import 'package:shopping_cart_app/models/Dimensions.dart';
import 'package:shopping_cart_app/models/meta.dart';

class Product {
  final int id;
  final String title;
  final String description;
  final String category;
  final double price;
  final double discountPercentage;
  final double rating;
  final int stock;
  final List<String> tags;
  final String brand;
  final String sku;
  final double weight;
  final Dimensions dimensions;
  final String warrantyInformation;
  final String shippingInformation;
  final String availabilityStatus;
  final List<Review> reviews;
  final String returnPolicy;
  final int minimumOrderQuantity;
  final Meta meta;
  final List<String> images;
  final String thumbnail;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.tags,
    required this.brand,
    required this.sku,
    required this.weight,
    required this.dimensions,
    required this.warrantyInformation,
    required this.shippingInformation,
    required this.availabilityStatus,
    required this.reviews,
    required this.returnPolicy,
    required this.minimumOrderQuantity,
    required this.meta,
    required this.images,
    required this.thumbnail,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0, // Default to 0 if null
      title: json['title'] ?? 'No Title', // Handle null title
      description: json['description'] ?? 'No description available',
      category: json['category'] ?? 'Unknown Category',
      price: (json['price'] as num?)?.toDouble() ?? 0.0, // Handle null price
      discountPercentage:
          (json['discountPercentage'] as num?)?.toDouble() ?? 0.0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      stock: json['stock'] ?? 0, // Default stock to 0
      tags: (json['tags'] as List?)?.map((e) => e.toString()).toList() ?? [],
      brand: json['brand'] ?? 'No Brand',
      sku: json['sku'] ?? 'N/A',
      weight: (json['weight'] as num?)?.toDouble() ?? 0.0,
      dimensions:
          json['dimensions'] != null
              ? Dimensions.fromJson(json['dimensions'])
              : Dimensions(
                width: 0.0,
                height: 0.0,
                depth: 0.0,
              ), // Default dimensions
      warrantyInformation: json['warrantyInformation'] ?? 'No Warranty Info',
      shippingInformation: json['shippingInformation'] ?? 'No Shipping Info',
      availabilityStatus: json['availabilityStatus'] ?? 'Unknown',
      reviews:
          (json['reviews'] as List?)?.map((e) => Review.fromJson(e)).toList() ??
          [], // Handle null reviews
      returnPolicy: json['returnPolicy'] ?? 'No Return Policy',
      minimumOrderQuantity: json['minimumOrderQuantity'] ?? 1,
      meta:
          json['meta'] != null
              ? Meta.fromJson(json['meta'])
              : Meta(
                createdAt: DateTime.now(),
                updatedAt: DateTime.now(),
                barcode: '',
                qrCode: '',
              ),
      images:
          (json['images'] as List?)?.map((e) => e.toString()).toList() ?? [],
      thumbnail:
          json['thumbnail'] ??
          'https://via.placeholder.com/150', // Default image
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'price': price,
      'discountPercentage': discountPercentage,
      'rating': rating,
      'stock': stock,
      'tags': tags,
      'brand': brand,
      'sku': sku,
      'weight': weight,
      'dimensions': dimensions.toJson(),
      'warrantyInformation': warrantyInformation,
      'shippingInformation': shippingInformation,
      'availabilityStatus': availabilityStatus,
      'reviews': reviews.map((e) => e.toJson()).toList(),
      'returnPolicy': returnPolicy,
      'minimumOrderQuantity': minimumOrderQuantity,
      'meta': meta.toJson(),
      'images': images,
      'thumbnail': thumbnail,
    };
  }
}

class Review {
  final double rating;
  final String comment;
  final DateTime date;
  final String reviewerName;
  final String reviewerEmail;

  Review({
    required this.rating,
    required this.comment,
    required this.date,
    required this.reviewerName,
    required this.reviewerEmail,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      rating: (json['rating'] as num).toDouble(),
      comment: json['comment'],
      date: DateTime.parse(json['date']),
      reviewerName: json['reviewerName'],
      reviewerEmail: json['reviewerEmail'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rating': rating,
      'comment': comment,
      'date': date.toIso8601String(),
      'reviewerName': reviewerName,
      'reviewerEmail': reviewerEmail,
    };
  }
}
