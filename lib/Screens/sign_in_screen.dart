import 'package:demoapp/Controllers/auth_controller.dart';
import 'package:demoapp/Helpers/Constants/constant.dart';
import 'package:demoapp/Helpers/Constants/constant_widget.dart';
import 'package:demoapp/Helpers/Routes/app_routes.dart';
import 'package:demoapp/Models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class SignInScreen extends StatefulWidget {
  @override
  State createState() => SignInScreenState();
}

class SignInScreenState extends State<SignInScreen> {
  var authController = Get.put(AuthController());

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: const Text('Log In'),
        ),
        body: Center(
          child: Container(
            width: 500,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CustomTextField(
                    hintText: 'Email',
                    controller: _emailController,
                    iconData: Icons.email_outlined),
                SizedBox(height: 20.0),
                CustomTextField(
                    hintText: 'Password',
                    controller: _passwordController,
                    iconData: Icons.password_outlined,
                    obscureText: true),
                customTextButton(
                    onTap: () async {
                      // uploadImageToFirebase(context);
                      await _register();
                    },
                    btnText: 'Log In'),
                customTextButton(
                    onTap: () async {
                      Get.toNamed(Routes.REGISTER);
                    },
                    btnText: 'Registration'),
              ],
            ),
          ),
        ));
  }

  bool _validateField() {
    if (_emailController.text.isEmpty) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: 'Please enter email address'));
      return false;
    } else if (_passwordController.text.isEmpty &&
        _passwordController.text.length <= 6) {
      Get.showSnackbar(Ui.ErrorSnackBar(
          message: 'Password should be at least 6 characters'));
      return false;
    }
    return true;
  }

  Future<void> _register() async {
    FocusScope.of(context).unfocus();

    if (_validateField()) {
      try {
        showProgressIndicator();
        UserCredential authResult = await _auth.signInWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text);
        if (authResult.user != null) {
          var controller = Get.put(AuthController());
          await controller.setCurrentUser(
              user: UserViewModel(
                  email: authResult.user!.email, userId: authResult.user!.uid),
              isLogin: true);
          Get.offAllNamed(Routes.DASHBOARD);
        }
        return null;
      } on FirebaseAuthException catch (e) {
        Get.showSnackbar(Ui.ErrorSnackBar(message: e.message));
        EasyLoading.dismiss();
        print(e.message);
      } finally {
        EasyLoading.dismiss();
      }
    }
  }
}
