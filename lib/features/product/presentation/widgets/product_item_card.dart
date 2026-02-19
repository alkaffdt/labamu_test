import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:labamu_test/features/product/presentation/pages/add_product_dialog.dart';
import 'package:labamu_test/features/product/presentation/providers/add_product_controller_provider.dart';
import '../../domain/models/product_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductItemCard extends ConsumerWidget {
  final Product product;

  const ProductItemCard({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currencyFormatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    final dateFormatter = DateFormat('dd MMM yyyy, HH:mm');

    return InkWell(
      onTap: () {
        ref.read(addProductControllerProvider.notifier).preloadProduct(product);

        showModalBottomSheet(
          useSafeArea: true,
          context: context,
          isScrollControlled: true,
          builder: (context) => const CreateProductDialog(),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      product.name ?? '',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: product.status == 'active'
                          ? Colors.green.shade100
                          : Colors.orange.shade100,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      product.status?.toUpperCase() ?? '',
                      style: TextStyle(
                        color: product.status == 'active'
                            ? Colors.green.shade800
                            : Colors.orange.shade800,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                product.description ?? '',
                style: TextStyle(color: Colors.grey.shade600),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    product.updatedAt != null
                        ? dateFormatter.format(product.updatedAt!)
                        : '',
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                  ),
                  Text(
                    product.price != null
                        ? currencyFormatter.format(product.price!)
                        : '',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.blueAccent,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
