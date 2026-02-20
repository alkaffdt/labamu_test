import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:labamu_test/extensions/paging_controller_extension.dart';
import 'package:labamu_test/features/product/domain/models/add_product_state.dart';
import 'package:labamu_test/features/product/domain/models/product_model.dart';
import 'package:labamu_test/features/product/domain/models/submission_status_state.dart';
import 'package:labamu_test/features/product/domain/repositories/product_repository.dart';
import 'package:labamu_test/features/product/presentation/providers/product_pagination_controller_provider.dart';
import 'package:labamu_test/features/product/presentation/providers/product_provider.dart';

final addProductControllerProvider =
    StateNotifierProvider<AddProductController, AddProductState>((ref) {
      final pagingController = ref.watch(productsPagingControllerProvider);
      return AddProductController(
        ref.watch(productRepositoryProvider),
        pagingController,
      );
    });

class AddProductController extends StateNotifier<AddProductState> {
  AddProductController(this.productRepository, this.productPaginationController)
    : super(AddProductState());

  final ProductRepository productRepository;
  final PagingController<int, Product> productPaginationController;

  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  void preloadProduct(Product product) {
    state = state.copyWith(
      id: product.id,
      name: product.name,
      price: product.price,
      description: product.description,
      status: product.status ?? 'draft',
    );

    nameController.text = product.name ?? '';
    priceController.text = product.price.toString();
    descriptionController.text = product.description ?? '';
  }

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
    nameController.clear();
    priceController.clear();
    descriptionController.clear();
  }

  void onActiveChanged(bool active) {
    state = state.copyWith(status: active ? 'active' : 'draft');
  }

  bool get isFormValid {
    return state.name != null &&
        state.price != null &&
        state.description != null;
  }

  Future<void> updateProduct(Product product) async {
    try {
      // state = state.copyWith(submissionStatus: SubmissionStatus.loading);
      //
      productRepository.updateProduct(product);
      productPaginationController.updateItem(
        product,
        matcher: (item) => item.id == product.id,
      );
      state = state.copyWith(submissionStatus: SubmissionStatus.unsynced);
      resetState();
    } catch (error) {
      // Log
      state = state.copyWith(submissionStatus: SubmissionStatus.error);
    }
  }

  Future<void> addProduct() async {
    try {
      // state = state.copyWith(submissionStatus: SubmissionStatus.loading);

      final product = Product(
        id: state.id,
        name: state.name!,
        price: state.price!,
        description: state.description!,
        status: state.status,
        updatedAt: DateTime.now(),
      );

      if (state.id != null) {
        updateProduct(product);
        return;
      }

      productRepository.createProduct(product);
      productPaginationController.insertItem(product);
      state = state.copyWith(submissionStatus: SubmissionStatus.unsynced);
      resetState();
    } catch (error) {
      // Log euy
      state = state.copyWith(submissionStatus: SubmissionStatus.error);
    }
  }
}
