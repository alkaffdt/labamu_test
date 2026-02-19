import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:labamu_test/features/product/domain/models/submission_status_state.dart';

part 'add_product_state.freezed.dart';

@freezed
abstract class AddProductState with _$AddProductState {
  const factory AddProductState({
    @Default(SubmissionStatus.initial) SubmissionStatus submissionStatus,
    String? name,
    int? price,
    String? description,
    @Default('ACTIVE') String status,
  }) = _AddProductState;
}
