import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_3/core/dio_client.dart';
import 'package:flutter_3/data/create_response.dart';
import 'package:flutter_3/data/delete_response.dart';
import 'package:flutter_3/data/edit_response.dart';
import 'package:flutter_3/data/index_response.dart';

class ItemTypeRepository extends DioClient {
  Future<CreateResponse> create(Map<String, dynamic> params) async {
    var response = await dio.post("item_type", data: params);
    dynamic responseData = response.data;
    if (responseData is String) {
      responseData = json.decode(responseData);
    }

    return CreateResponse.fromJson(responseData);
  }

  Future<IndexResponse> index() async {
    var response = await dio.get("item_type");
    dynamic responseData = response.data;
    if (responseData is String) {
      responseData = json.decode(responseData);
    }

    return IndexResponse.fromJson(responseData);
  }

  Future<EditResponse> update(int id, Map<String, dynamic> data) async {
    final response = await dio.put("item_type/$id", data: data);

    dynamic responseData = response.data;
    if (responseData is String) {
      responseData = json.decode(responseData);
    }

    return EditResponse.fromJson(responseData);
  }

  Future<DeleteResponse> delete(int id) async {
    final response = await dio.delete("item_type/$id");
    dynamic responseData = response.data;
    if (responseData is String) {
      responseData = json.decode(responseData);
    }
    return DeleteResponse.fromJson(responseData);
  }
}
