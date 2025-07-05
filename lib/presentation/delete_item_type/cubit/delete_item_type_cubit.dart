import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_3/core/item_type_repository.dart';

part 'delete_item_type_state.dart';

class DeleteItemTypeCubit extends Cubit<DeleteItemTypeState> {
  final ItemTypeRepository _itemTypeRepository;
  DeleteItemTypeCubit({ItemTypeRepository? itemTypeRepository})
    : _itemTypeRepository = itemTypeRepository ?? ItemTypeRepository(),
      super(DeleteItemTypeInitial());

  void delete(int id) async {
    emit(DeleteItemTypeLoading());
    try {
      final result = await _itemTypeRepository.delete(id);
      emit(DeleteItemTypeSuccess(result.message));
    } on DioException catch (e) {
      final errorMessage =
          e.response?.data['message'] ?? "Gagal menghapus data";
      emit(DeleteItemTypeError(errorMessage));
    } catch (e) {
      emit(DeleteItemTypeError(e.toString()));
    }
  }
}
