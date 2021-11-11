import 'package:demoapp/Helpers/Constants/constant.dart';
import 'package:demoapp/Helpers/Routes/app_routes.dart';
import 'package:demoapp/Models/user_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthController extends GetxController {
  var currentUser = User().obs;

  @override
  void onInit() {
    super.onInit();
    // if (GetStorage().read(CURRENT_USER) != null) {
    //   setCurrentUser(isLogin: true);
    // }
  }

  Future<void> signIn(Map parameter) async {
    AuthRepository authRepository = AuthRepository();
    var response = await authRepository.signInApiCall(parameter);
    await setCurrentUser(user: response.user);
    if (response.status == true) {
      Get.offAllNamed(Routes.DASHBOARD);
    }
  }

  Future<void> register(Map parameter) async {
    AuthRepository authRepository = AuthRepository();
    var response = await authRepository.registerApiCall(parameter);
    await setCurrentUser(user: response.user);
    if (response.status == true) {
      Get.offAllNamed(Routes.DASHBOARD);
    }
  }

  Future<void> setCurrentUser({User? user}) async {
    GetStorage().write(CURRENT_USER, user!.toJson());
    Get.log(GetStorage().read(CURRENT_USER).toString());

    currentUser.value = User.fromJson(user.toJson());
    print(currentUser.value.email);
  }

  Future<void> setUserLocation({User? user}) async {
    GetStorage().write(CURRENT_USER, user!.toJson());
    Get.log(GetStorage().read(CURRENT_USER).toString());

    currentUser.value = User.fromJson(user.toJson());
    print(currentUser.value.email);
  }

  signOut() async {
    GetStorage().write(CURRENT_USER, null);
    Get.offAllNamed(Routes.SIGNIN);
  }
}
