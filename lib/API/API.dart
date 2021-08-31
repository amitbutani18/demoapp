import 'dart:io';
// import 'package:MyFirstApp/Widgets/custom_snackbar.dart';
import 'package:demoapp/Helpers/Constants/constant_widget.dart';
import 'package:demoapp/Helpers/Routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'api_exception.dart';
import 'dart:async';
import 'package:flutter_easyloading/flutter_easyloading.dart';

const String contentType = 'application/json';

class ApiBaseHelper {
  final String _baseUrl = "https://demoapp-cb0e2-default-rtdb.firebaseio.com/";

  Future<dynamic> get(String url) async {
    print('Api Get, url $url');
    var responseJson;
    try {
      showProgressIndicator();
      final response = await http.get(Uri.parse(_baseUrl + url));
      responseJson = _returnResponse(response);

      return responseJson;
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    } finally {
      EasyLoading.dismiss();
    }
  }

  Future<dynamic> post(String url, var parameters,
      {String objcontentType = contentType,
      bool isShow = false,
      bool isShowDialog = true}) async {
    print('Api Post, url $url');

    try {
      if (isShowDialog) EasyLoading.show(maskType: EasyLoadingMaskType.black);
      Map<String, String> header = {"Content-Type": objcontentType};
      print('header- ${header.toString()}');
      print('URL- ${_baseUrl + url}');
      print('Parameter - ${parameters.toString()}');
      final response =
          await http.post(Uri.parse(_baseUrl + url), body: parameters);
      printInfo(info: response.body);
      Map<dynamic, dynamic> map = _returnResponse(response);

      return map;
      // if (map['status'] == true) {
      // return map['data'];
      // } else {
      // if (isShow) errorSnackBar(content: map['msg']);
      // }
    } on SocketException {
      print('No net');
      Ui.ErrorSnackBar(message: 'No Internet');
      if (isShowDialog) EasyLoading.dismiss();
      throw FetchDataException('No Internet connection');
    }
  }

  dynamic _returnResponse(http.Response response, {bool isShow = false}) {
    EasyLoading.dismiss();
    printInfo(info: "Status Code" + response.statusCode.toString());
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body) as Map<String, dynamic>;
        print(responseJson);
        return responseJson;
      case 400:
        if (isShow)
          Get.showSnackbar(Ui.ErrorSnackBar(message: response.body.toString()));
        throw BadRequestException(response.body.toString());
      case 401:
        // errorSnackBar(content: response.body.toString());
        GetStorage().erase();
        Get.offAllNamed(Routes.DASHBOARD);
        throw BadRequestException(response.body.toString());
      case 403:
        print("Hello");
        Get.showSnackbar(Ui.ErrorSnackBar(message: response.body.toString()));
        Get.offAllNamed(Routes.DASHBOARD);
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        Get.snackbar("Server Error", "${response.statusCode}",
            backgroundColor: Colors.red.withOpacity(0.7));
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
