import 'dart:io';

import 'package:api_handler/core/api_method/api_helper_methods.dart';
import 'package:api_handler/core/network/network_info.dart';

import '../../../../core/error/failure.dart';
import '../enums/header_enum.dart';
import '../enums/response_enum.dart';
import '../models/query_model.dart';
import '../models/response_model.dart';
import 'package:http/http.dart' as http;

abstract class RemoteDataApiFunc {
  static const int _tries = 3;
  static const int _timeout = 20;

  Future<ResponseModel> httpGet(
    String url,
    List<QueryModel> query,
    String? pathVariable,
    HeaderEnum headerType,
    ResponseEnum responseType,
  );

  Future<ResponseModel> httpDelete(
    String url,
    List<QueryModel> query,
    String? pathVariable,
    var body,
    HeaderEnum headerType,
    ResponseEnum responseType,
  );

  Future<ResponseModel> httpPost(
      String url,
      List<QueryModel> query,
      String? pathVariable,
      var body,
      HeaderEnum headerType,
      ResponseEnum responseType);

  Future<ResponseModel> httpPut(
    String url,
    List<QueryModel> query,
    String? pathVariable,
    var body,
    HeaderEnum headerType,
    ResponseEnum responseType,
  );
}

class RemoteDataApiFuncImpl extends RemoteDataApiFunc {
  @override
  Future<ResponseModel> httpDelete(
      String url,
      List<QueryModel>? query,
      String? pathVariable,
      body,
      HeaderEnum headerType,
      ResponseEnum responseType) async {
    int i = 0;
    ResponseModel responseModel = ResponseModel();
    while (i < RemoteDataApiFunc._tries) {
      try {
        var response = await http
            .delete(
              Uri.parse(ApiHelperMethodsImpl()
                  .urlGenerator(url, query, pathVariable)),
              headers: ApiHelperMethodsImpl().headerGetter(headerType),
              body: body,
            )
            .timeout(const Duration(seconds: RemoteDataApiFunc._timeout));
        responseModel =
            ApiHelperMethodsImpl().responseGetter(responseType, response);
      } catch (e) {
        ApiFailure(ResponseModel(message: e.toString()), url);

        NetworkInfoImpl networkInfo = NetworkInfoImpl();

        await networkInfo.isConnected.then((value) {
          if (value) {
            responseModel = ResponseModel(
                isSuccess: false,
                statusCode: "500",
                data: null,
                message: "خطایی در عملیات رخ داده است");
          } else {
            responseModel = ResponseModel(
                isSuccess: false,
                statusCode: "510",
                data: null,
                message: "لطفا اتصال به اینترنت را بررسی کنید.");
          }
        });
      }
      if (responseModel.statusCode == '200' ||
          responseModel.statusCode == 'success' ||
          responseModel.statusCode == '401') {
        return responseModel;
      }
      i++;
    }
    return responseModel;
  }

  @override
  Future<ResponseModel> httpGet(
      String url,
      List<QueryModel>? query,
      String? pathVariable,
      HeaderEnum headerType,
      ResponseEnum responseType) async {
    int i = 0;
    ResponseModel responseModel = ResponseModel();
    while (i < RemoteDataApiFunc._tries) {
      try {
        var response = await http
            .get(
              Uri.parse(ApiHelperMethodsImpl()
                  .urlGenerator(url, query, pathVariable)),
              headers: ApiHelperMethodsImpl().headerGetter(headerType),
            )
            .timeout(const Duration(seconds: RemoteDataApiFunc._timeout));
        responseModel =
            ApiHelperMethodsImpl().responseGetter(responseType, response);
      } catch (e) {
        ApiFailure(ResponseModel(message: e.toString()), url);

        NetworkInfoImpl networkInfo = NetworkInfoImpl();
        await networkInfo.isConnected.then((value) {
          if (value) {
            responseModel = ResponseModel(
                isSuccess: false,
                statusCode: "500",
                data: null,
                message: "خطایی در عملیات رخ داده است");
          } else {
            responseModel = ResponseModel(
                isSuccess: false,
                statusCode: "510",
                data: null,
                message: "لطفا اتصال به اینترنت را بررسی کنید.");
          }
        });
      }
      if (responseModel.statusCode == '200' ||
          responseModel.statusCode == 'success' ||
          responseModel.statusCode == '401') {
        return responseModel;
      }
      i++;
    }
    return responseModel;
  }

  @override
  Future<ResponseModel> httpPost(
      String url,
      List<QueryModel>? query,
      String? pathVariable,
      body,
      HeaderEnum headerType,
      ResponseEnum responseType) async {
    int i = 0;
    ResponseModel responseModel = ResponseModel();
    while (i < RemoteDataApiFunc._tries) {
      try {
        var response = await http
            .post(
              Uri.parse(ApiHelperMethodsImpl()
                  .urlGenerator(url, query, pathVariable)),
              headers: ApiHelperMethodsImpl().headerGetter(headerType),
              body: body,
            )
            .timeout(const Duration(seconds: RemoteDataApiFunc._timeout));
        responseModel =
            ApiHelperMethodsImpl().responseGetter(responseType, response);
      } catch (e) {
        ApiFailure(ResponseModel(message: e.toString()), url);

        NetworkInfoImpl networkInfo = NetworkInfoImpl();

        await networkInfo.isConnected.then((value) {
          if (value) {
            responseModel = ResponseModel(
                isSuccess: false,
                statusCode: "500",
                data: null,
                message: "خطایی در عملیات رخ داده است");
          } else {
            responseModel = ResponseModel(
                isSuccess: false,
                statusCode: "510",
                data: null,
                message: "لطفا اتصال به اینترنت را بررسی کنید.");
          }
        });
      }
      if (responseModel.statusCode == '200' ||
          responseModel.statusCode == 'success' ||
          responseModel.statusCode == '401') {
        return responseModel;
      }
      i++;
    }
    return responseModel;
  }

  @override
  Future<ResponseModel> httpPut(
      String url,
      List<QueryModel>? query,
      String? pathVariable,
      body,
      HeaderEnum headerType,
      ResponseEnum responseType) async {
    int i = 0;
    ResponseModel responseModel = ResponseModel();
    while (i < RemoteDataApiFunc._tries) {
      try {
        var response = await http
            .put(
              Uri.parse(ApiHelperMethodsImpl()
                  .urlGenerator(url, query, pathVariable)),
              headers: ApiHelperMethodsImpl().headerGetter(headerType),
              body: body,
            )
            .timeout(const Duration(seconds: RemoteDataApiFunc._timeout));
        responseModel =
            ApiHelperMethodsImpl().responseGetter(responseType, response);
      } catch (e) {
        ApiFailure(ResponseModel(message: e.toString()), url);

        NetworkInfoImpl networkInfo = NetworkInfoImpl();

        await networkInfo.isConnected.then((value) {
          if (value) {
            responseModel = ResponseModel(
                isSuccess: false,
                statusCode: "500",
                data: null,
                message: "خطایی در عملیات رخ داده است");
          } else {
            responseModel = ResponseModel(
                isSuccess: false,
                statusCode: "510",
                data: null,
                message: "لطفا اتصال به اینترنت را بررسی کنید.");
          }
        });
      }
      if (responseModel.statusCode == '200' ||
          responseModel.statusCode == 'success' ||
          responseModel.statusCode == '401') {
        return responseModel;
      }
      i++;
    }
    return responseModel;
  }
}
