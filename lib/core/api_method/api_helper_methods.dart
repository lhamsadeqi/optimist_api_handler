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
      String url, List<QueryModel> query, String? pathVariable) {
    if (pathVariable != null) url += "/$pathVariable";
    var queryPart = generateQuery(query);

    return "$url$queryPart";
  }

  responseGetter<T>(ResponseEnum typeEnum, http.Response response) {
    if (response.statusCode != 200) {
      ApiFailure().call(
          ResponseModel(statusCode: response.statusCode.toString()),
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
              (result.statusCode != '200' && result.statusCode != 'success') ||
              result.data == null) {
            ApiFailure().call(
                ResponseModel(
                  statusCode: result.statusCode,
                  isSuccess: result.isSuccess,
                  data: result.data.toString(),
                  message: result.message,
                ),
                response.request!.url.path);
          }
          if (data.isEmpty) {
            printError('Url: ${response.request!.url.path}');
            printError('Data: $data');
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
      printError('Url: ${response.request!.url}');
      printError('StatusCode: ${response.statusCode}');
      printError('Error: ${e.toString()}');
      return ResponseModel(
          isSuccess: false,
          statusCode: response.statusCode.toString(),
          data: null,
          message: "خطایی در عملیات رخ داده است");
    }
  }

  void printError(String text) {
    debugPrint('\x1B[31m$text\x1B[0m');
  }
}
