import 'package:flutter/cupertino.dart';

class BaseApiResponse<T> with ChangeNotifier {
  Status? status;
  String? message;
  T? data;

  BaseApiResponse(this.status, this.message, this.data);

// ! Named Constructors with initializer list
  BaseApiResponse.loading() : status = Status.loading;

  BaseApiResponse.completed(this.data) : status = Status.completed;

  BaseApiResponse.error(this.message) : status = Status.error;

  @override
  String toString() {
    return "status : $status\n message : $message\n data : $data ";
  }
}

enum Status { loading, completed, error, unAuthorized }
