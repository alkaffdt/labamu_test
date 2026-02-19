import 'package:dio/dio.dart';
import '../../domain/models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<Product>> getProducts();
  Future<bool> createProduct(Product product);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final Dio _dio;

  ProductRemoteDataSourceImpl(this._dio);

  @override
  Future<List<Product>> getProducts() async {
    final response = await _dio.get('/products?_sort=-updatedAt');

    if (response.statusCode == 200) {
      final List<dynamic> data = response.data;
      return data
          .map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        type: DioExceptionType.badResponse,
      );
    }
  }

  @override
  Future<bool> createProduct(Product product) async {
    final response = await _dio.post('/products', data: product.toJson());

    final data = product.toJson();
    data.remove('id');

    if (response.statusCode == 201) {
      return true;
    } else {
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        type: DioExceptionType.badResponse,
      );
    }
  }
}
