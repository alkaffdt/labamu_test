import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:labamu_test/features/product/data/models/add_product_state.dart';
import 'package:labamu_test/features/product/domain/models/product_model.dart';
import 'package:labamu_test/features/product/domain/repositories/product_repository.dart';
import 'package:labamu_test/features/product/presentation/providers/products_provider.dart';

final addProductControllerProvider =
    StateNotifierProvider<AddProductController, Product>((ref) {
      return AddProductController(ref.watch(productRepositoryProvider));
    });

class AddProductController extends StateNotifier<Product> {
  AddProductController(this.productRepository) : super(Product());

  final ProductRepository productRepository;

  void onNameChanged(String name) {
    state = state.copyWith(name: name);
  }

  void onPriceChanged(int price) {
    state = state.copyWith(price: price);
  }

  void onDescriptionChanged(String description) {
    state = state.copyWith(description: description);
  }

  void reset() {
    state = Product();
  }

  void onActiveChanged(bool active) {
    state = state.copyWith(status: active ? 'ACTIVE' : 'DRAFT');
  }

  bool get isFormValid {
    return state.name != null &&
        state.price != null &&
        state.description != null;
  }

  Future<bool> submitProduct() async {
    try {
      // Update the product with current timestamp
      state = state.copyWith(updatedAt: DateTime.now());
      //
      final isSubmitted = await productRepository.createProduct(state);
      if (isSubmitted) {
        reset();
        return true;
      }

      return false;
    } catch (error) {
      return false;
    }
  }
}
