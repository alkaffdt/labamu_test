import 'package:labamu_test/core/configs/app_config.dart';
import 'package:labamu_test/core/database/database_service.dart';
import 'package:labamu_test/features/product/domain/models/product_model.dart';
import 'package:sqflite/sqflite.dart';

abstract class ProductLocalDataSource {
  Future<List<Product>> getProducts({
    int limit = AppConfig.pageLimit,
    int offset = 0,
  });
  Future<void> saveProducts(List<Product> products);
  Future<void> clearProducts();
}

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  final DatabaseService _databaseService;

  ProductLocalDataSourceImpl(this._databaseService);

  @override
  Future<List<Product>> getProducts({
    int limit = AppConfig.pageLimit,
    int offset = 0,
  }) async {
    final db = await _databaseService.database;

    final List<Map<String, dynamic>> maps = await db.query(
      'products',
      limit: limit,
      offset: offset,
      orderBy: 'updatedAt DESC', // penting supaya paging stabil
    );

    return maps.map((map) {
      return Product(
        id: map['id'] as String,
        name: map['name'] as String,
        price: map['price'] as int,
        description: map['description'] as String,
        status: map['status'] as String,
        updatedAt: DateTime.parse(map['updatedAt'] as String),
      );
    }).toList();
  }

  @override
  Future<void> saveProducts(List<Product> products) async {
    final db = await _databaseService.database;
    final batch = db.batch();

    for (var product in products) {
      batch.insert('products', {
        'id': product.id,
        'name': product.name,
        'price': product.price,
        'description': product.description,
        'status': product.status,
        'updatedAt': product.updatedAt?.toIso8601String(),
      }, conflictAlgorithm: ConflictAlgorithm.replace);
    }

    await batch.commit(noResult: true);
  }

  @override
  Future<void> clearProducts() async {
    final db = await _databaseService.database;
    await db.delete('products');
  }
}
