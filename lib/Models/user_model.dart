import 'dart:convert';
import 'package:demoapp/API/API.dart';

class LoginResponse {
  bool? status;
  String? msg;
  User? user;

  LoginResponse({this.status, this.msg, this.user});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    user = json['data'] != null ? new User.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    if (this.user != null) {
      data['data'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  String? id;
  String? name;
  String? email;

  User({this.id, this.name, this.email});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    return data;
  }
}

class AuthRepository {
  ApiBaseHelper apiHelper = ApiBaseHelper();

  Future<LoginResponse> signInApiCall(Map parameters) async {
    var apiResponse = await apiHelper.post("login", parameters, isShow: true);
    var response = new LoginResponse.fromJson(apiResponse);
    print(response.msg);
    return response;
  }

  Future<LoginResponse> registerApiCall(Map parameters) async {
    var apiResponse =
        await apiHelper.post("register", parameters, isShow: true);
    var response = new LoginResponse.fromJson(apiResponse);
    print(response.msg);
    return response;
  }
}
