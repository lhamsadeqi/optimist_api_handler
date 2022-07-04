import 'package:api_handler/features/api_handler/data/models/response_model.dart';
import '../../features/api_handler/data/datasources/remote_data_api_fucntions.dart';
import '../api_data/api_data.dart';

abstract class ApiMethod<ApiData> {
  Future<ResponseModel> call(ApiData apiData);
}

class GetApi implements ApiMethod<GetApiData> {
  /// calls the 'Get' API with data provided in `GetApiData`.
  @override
  Future<ResponseModel> call(GetApiData apiData) async {
    RemoteDataApiFuncImpl remoteDataApiFuncImpl = RemoteDataApiFuncImpl();

    ResponseModel response = await remoteDataApiFuncImpl.httpGet(
      apiData.url,
      apiData.queries,
      apiData.pathVars,
      apiData.headerEnum,
      apiData.responseEnum,
    );

    return response;
  }
}

class PostApi implements ApiMethod<PostApiData> {
  ///calls the 'Post' API with data provided in `PostApiData`.
  @override
  Future<ResponseModel> call(PostApiData apiData) async {
    RemoteDataApiFuncImpl remoteDataApiFuncImpl = RemoteDataApiFuncImpl();

    ResponseModel response = await remoteDataApiFuncImpl.httpPost(
      apiData.url,
      apiData.queries,
      apiData.pathVars,
      apiData.body,
      apiData.headerEnum,
      apiData.responseEnum,
    );

    return response;
  }
}

class PutApi implements ApiMethod<PutApiData> {
  /// calls the 'Put' API with data provided in `PutApiData`.
  @override
  Future<ResponseModel> call(PutApiData apiData) async {
    RemoteDataApiFuncImpl remoteDataApiFuncImpl = RemoteDataApiFuncImpl();

    ResponseModel response = await remoteDataApiFuncImpl.httpPut(
      apiData.url,
      apiData.queries,
      apiData.pathVars,
      apiData.body,
      apiData.headerEnum,
      apiData.responseEnum,
    );

    return response;
  }
}

class DeleteApi implements ApiMethod<DeleteApiData> {
  /// calls the 'Get' API with data provided in `GetApiData`.
  @override
  Future<ResponseModel> call(DeleteApiData apiData) async {
    RemoteDataApiFuncImpl remoteDataApiFuncImpl = RemoteDataApiFuncImpl();

    ResponseModel response = await remoteDataApiFuncImpl.httpDelete(
      apiData.url,
      apiData.queries,
      apiData.pathVars,
      apiData.body,
      apiData.headerEnum,
      apiData.responseEnum,
    );

    return response;
  }
}
