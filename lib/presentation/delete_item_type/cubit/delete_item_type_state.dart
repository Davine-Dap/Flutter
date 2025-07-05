part of 'delete_item_type_cubit.dart';

@immutable
sealed class DeleteItemTypeState {}

final class DeleteItemTypeInitial extends DeleteItemTypeState {}

final class DeleteItemTypeLoading extends DeleteItemTypeState {}

final class DeleteItemTypeSuccess extends DeleteItemTypeState {
  final String message;
  DeleteItemTypeSuccess(this.message);
}

final class DeleteItemTypeError extends DeleteItemTypeState {
  final String message;
  DeleteItemTypeError(this.message);
}
