import 'dart:math';

import 'package:demoapp/Controllers/auth_controller.dart';
import 'package:demoapp/Controllers/item_controller.dart';
import 'package:demoapp/Helpers/Constants/constant.dart';
import 'package:demoapp/Helpers/Constants/constant_widget.dart';
import 'package:demoapp/Models/item_model.dart';
import 'package:demoapp/Models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class Dashboard extends StatefulWidget {
  @override
  State createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {
  var authController = Get.put(AuthController());
  var itemController = Get.put(ItemController());

  var currentUser = UserViewModel().obs;

  @override
  void initState() {
    super.initState();
    if (GetStorage().read(CURRENT_USER) != null) {
      currentUser.value =
          UserViewModel.fromJson(GetStorage().read(CURRENT_USER));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Obx(() => Text(currentUser.value.email ?? '')),
        actions: [
          IconButton(
              onPressed: () => authController.signOut(),
              icon: Icon(Icons.logout))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        child: Icon(Icons.add),
        onPressed: () => _addItem(),
      ),
      body: ConstrainedBox(
          constraints: const BoxConstraints.expand(),
          child: Obx(() => ListView.builder(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, i) => Container(
                  margin: EdgeInsets.all(15),
                  padding: EdgeInsets.all(15),
                  decoration: customBoxDecoration(),
                  child: Center(
                      child: text(itemController.itemList[i].title!,
                          fontSize: 20.0)),
                ),
                itemCount: itemController.itemList.length,
              ))),
    );
  }

  _addItem() {
    ItemViewModel itemViewModel = ItemViewModel();
    itemViewModel.addItemApiCall(ItemModel(
            id: Random().nextInt(15000).toString(),
            title: Random().nextInt(15000).toString())
        .toJson());
    itemController.getItems();
  }
}
