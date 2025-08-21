import 'package:partsflow/data/models/products/product.dart';

class OrderProductQuantityRepository {
  final int id;
  final int quantity;
  final String? comments;
  final bool isDismissed;
  final bool isQuoted;
  final int order;
  final SimpleProductRepository product;
  final DateTime createdAt;
  final DateTime updatedAt;

  OrderProductQuantityRepository({
    required this.id,
    required this.quantity,
    this.comments,
    required this.isDismissed,
    required this.isQuoted,
    required this.order,
    required this.product,
    required this.createdAt,
    required this.updatedAt,
  });

  // fromJson
  factory OrderProductQuantityRepository.fromJson(Map<String, dynamic> json) {
    return OrderProductQuantityRepository(
      id: json['id'] as int,
      quantity: json['quantity'] as int,
      comments: json['comments'] as String?,
      isDismissed: json['is_dismissed'] as bool,
      isQuoted: json['is_quoted'] as bool,
      order: json['order'] as int,
      product: SimpleProductRepository.fromJson(json['product'] as Map<String, dynamic>),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }
}
