import 'package:flutter_3/core/dio_client.dart';
import 'package:flutter_3/data/create_response.dart';
import 'package:flutter_3/data/index_response.dart';

class ItemTypeRepository extends DioClient {
  Future<CreateResponse> create(Map<String, dynamic> params) async {
    var response = await dio.post("item_type", data: params);
    return CreateResponse.fromJson(response.data);
  }

  Future<IndexResponse> index() async {
    var response = await dio.get("item_type");
    return IndexResponse.fromJson(response.data);
  }
}
