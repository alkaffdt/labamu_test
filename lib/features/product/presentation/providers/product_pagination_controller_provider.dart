import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:labamu_test/core/configs/app_config.dart';
import 'package:labamu_test/features/product/presentation/providers/product_provider.dart';
import 'package:labamu_test/features/product/domain/models/product_model.dart';

final productsPagingControllerProvider =
    Provider.autoDispose<PagingController<int, Product>>((ref) {
      final repo = ref.watch(productRepositoryProvider);

      final controller = PagingController<int, Product>(firstPageKey: 1);

      controller.addPageRequestListener((pageKey) async {
        try {
          final result = await repo.getProducts(page: pageKey, limit: 10);

          if (result.length < AppConfig.pageLimit) {
            controller.appendLastPage(result);
          } else {
            controller.appendPage(result, pageKey + 1);
          }
        } catch (error) {
          controller.error = error;
        }
      });

      ref.onDispose(() => controller.dispose());

      return controller;
    });
