import '../../domain/models/product_model.dart';

abstract class ProductRepository {
  Future<List<Product>> getProducts();
}
