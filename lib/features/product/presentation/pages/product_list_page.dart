import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:labamu_test/core/common_widgets/app_dialogs.dart';
import 'package:labamu_test/core/sync/sync_manager_provider.dart';
import 'package:labamu_test/extensions/navigation_extension.dart';
import 'package:labamu_test/features/product/domain/models/product_model.dart';
import 'package:labamu_test/features/product/domain/models/submission_status_state.dart';
import 'package:labamu_test/features/product/presentation/pages/add_product_dialog.dart';
import 'package:labamu_test/features/product/presentation/providers/add_product_controller_provider.dart';
import 'package:labamu_test/features/product/presentation/providers/product_pagination_controller_provider.dart';
import 'package:labamu_test/features/product/presentation/providers/product_provider.dart';
import '../widgets/product_item_card.dart';

class ProductListPage extends ConsumerWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      addProductControllerProvider.select((value) => value.submissionStatus),
      (previous, next) {
        switch (next) {
          case SubmissionStatus.success:
            context.pop();
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Products synced')));
            break;

          case SubmissionStatus.error:
            context.pop();
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Products saved')));

          default:
            break;
        }
      },
    );

    final pagingController = ref.watch(productsPagingControllerProvider);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Products', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue[900],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue[900],
        onPressed: () {
          ref.read(addProductControllerProvider.notifier).resetState();

          showModalBottomSheet(
            useSafeArea: true,
            context: context,
            isScrollControlled: true,
            builder: (context) => const CreateProductDialog(),
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.read(productsPagingControllerProvider).refresh();
          ref.read(syncManagerProvider).manualSync();
        },
        child: PagedListView<int, Product>(
          pagingController: pagingController,
          builderDelegate: PagedChildBuilderDelegate<Product>(
            // Loadings
            firstPageProgressIndicatorBuilder: (context) =>
                const Center(child: CircularProgressIndicator.adaptive()),
            newPageProgressIndicatorBuilder: (context) =>
                const Center(child: CircularProgressIndicator.adaptive()),
            // Empty view
            noItemsFoundIndicatorBuilder: (context) =>
                const Center(child: Text('No products found')),
            // Error views
            firstPageErrorIndicatorBuilder: (context) =>
                Center(child: Text('Error: ${pagingController.error}')),
            newPageErrorIndicatorBuilder: (context) =>
                Center(child: Text('Error: ${pagingController.error}')),
            //
            itemBuilder: (context, product, index) =>
                ProductItemCard(product: product),
          ),
        ),
      ),
    );
  }
}
