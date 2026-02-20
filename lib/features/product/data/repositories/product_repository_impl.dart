import 'package:dio/dio.dart';
import 'package:labamu_test/core/configs/app_config.dart';
import 'package:labamu_test/features/product/domain/models/product_model.dart';

import '../../domain/repositories/product_repository.dart';
import '../datasources/remote/product_remote_data_source.dart';
import '../datasources/local/product_local_data_source.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;
  final ProductLocalDataSource localDataSource;

  ProductRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<List<Product>> getProducts({
    int page = 1,
    int limit = AppConfig.pageLimit,
  }) async {
    try {
      // Try to fetch from remote
      final remoteProducts = await remoteDataSource.getProducts(
        page: page,
        limit: limit,
      );

      if (page == 1) {
        await localDataSource.clearProducts();
      }

      // If successful, update local cache
      await localDataSource.saveProducts(remoteProducts);
      return remoteProducts;
    } catch (e) {
      // If remote fails, try to fetch from local
      final localProducts = await localDataSource.getProducts(
        limit: limit,
        offset: (page - 1) * limit,
      );
      if (localProducts.isNotEmpty) {
        return localProducts;
      }
      // If local is also empty, rethrow the exception
      rethrow;
    }
  }

  @override
  Future<bool> createProduct(Product product) async {
    await localDataSource.insertProduct(product, isSynced: false);

    try {
      final isCreated = await remoteDataSource.createProduct(product);
      await localDataSource.markAsSynced(product.id!);
      return isCreated;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> updateProduct(Product product) {
    return remoteDataSource.updateProduct(product);
  }

  @override
  Future<void> syncPendingProducts() async {
    final pending = await localDataSource.getUnsyncedProducts();

    for (final product in pending) {
      try {
        final success = await remoteDataSource.createProduct(product);

        if (success) {
          await localDataSource.markAsSynced(product.id!);
        }
      } on DioException catch (error) {
        if (error.type == DioExceptionType.connectionError ||
            error.type == DioExceptionType.connectionTimeout ||
            error.type == DioExceptionType.unknown) {
          break;
        }
      } catch (error) {
        continue;
      }
    }
  }
}
