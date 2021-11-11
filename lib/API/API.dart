import 'dart:io';
import 'package:demoapp/Helpers/Constants/constant_widget.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'api_exception.dart';
import 'dart:async';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ApiBaseHelper {
  final String _baseUrl = "https://smartclick4you.com/demo/v1/";

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

  Future<dynamic> post(String url, Map parameters,
      {bool isShow = false, bool isShowDialog = true}) async {
    print('Api Post, url $url');

    // try {
    if (isShowDialog) EasyLoading.show(maskType: EasyLoadingMaskType.black);
    Map<String, String> header = {
      'Authorization': 'Basic YWRtaW46MTIzNA==',
      "App-Secret-Key": "Mn2fKZG4M1170jDlVn6lOFTN6OE27f6UO99n9QDV",
      "Authorization-Token":
          "eyJ0eXA1iOi0JKV1QiL8CJhb5GciTWvLUzI1NiJ9IiRk2YXRh8Ig",
      "Content-Type": "application/x-www-form-urlencoded",
    };
    print('header- ${header.toString()}');
    print('URL- ${_baseUrl + url}');
    print('Parameter - ${parameters.toString()}');
    final response = await http.post(Uri.parse(_baseUrl + url),
        headers: header,
        encoding: Encoding.getByName("utf-8"),
        body: parameters);
    printInfo(info: response.body);
    Map<dynamic, dynamic> map = _returnResponse(response);

    // return map;
    if (map['status'] == true) {
      return map;
    } else {
      Get.showSnackbar(Ui.ErrorSnackBar(message: map['msg']));
    }
    // } on SocketException {
    //   print('No net');
    //   Ui.ErrorSnackBar(message: 'No Internet');
    //   if (isShowDialog) EasyLoading.dismiss();
    //   throw FetchDataException('No Internet connection');
    // } catch (e) {
    //   throw e;
    // }
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
        throw BadRequestException(json.decode(response.body)['msg']);
      case 401:
        GetStorage().erase();
        throw BadRequestException(json.decode(response.body)['msg']);
      case 403:
        print("Hello");
        throw UnauthorisedException(json.decode(response.body)['msg']);
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
