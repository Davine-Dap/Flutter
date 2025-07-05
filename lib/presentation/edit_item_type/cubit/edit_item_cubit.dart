import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_3/core/item_type_repository.dart'; // Import the correct repository
import 'package:meta/meta.dart';

part 'edit_item_state.dart';

// The local ItemTypeRepository class has been removed to avoid confusion.

class EditItemCubit extends Cubit<EditItemState> {
  final ItemTypeRepository itemTypeRepository;

  EditItemCubit({ItemTypeRepository? repository})
    : itemTypeRepository = repository ?? ItemTypeRepository(),
      super(EditItemInitial());

  void update(int id, String code, String name, String status) async {
    emit(EditItemLoading());

    try {
      final params = {"name": name, "code": code, "status": status};
      // The update method now correctly calls the repository which returns a parsed object.
      final result = await itemTypeRepository.update(id, params);
      emit(EditingItemSuccess(result.message));
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.sendTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        emit(EditingItemError("Masalah Koneksi Jaringan. Silakan coba lagi."));
      } else {
        // It's good practice to provide a more specific error from the response if available
        final errorMessage =
            e.response?.data['message'] ??
            "Terjadi masalah. Silakan coba lagi.";
        emit(EditingItemError(errorMessage));
      }
    } catch (e) {
      emit(EditingItemError(e.toString()));
    }
  }
}
