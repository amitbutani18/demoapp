import 'package:demoapp/Helpers/Constants/constant_widget.dart';
import 'package:get/get.dart';

class AppException implements Exception {
  final _message;
  final _prefix;
  AppException([this._message, this._prefix]);
  String toString() {
    Get.showSnackbar(Ui.ErrorSnackBar(message: _message));

    return "$_prefix$_message";
  }
}

class FetchDataException extends AppException {
  FetchDataException([String? message])
      : super(message, "Error During Communication: ");
}

class BadRequestException extends AppException {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}

class UnauthorisedException extends AppException {
  UnauthorisedException([message]) : super(message, "Unauthorised: ");
}

class InvalidInputException extends AppException {
  InvalidInputException([String? message]) : super(message, "Invalid Input: ");
}
