import 'Status.dart';

class ApiResponse<T> {
  Status? status;
  List<T>? data;
  String? message;

  ApiResponse(this.status, this.data, this.message);

  ApiResponse.loading() : status = Status.LOADING;

  ApiResponse.success(this.data) : status = Status.SUCCESS;

  ApiResponse.error(this.message) : status = Status.ERROR;

  @override
  String toString() {
    return "Status: $status \n Message: $message \n Data: $data";
  }
}

class ApiResponse2<T> {
  Status? status;
  T? data;
  String? message;

  ApiResponse2(this.status, this.data, this.message);

  ApiResponse2.loading() : status = Status.LOADING;

  ApiResponse2.success(this.data) : status = Status.SUCCESS;

  ApiResponse2.error(this.message) : status = Status.ERROR;

  @override
  String toString() {
    return "Status: $status \n Message: $message \n Data: $data";
  }
}
