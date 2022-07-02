library api_handler;

import 'package:api_handler/core/token/token.dart';
import 'package:api_handler/features/api_handler/data/enums/header_enum.dart';
import 'package:api_handler/features/api_handler/data/enums/response_enum.dart';

import '../../core/api_data/api_data.dart';
import '../../core/api_method/api_method.dart';
import 'data/models/response_model.dart';

class APIHandler {
  GetApi _getApi = GetApi();
  PostApi _postApi = PostApi();

  /// sets Token to use bearer header in APIs.
  setToken(String? token) {
    Token _token = Token();
    _token.setToken = token;
  }

  /// calls a 'Get' API and returns a `ResponseModel`.
  Future<ResponseModel> get(
    String url, {
    required HeaderEnum headerEnum,
    required ResponseEnum responseEnum,
  }) async {
    return await _getApi(GetApiData(
      url,
      headerEnum: headerEnum,
      responseEnum: responseEnum,
    ));
  }

  /// calls a 'Post' API and returns a `ResponseModel`.
  Future<ResponseModel> post(
    String url, {
    dynamic body,
    required HeaderEnum headerEnum,
    required ResponseEnum responseEnum,
  }) async {
    return _postApi(PostApiData(
      url,
      body: body,
      headerEnum: headerEnum,
      responseEnum: responseEnum,
    ));
  }
}
