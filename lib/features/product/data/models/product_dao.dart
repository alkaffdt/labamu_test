import 'package:labamu_test/features/product/data/models/product_db_mapper.dart';
import 'package:labamu_test/features/product/domain/models/product_model.dart';
import 'package:sqflite/sqflite.dart';

class ProductDao {
  final Database db;

  ProductDao(this.db);

  Future<void> insert(Product product) async {
    await db.insert(
      'products',
      product.toDb(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Product>> getAll() async {
    final result = await db.query('products');
    return result.map(ProductDbMapper.fromDb).toList();
  }
}
