import 'package:partsflow/data/abstract_models/products/simple_product.dart';

class SimpleProductModel implements SimpleProduct {
  final int id;
  final String name;
  final bool? isVisible;

  SimpleProductModel({
    required this.id,
    required this.name,
    this.isVisible,
  });

  factory SimpleProductModel.fromJson(Map<String, dynamic> json) {
    return SimpleProductModel(
      id: json['id'] as int,
      name: json['name'] as String,
      isVisible: json['is_visible'] as bool?,
    );
  }
  
  @override
  int getId() {
    return id;
  }
  
  @override
  bool getIsVisible() {
    return isVisible ?? false;
  }
  
  @override
  String getName() {
    return name;
  }
}
