import 'package:demoapp/Controllers/auth_controller.dart';
import 'package:demoapp/Helpers/Constants/constant.dart';
import 'package:demoapp/Helpers/Constants/constant_widget.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  State createState() => RegistrationScreenState();
}

class RegistrationScreenState extends State<RegistrationScreen> {
  var authController = Get.put(AuthController());

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: const Text('Registration'),
        ),
        body: Center(
          child: Container(
            padding: EdgeInsets.all(2.0.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CustomTextField(
                    hintText: 'Name',
                    controller: _nameController,
                    iconData: Icons.person),
                SizedBox(height: 20.0),
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
                      await _register();
                    },
                    btnText: 'REGISTER'),
              ],
            ),
          ),
        ));
  }

  bool _validateField() {
    if (_nameController.text.isEmpty) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: 'Please enter name'));
      return false;
    } else if (_emailController.text.isEmpty) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: 'Please enter email address'));
      return false;
    }
    if (_passwordController.text.isEmpty &&
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
        await authController.register({
          "name": _nameController.text,
          "email": _emailController.text,
          "password": _passwordController.text,
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
