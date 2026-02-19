import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:labamu_test/core/database/app_database.dart';
import 'package:labamu_test/features/product/data/models/product_dao.dart';
import 'package:labamu_test/features/product/domain/models/product_model.dart';
import 'features/product/presentation/pages/product_list_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Labamu Test',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue[900]!),
        useMaterial3: true,
      ),
      home: const ProductListPage(),
    );
  }
}
