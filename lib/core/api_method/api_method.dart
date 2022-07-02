import 'package:api_handler/core/token/token.dart';
import 'package:api_handler/features/api_handler/data/models/response_model.dart';

import '../api_data/api_data.dart';

abstract class ApiMethod<ApiData> {
  Future<ResponseModel> call(ApiData apiData);
}

class GetApi implements ApiMethod<GetApiData> {
  /// calls the 'Get' API with data provided in `GetApiData`.
  @override
  Future<ResponseModel> call(GetApiData apiData) {
    throw UnimplementedError();
  }
}

class PostApi implements ApiMethod<PostApiData> {
  ///calls the 'Post' API with data provided in `PostApiData`.
  @override
  Future<ResponseModel> call(PostApiData apiData) {
    // TODO: implement call
    throw UnimplementedError();
  }
}
