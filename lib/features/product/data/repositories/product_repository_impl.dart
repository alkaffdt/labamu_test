import '../../domain/models/product_model.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_remote_data_source.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Product>> getProducts() async {
    return remoteDataSource.getProducts();
  }

  @override
  Future<bool> createProduct(Product product) async {
    return remoteDataSource.createProduct(product);
  }

  @override
  Future<bool> updateProduct(Product product) async {
    return remoteDataSource.updateProduct(product);
  }

  // @override
  // Future<bool> deleteProduct(String id) async {
  //   return remoteDataSource.deleteProduct(id);
  // }
}
