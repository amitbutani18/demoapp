import 'package:demoapp/API/API.dart';

class LocationFCMSuccessResponse {
  bool? status;
  String? msg;

  LocationFCMSuccessResponse({this.status, this.msg});

  LocationFCMSuccessResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    return data;
  }
}

class LocationRepository {
  ApiBaseHelper apiHelper = ApiBaseHelper();

  Future<LocationFCMSuccessResponse> setUserLocationApiCall(
      Map parameters) async {
    var apiResponse =
        await apiHelper.post("updateLocation", parameters, isShow: true);
    var response = new LocationFCMSuccessResponse.fromJson(apiResponse);
    print(response.msg);
    return response;
  }

  Future<LocationFCMSuccessResponse> setUserFCMTokenApiCall(
      Map parameters) async {
    var apiResponse =
        await apiHelper.post("fcmupdate", parameters, isShow: true);
    var response = new LocationFCMSuccessResponse.fromJson(apiResponse);
    print(response.msg);
    return response;
  }
}
