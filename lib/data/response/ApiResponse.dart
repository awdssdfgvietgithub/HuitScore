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

// class ApiResponse3<T> {
//   Status? status;
//   List<T>? round1;
//   List<T>? round2;
//   List<T>? round3;
//   List<T>? round4;
//   List<T>? round5;
//   List<T>? round6;
//   List<T>? round7;
//   List<T>? round8;
//   List<T>? round9;
//   List<T>? round10;
//   List<T>? round11;
//   List<T>? round12;
//   List<T>? round13;
//   List<T>? round14;
//   List<T>? round15;
//   List<T>? round16;
//   List<T>? round17;
//   List<T>? round18;
//   List<T>? round19;
//   List<T>? round20;
//   List<T>? round21;
//   List<T>? round22;
//   List<T>? round23;
//   List<T>? round24;
//   List<T>? round25;
//   List<T>? round26;
//   List<T>? round27;
//   List<T>? round28;
//   List<T>? round29;
//   List<T>? round30;
//   List<T>? round31;
//   List<T>? round32;
//   List<T>? round33;
//   List<T>? round34;
//   List<T>? round35;
//   List<T>? round36;
//   List<T>? round37;
//   List<T>? round1;
//   List<T>? round1;
//   List<T>? round1;
//   List<T>? round1;
//   String? message;
//
//   ApiResponse3(this.status, this.data, this.message);
//
//   ApiResponse3.loading() : status = Status.LOADING;
//
//   ApiResponse3.success(this.data) : status = Status.SUCCESS;
//
//   ApiResponse3.error(this.message) : status = Status.ERROR;
//
//   @override
//   String toString() {
//     return "Status: $status \n Message: $message \n Data: $data";
//   }
// }
