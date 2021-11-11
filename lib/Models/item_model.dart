import 'dart:convert' as js;

import 'package:demoapp/API/API.dart';
import 'package:demoapp/Helpers/Constants/constant.dart';
import 'package:demoapp/Models/user_model.dart';
import 'package:get_storage/get_storage.dart';

class ItemModel {
  String? title;
  String? id;

  ItemModel({this.title, this.id});

  ItemModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['id'] = this.id;
    return data;
  }
}

class ItemViewModel {
  ApiBaseHelper apiHelper = ApiBaseHelper();

  Future<ItemModel> addItemApiCall(Map parameters) async {
    var userId = UserViewModel.fromJson(GetStorage().read(CURRENT_USER)).userId;
    var json = await apiHelper
        .post("$userId/items.json", js.json.encode((parameters)), isShow: true);
    var response = new ItemModel.fromJson(json);
    print(response.title);
    return response;
  }

  Future<Map<String, dynamic>> getItemApiCall() async {
    var userId = UserViewModel.fromJson(GetStorage().read(CURRENT_USER)).userId;
    Map<String, dynamic> json = await apiHelper.get("$userId/items.json");
    // var response = new ItemModel.fromJson(json);
    print(json);
    return json;
  }
}
