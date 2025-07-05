import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:flutter_3/core/item_type_repository.dart';

part 'add_item_state.dart';

class AddItemCubit extends Cubit<AddItemState> {
  final ItemTypeRepository _itemTypeRepository;

  AddItemCubit({required ItemTypeRepository itemTypeRepository})
    : _itemTypeRepository = itemTypeRepository,
      super(AddItemInitial());

  void submit(String code, String name, String status) async {
    emit(AddItemLoading());
    try {
      final params = {"name": name, "code": code, "status": status};

      final result = await _itemTypeRepository.create(params);

      emit(AddItemSuccess(message: result.message));
    } on DioException catch (e) {
      final errorMessage =
          e.response?.data['message'] ?? "An unknown network error occurred.";
      emit(AddItemError(message: errorMessage));
    } catch (e) {
      emit(AddItemError(message: e.toString()));
    }
  }
}
