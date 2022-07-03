import 'package:flutter/material.dart';
import '../../features/api_handler/data/models/response_model.dart';

abstract class Failure<ResponseModel, String> {
  call(ResponseModel response, String path);

  printError(String text) {
    debugPrint('\x1B[31m$text\x1B[0m');
  }
}

// General failures
class ApiFailure extends Failure<ResponseModel, String> {
  @override
  call(response, path) {
    printError('Url: $path');
    printError('StatusCode: ${response.statusCode}');
    printError('IsStatus: ${response.isSuccess}');
    printError('Data: ${response.data.toString()}');
    printError('Message: ${response.message}');
  }
}

class CacheFailure extends Failure<ResponseModel, String> {
  @override
  call(response, path) {
    // TODO: implement call
    throw UnimplementedError();
  }
}
