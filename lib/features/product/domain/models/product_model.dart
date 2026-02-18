import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable()
class Product extends Equatable {
  final String id;
  final String name;
  final int price;
  final String description;
  final String status;
  final DateTime updatedAt;

  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.status,
    required this.updatedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);

  @override
  List<Object?> get props => [id, name, price, description, status, updatedAt];
}
