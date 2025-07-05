import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_3/core/item_type_repository.dart';
import 'package:flutter_3/data/index_response.dart';
import 'package:flutter_3/data/model/item_type.dart';

part 'item_type_index_state.dart';

class ItemTypeIndexCubit extends Cubit<ItemTypeIndexState> {
  ItemTypeRepository itemTypeRepository = ItemTypeRepository();

  ItemTypeIndexCubit() : super(ItemTypeIndexInitial()) {
    index();
  }

  void index() async {
    emit(ItemTypeIndexLoading());
    IndexResponse result = await itemTypeRepository.index();
    debugPrint("Hasil ${result.itemTypes.length}");
    emit(ItemTypeIndexLoaded(itemTypes: result.itemTypes));
    try {
      IndexResponse result = await itemTypeRepository.index();
      debugPrint("Hasil ${result.itemTypes.length}");
      emit(ItemTypeIndexLoaded(itemTypes: result.itemTypes));
    } catch (e) {
      debugPrint("❌ Error saat ambil data: $e");
      emit(ItemTypeIndexError("Gagal ambil data"));
    }
  }
}
