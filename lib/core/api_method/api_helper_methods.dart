import 'dart:convert';

import 'package:api_handler/core/constants/api_consts.dart';
import 'package:api_handler/core/error/failure.dart';
import 'package:flutter/material.dart';
import '../../features/api_handler/data/enums/header_enum.dart';
import '../../features/api_handler/data/enums/response_enum.dart';
import '../../features/api_handler/data/models/query_model.dart';
import 'package:http/http.dart' as http;
import '../../features/api_handler/data/models/response_model.dart';

abstract class ApiHelperMethods {
  Map<String, String>? headerGetter(HeaderEnum typeEnum);

  String generateQuery(List<QueryModel> queries);

  String urlGenerator(String url, List<QueryModel> query, String? pathVariable);
}

class ApiHelperMethodsImpl implements ApiHelperMethods {
  @override
  Map<String, String>? headerGetter(HeaderEnum typeEnum) {
    switch (typeEnum) {
      case HeaderEnum.ImageHeaderEnum:
        return ApiConstants().imageHeader;
      case HeaderEnum.BearerHeaderEnum:
        return ApiConstants().bearerHeader;
      case HeaderEnum.FormDataHeaderEnum:
        return ApiConstants().formDataHeader;
      case HeaderEnum.BasicHeaderEnum:
        return ApiConstants().basicHeader;
      case HeaderEnum.EmptyHeaderEnum:
        return null;
      default:
        return ApiConstants().basicHeader;
    }
  }

  @override
  String generateQuery(List<QueryModel> queries) {
    String query = "";
    if (queries.isNotEmpty) {
      query += "?";
      for (var element in queries) {
        if (element.value != "null") {
          String? nm = element.name;
          String? vl = element.value;

          query += "$nm=$vl&";
        }
      }
    }

    return query;
  }

  @override
  String urlGenerator(
      String url, List<QueryModel>? query, String? pathVariable) {
    if (pathVariable != null) url += "/$pathVariable";
    if (query != null) url += generateQuery(query);

    return url;
  }

  responseGetter<T>(ResponseEnum typeEnum, http.Response response) {
    if (response.statusCode != 200) {
      ApiFailure(ResponseModel(statusCode: response.statusCode.toString()),
          response.request!.url.path);
    }
    try {
      switch (typeEnum) {
        case ResponseEnum.ResponseModelEnum:
          String data = utf8.decode(response.bodyBytes);
          ResponseModel result = ResponseModel().fromJson(
            json.decode(data),
          );
          if (!result.isSuccess ||
              (result.statusCode != '200' &&
                  result.statusCode.toLowerCase() != 'success') ||
              result.data == null) {
            ApiFailure(
                ResponseModel(
                  statusCode: result.statusCode,
                  isSuccess: result.isSuccess,
                  data: result.data,
                  message: result.message,
                ),
                response.request!.url.path);
          }
          if (data.isEmpty) {
            ApiFailure(
                ResponseModel(
                  data: data,
                ),
                response.request!.url.path);

            return ResponseModel(
                statusCode: response.statusCode.toString(),
                isSuccess: false,
                data: null,
                message: "مشکلی در ارتباط با سرور بوجود آمده است.");
          }

          return result;
        default:
          return response.bodyBytes;
      }
    } catch (e) {
      ApiFailure(
          ResponseModel(
              statusCode: response.statusCode.toString(),
              message: e.toString()),
          response.request!.url.path);

      return ResponseModel(
          isSuccess: false,
          statusCode: response.statusCode.toString(),
          data: null,
          message: "خطایی در عملیات رخ داده است");
    }
  }
}
