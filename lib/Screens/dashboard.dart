import 'dart:math';

import 'package:demoapp/Controllers/auth_controller.dart';
import 'package:demoapp/Helpers/Constants/constant.dart';
import 'package:demoapp/Helpers/Constants/constant_widget.dart';
import 'package:demoapp/Models/location_success_response.dart';
import 'package:demoapp/Models/user_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:share/share.dart';

class Dashboard extends StatefulWidget {
  @override
  State createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {
  var authController = Get.put(AuthController());
  var userLat = 0.0.obs;
  var userLng = 0.0.obs;
  @override
  void initState() {
    super.initState();
    if (GetStorage().read(CURRENT_USER) != null) {
      authController.setCurrentUser(
          user: User.fromJson(GetStorage().read(CURRENT_USER)));
      getUserLocation();
    }
  }

  getUserLocation() async {
    var position = await _determinePosition();
    userLat.value = position.latitude;
    userLng.value = position.longitude;
    String? token = await FirebaseMessaging.instance.getToken();
    print(token);
    LocationRepository locationRepository = LocationRepository();
    await locationRepository.setUserFCMTokenApiCall(
        {"user_id": authController.currentUser.value.id, "fcm_token": token});
    await locationRepository.setUserLocationApiCall({
      "user_id": authController.currentUser.value.id,
      "latitude": position.latitude.toString(),
      "logitude": position.longitude.toString()
    });
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: Text(''),
          actions: [
            IconButton(
                onPressed: () => authController.signOut(),
                icon: Icon(Icons.logout))
          ],
        ),
        body: Container(
          child: Center(
            child: customTextButton(
                onTap: () {
                  Share.share(
                      'https://www.google.com/maps/search/?api=1&query=$userLat,$userLng');
                },
                btnText: 'Share Location'),
          ),
        ));
  }
}
