import 'package:demoapp/Screens/dashboard.dart';
import 'package:demoapp/Screens/registration_screen.dart';
import 'package:demoapp/Screens/sign_in_screen.dart';
import 'package:get/get.dart' show GetPage, Transition;
import 'app_routes.dart';

const Transition transition = Transition.cupertino;

class AppPages {
  static const INITIAL = Routes.SIGNIN;

  static final routes = [
    GetPage(
        name: Routes.SIGNIN,
        page: () => SignInScreen(),
        transition: transition),
    GetPage(
        name: Routes.DASHBOARD,
        page: () => Dashboard(),
        transition: transition),
    GetPage(
        name: Routes.REGISTER,
        page: () => RegistrationScreen(),
        transition: transition),
  ];
}
