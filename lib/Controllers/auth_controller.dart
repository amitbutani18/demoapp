import 'package:demoapp/Helpers/Constants/constant.dart';
import 'package:demoapp/Helpers/Routes/app_routes.dart';
import 'package:demoapp/Models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthController extends GetxController {
  var currentUser = UserViewModel().obs;

  @override
  void onInit() {
    super.onInit();
    // if (GetStorage().read(CURRENT_USER) != null) {
    //   setCurrentUser(isLogin: true);
    // }
  }

  Future<void> setCurrentUser({
    UserViewModel? user,
    bool? isLogin = false,
  }) async {
    GetStorage().write(CURRENT_USER, user!.toJson());
    // Get.log(GetStorage().read(C.currentUser).toString());

    currentUser.value = UserViewModel.fromJson(user.toJson());
    Get.offAllNamed(Routes.DASHBOARD);
  }

  signOut() async {
    var firebaseAuth = FirebaseAuth.instance;
    GetStorage().write(CURRENT_USER, null);
    await firebaseAuth.signOut();
    Get.offAllNamed(Routes.SIGNIN);
  }
}
