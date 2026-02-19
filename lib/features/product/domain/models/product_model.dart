import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable()
class Product extends Equatable {
  final String? id;
  final String? name;
  final int? price;
  final String? description;
  final String? status;
  final DateTime? updatedAt;

  const Product({
    this.id,
    this.name,
    this.price,
    this.description,
    this.status = 'active',
    this.updatedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);

  Product copyWith({
    String? id,
    String? name,
    int? price,
    String? description,
    String? status,
    DateTime? updatedAt,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      description: description ?? this.description,
      status: status ?? this.status,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [id, name, price, description, status, updatedAt];
}
