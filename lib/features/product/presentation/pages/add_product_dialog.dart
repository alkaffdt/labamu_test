import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:labamu_test/extensions/int_extensions.dart';
import 'package:labamu_test/extensions/navigation_extension.dart';
import 'package:labamu_test/extensions/text_style_extension.dart';
import 'package:labamu_test/features/product/presentation/providers/add_product_controller_provider.dart';
import 'package:labamu_test/features/product/presentation/providers/products_provider.dart';

class CreateProductDialog extends ConsumerWidget {
  const CreateProductDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(addProductControllerProvider.notifier);

    return Container(
      padding: const EdgeInsets.all(
        16,
      ).copyWith(top: 32, bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Text(
                'Add Product',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            24.toHeightGap(),
            TextField(
              onChanged: (value) => controller.onNameChanged(value),
              decoration: const InputDecoration(
                labelText: 'Product Name',
                border: OutlineInputBorder(),
              ),
            ),
            16.toHeightGap(),
            TextField(
              onChanged: (value) =>
                  controller.onPriceChanged(int.tryParse(value) ?? 0),
              keyboardType: .number,
              decoration: const InputDecoration(
                labelText: 'Price',
                border: OutlineInputBorder(),
              ),
            ),
            16.toHeightGap(),
            TextField(
              minLines: 3,
              maxLines: 7,
              onChanged: (value) => controller.onDescriptionChanged(value),
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
            ),
            16.toHeightGap(),
            _ActiveSwitch(),
            24.toHeightGap(),
            _SubmitButton(),
            32.toHeightGap(),
          ],
        ),
      ),
    );
  }
}

class _ActiveSwitch extends ConsumerWidget {
  const _ActiveSwitch();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(addProductControllerProvider.notifier);
    final isActive = ref.watch(addProductControllerProvider).status == 'ACTIVE';

    return Row(
      children: [
        const Text('Active'),
        24.toWidthGap(),
        Switch.adaptive(
          value: isActive,
          onChanged: (value) => controller.onActiveChanged(value),
        ),
      ],
    );
  }
}

class _SubmitButton extends ConsumerWidget {
  const _SubmitButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(addProductControllerProvider);
    final isValidated = ref
        .watch(addProductControllerProvider.notifier)
        .isFormValid;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isValidated ? Colors.blue[800] : Colors.grey[400],
        minimumSize: const Size(double.infinity, 48),
      ),
      onPressed: isValidated
          ? () async {
              ref.read(addProductControllerProvider.notifier).submitProduct();
            }
          : null,
      child: Text('Add Product').textColor(Colors.white),
    );
  }
}
