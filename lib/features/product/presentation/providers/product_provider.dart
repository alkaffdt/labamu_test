import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:labamu_test/features/product/domain/models/product_model.dart';
import '../../../../core/database/database_service.dart';
import '../../../../core/network/dio_provider.dart';
import '../../data/datasources/remote/product_remote_data_source.dart';
import '../../data/datasources/local/product_local_data_source.dart';
import '../../data/repositories/product_repository_impl.dart';
import '../../domain/repositories/product_repository.dart';

final databaseServiceProvider = Provider<DatabaseService>((ref) {
  return DatabaseService();
});

final productLocalDataSourceProvider = Provider<ProductLocalDataSource>((ref) {
  final dbService = ref.watch(databaseServiceProvider);
  return ProductLocalDataSourceImpl(dbService);
});

final productRemoteDataSourceProvider = Provider<ProductRemoteDataSource>((
  ref,
) {
  final dio = ref.watch(dioProvider);
  return ProductRemoteDataSourceImpl(dio);
});

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  final remoteDataSource = ref.watch(productRemoteDataSourceProvider);
  final localDataSource = ref.watch(productLocalDataSourceProvider);
  return ProductRepositoryImpl(
    remoteDataSource: remoteDataSource,
    localDataSource: localDataSource,
  );
});

final productsProvider = FutureProvider<List<Product>>((ref) async {
  final repository = ref.watch(productRepositoryProvider);
  return repository.getProducts();
});
