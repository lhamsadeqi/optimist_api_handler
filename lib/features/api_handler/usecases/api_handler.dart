library api_handler;

import 'package:api_handler/features/api_handler/data/models/query_model.dart';

import '../../../core/token/token.dart';
import '../data/enums/header_enum.dart';
import '../../../core/api_data/api_data.dart';
import '../../../core/api_method/api_method.dart';
import '../data/enums/response_enum.dart';
import '../data/models/response_model.dart';

class APIHandler {
  final GetApi _getApi = GetApi();
  final PostApi _postApi = PostApi();
  final PutApi _putApi = PutApi();
  final DeleteApi _deleteApi = DeleteApi();

  static Function? _onTokenExpired;

  /// this method is called when the token is expired.
  onTokenExpired(Function _onTokenExp) {
    _onTokenExpired = _onTokenExp;
  }

  /// sets Token to use bearer header in APIs.
  setToken(String? token) {
    Token _token = Token();
    _token.setToken = token;
  }

  /// get Token if exists
  String? get token => Token().token;

  /// calls a 'Get' API and returns a `ResponseModel`.
  Future<ResponseModel> get(
    String url, {
    List<QueryModel>? queries,
    String? pathVariable,
    required HeaderEnum headerEnum,
    required ResponseEnum responseEnum,
  }) async {
    ResponseModel responseModel = await _getApi(GetApiData(
      url,
      queries: queries,
      pathVars: pathVariable,
      headerEnum: headerEnum,
      responseEnum: responseEnum,
    ));
    if (_onTokenExpired != null && responseModel.statusCode == '401') {
      _onTokenExpired!();
    }
    return responseModel;
  }

  /// calls a 'Post' API and returns a `ResponseModel`.
  Future<ResponseModel> post(
    String url, {
    List<QueryModel>? queries,
    String? pathVariable,
    dynamic body,
    required HeaderEnum headerEnum,
    required ResponseEnum responseEnum,
  }) async {
    ResponseModel responseModel = await _postApi(PostApiData(
      url,
      queries: queries,
      pathVars: pathVariable,
      body: body,
      headerEnum: headerEnum,
      responseEnum: responseEnum,
    ));
    if (_onTokenExpired != null && responseModel.statusCode == '401') {
      _onTokenExpired!();
    }
    return responseModel;
  }

  /// calls a 'put' API and returns a `ResponseModel`.
  Future<ResponseModel> put(
    String url, {
    List<QueryModel>? queries,
    String? pathVariable,
    dynamic body,
    required HeaderEnum headerEnum,
    required ResponseEnum responseEnum,
  }) async {
    ResponseModel responseModel = await _putApi(PutApiData(
      url,
      queries: queries,
      pathVars: pathVariable,
      body: body,
      headerEnum: headerEnum,
      responseEnum: responseEnum,
    ));
    if (_onTokenExpired != null && responseModel.statusCode == '401') {
      _onTokenExpired!();
    }
    return responseModel;
  }

  /// calls a 'delete' API and returns a `ResponseModel`.
  Future<ResponseModel> delete(
    String url, {
    List<QueryModel>? queries,
    String? pathVariable,
    dynamic body,
    required HeaderEnum headerEnum,
    required ResponseEnum responseEnum,
  }) async {
    ResponseModel responseModel = await _deleteApi(DeleteApiData(
      url,
      queries: queries,
      pathVars: pathVariable,
      body: body,
      headerEnum: headerEnum,
      responseEnum: responseEnum,
    ));
    if (_onTokenExpired != null && responseModel.statusCode == '401') {
      _onTokenExpired!();
    }
    return responseModel;
  }
}
