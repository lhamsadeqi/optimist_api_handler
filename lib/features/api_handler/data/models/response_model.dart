class ResponseModel {
  bool isSuccess;
  String statusCode;
  String message;
  dynamic data;

  ResponseModel({
    this.isSuccess = false,
    this.statusCode = "",
    this.message = "",
    this.data,
  });

  ResponseModel fromJson(dynamic json) {
    statusCode = json["statusCode"].toLowerCase().toString();
    data = json["data"];
    isSuccess = json["isSuccess"];
    message = json["message"].toString();

    return this;
  }
}


