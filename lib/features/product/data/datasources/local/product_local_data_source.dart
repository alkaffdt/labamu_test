import 'package:labamu_test/core/configs/app_config.dart';
import 'package:labamu_test/core/database/database_service.dart';
import 'package:labamu_test/features/product/data/models/product_db_mapper.dart';
import 'package:labamu_test/features/product/domain/models/product_model.dart';
import 'package:sqflite/sqflite.dart';

abstract class ProductLocalDataSource {
  Future<List<Product>> getProducts({
    int limit = AppConfig.pageLimit,
    int offset = 0,
  });
  Future<void> saveProducts(List<Product> products);
  //
  Future<void> insertProduct(Product product, {required bool isSynced});
  Future<void> updateProduct(Product product, {required bool isSynced});
  //
  Future<List<Product>> getUnsyncedProducts();
  Future<void> markAsSynced(String id);
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
      orderBy: 'updatedAt DESC',
    );

    return maps.map(ProductDbMapper.fromDb).toList();
  }

  @override
  Future<void> insertProduct(Product product, {required bool isSynced}) async {
    final db = await _databaseService.database;

    final dbMap = product.toDb();

    dbMap['is_synced'] = isSynced ? 1 : 0;

    await db.insert(
      'products',
      dbMap,
      conflictAlgorithm: ConflictAlgorithm.abort,
    );
  }

  @override
  Future<void> saveProducts(List<Product> products) async {
    final db = await _databaseService.database;
    final batch = db.batch();

    for (final product in products) {
      final map = product.toDb();

      // update if the data existed
      batch.update('products', map, where: 'id = ?', whereArgs: [product.id]);

      // insert else ignore
      batch.insert(
        'products',
        map,
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
    }

    await batch.commit(noResult: true);
  }

  @override
  Future<void> updateProduct(Product product, {required bool isSynced}) async {
    final db = await _databaseService.database;

    final dbMap = product.toDb();
    dbMap['is_synced'] = isSynced ? 1 : 0;

    await db.update(
      'products',
      dbMap,
      where: 'id = ?',
      whereArgs: [product.id],
    );
  }

  @override
  Future<List<Product>> getUnsyncedProducts() async {
    final db = await _databaseService.database;

    final maps = await db.query(
      'products',
      where: 'is_synced = ?',
      whereArgs: [0],
      orderBy: 'updatedAt ASC',
    );

    return maps.map(ProductDbMapper.fromDb).toList();
  }

  @override
  Future<void> markAsSynced(String id) async {
    final db = await _databaseService.database;

    await db.update(
      'products',
      {'is_synced': 1},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<void> clearProducts() async {
    final db = await _databaseService.database;
    await db.delete('products');
  }
}
