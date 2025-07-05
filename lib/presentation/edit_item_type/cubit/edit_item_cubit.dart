import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

part 'edit_item_state.dart';

class ItemTypeRepository {
  Future<({String message})> update(int id, Map<String, dynamic> params) async {
    print("Updating item $id with params: $params");
    await Future.delayed(const Duration(seconds: 1));
    if (params['code'] == 'fail') {
      throw DioException(
        requestOptions: RequestOptions(path: ''),
        type: DioExceptionType.connectionTimeout,
      );
    }
    return (message: "Item updated successfully!");
  }
}

class EditItemCubit extends Cubit<EditItemState> {
  final ItemTypeRepository itemTypeRepository;

  EditItemCubit({ItemTypeRepository? repository})
    : itemTypeRepository = repository ?? ItemTypeRepository(),
      super(EditItemInitial());

  void update(int id, String code, String name, String status) async {
    emit(EditItemLoading());

    try {
      final params = {"name": name, "code": code, "status": status};
      final result = await itemTypeRepository.update(id, params);
      emit(EditingItemSuccess(result.message));
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.sendTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        emit(EditingItemError("Masalah Koneksi Jaringan. Silakan coba lagi."));
      } else {
        emit(EditingItemError("Terjadi masalah. Silakan coba lagi."));
      }
    } catch (e) {
      emit(EditingItemError(e.toString()));
    }
  }
}
