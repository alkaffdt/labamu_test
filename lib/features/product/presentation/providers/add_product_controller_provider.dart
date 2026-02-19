import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:labamu_test/features/product/domain/models/add_product_state.dart';
import 'package:labamu_test/features/product/domain/models/product_model.dart';
import 'package:labamu_test/features/product/domain/models/submission_status_state.dart';
import 'package:labamu_test/features/product/domain/repositories/product_repository.dart';
import 'package:labamu_test/features/product/presentation/providers/products_provider.dart';

final addProductControllerProvider =
    StateNotifierProvider<AddProductController, AddProductState>((ref) {
      return AddProductController(ref.watch(productRepositoryProvider));
    });

class AddProductController extends StateNotifier<AddProductState> {
  AddProductController(this.productRepository) : super(AddProductState());

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

  void resetState() {
    state = const AddProductState();
  }

  void onActiveChanged(bool active) {
    state = state.copyWith(status: active ? 'ACTIVE' : 'DRAFT');
  }

  bool get isFormValid {
    return state.name != null &&
        state.price != null &&
        state.description != null;
  }

  Future<void> submitProduct() async {
    try {
      state = state.copyWith(submissionStatus: SubmissionStatus.loading);

      final product = Product(
        name: state.name!,
        price: state.price!,
        description: state.description!,
        status: state.status,
        updatedAt: DateTime.now(),
      );
      //
      final isSubmitted = await productRepository.createProduct(product);
      if (isSubmitted) {
        resetState();
        state = state.copyWith(submissionStatus: SubmissionStatus.success);
      }
    } catch (error) {
      state = state.copyWith(submissionStatus: SubmissionStatus.error);
    }
  }
}
