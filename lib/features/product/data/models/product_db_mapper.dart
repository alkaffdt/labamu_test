import 'package:labamu_test/features/product/domain/models/product_model.dart';

extension ProductDbMapper on Product {
  Map<String, dynamic> toDb() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'description': description,
      'status': status,
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  static Product fromDb(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as String?,
      name: map['name'] as String?,
      price: map['price'] as int?,
      description: map['description'] as String?,
      status: map['status'] as String?,
      updatedAt: map['updatedAt'] != null
          ? DateTime.parse(map['updatedAt'])
          : null,
    );
  }
}
