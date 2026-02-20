import 'package:labamu_test/core/configs/app_config.dart';
import '../../domain/models/product_model.dart';

abstract class ProductRepository {
  Future<List<Product>> getProducts({
    int page = 1,
    int limit = AppConfig.pageLimit,
  });
  Future<bool> createProduct(Product product);
  Future<bool> updateProduct(Product product);
  // Future<bool> deleteProduct(String id);
  //
  Future<void> syncPendingProducts();
}
