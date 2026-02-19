import '../../domain/models/product_model.dart';

abstract class ProductRepository {
  Future<List<Product>> getProducts();
  Future<bool> createProduct(Product product);
  Future<bool> updateProduct(Product product);
  // Future<bool> deleteProduct(String id);
}
