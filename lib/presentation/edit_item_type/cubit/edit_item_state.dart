part of 'edit_item_cubit.dart';

@immutable
sealed class EditItemState {}

class EditItemInitial extends EditItemState {}

class EditItemLoading extends EditItemState {}

class EditingItemSuccess extends EditItemState {
  final String message;
  EditingItemSuccess(this.message);
}

class EditingItemError extends EditItemState {
  final String message;
  EditingItemError(this.message);
}
