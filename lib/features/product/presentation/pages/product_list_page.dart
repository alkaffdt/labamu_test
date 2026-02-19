import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:labamu_test/core/common_widgets/app_dialogs.dart';
import 'package:labamu_test/extensions/navigation_extension.dart';
import 'package:labamu_test/features/product/domain/models/submission_status_state.dart';
import 'package:labamu_test/features/product/presentation/pages/add_product_dialog.dart';
import 'package:labamu_test/features/product/presentation/providers/add_product_controller_provider.dart';
import '../providers/products_provider.dart';
import '../widgets/product_item_card.dart';

class ProductListPage extends ConsumerWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsyncValue = ref.watch(productsProvider);

    ref.listen(
      addProductControllerProvider.select((value) => value.submissionStatus),
      (previous, next) {
        switch (next) {
          case SubmissionStatus.loading:
            AppDialog.showLoadingDialog(context);
            break;
          case SubmissionStatus.success:
            context.pop();
            AppDialog.showSuccessDialog(
              context,
              message: 'Product added successfully',
            );
            break;

          default:
            context.pop();
            break;
        }
      },
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Products', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue[900],
      ),
      floatingActionButton: productsAsyncValue.asData?.hasValue ?? false
          ? FloatingActionButton(
              backgroundColor: Colors.blue[900],
              onPressed: () {
                showModalBottomSheet(
                  useSafeArea: true,
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => const CreateProductDialog(),
                );
              },
              child: const Icon(Icons.add, color: Colors.white),
            )
          : null,
      body: productsAsyncValue.when(
        data: (products) => ListView.builder(
          padding: const EdgeInsets.only(bottom: 80),
          itemCount: products.length,
          itemBuilder: (context, index) {
            return ProductItemCard(product: products[index]);
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
