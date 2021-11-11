import 'package:demoapp/Controllers/auth_controller.dart';
import 'package:demoapp/Helpers/Constants/constant.dart';
import 'package:demoapp/Helpers/Constants/constant_widget.dart';
import 'package:demoapp/Helpers/Routes/app_routes.dart';
import 'package:demoapp/Models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

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
            padding: EdgeInsets.all(2.0.h),
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
                SizedBox(height: 2.0.h),
                customTextButton(
                    onTap: () async {
                      // uploadImageToFirebase(context);
                      await _signiIn();
                    },
                    btnText: 'Log In'),
                customTextButton(
                    color: whiteColor,
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

  Future<void> _signiIn() async {
    FocusScope.of(context).unfocus();

    if (_validateField()) {
      try {
        showProgressIndicator();
        await authController.signIn({
          "email": _emailController.text,
          "password": _passwordController.text
        });
      } catch (e) {
        print(e);
        throw e;
      } finally {
        EasyLoading.dismiss();
      }
    }
  }
}
