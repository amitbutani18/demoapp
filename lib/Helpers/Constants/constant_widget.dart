import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constant.dart';

Text text(
  String content, {
  TextStyle? textStyle,
  Color? color = primaryColor,
  double? fontSize = 11,
  FontWeight? fontWeight = FontWeight.normal,
  double? letterSpacing = 0.0,
}) {
  return Text(content,
      style: GoogleFonts.poppins(
          color: color,
          fontSize: fontSize!,
          fontWeight: fontWeight,
          letterSpacing: letterSpacing!));
}

BoxDecoration customBoxDecoration(
    {Color color = whiteColor,
    bool isBoxShadow = true,
    double borderRadius = 20}) {
  return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(borderRadius),
      boxShadow: isBoxShadow
          ? [
              BoxShadow(
                  spreadRadius: 2,
                  offset: Offset(4, 4),
                  blurRadius: 10,
                  color: Colors.grey.withOpacity(0.2))
            ]
          : []);
}

customTextButton(
    {required Function onTap,
    required String btnText,
    double width = 130.0,
    double fontSize = 11.0,
    double height = 45.0,
    Color color = primaryColor}) {
  return GestureDetector(
    onTap: () => onTap(),
    child: Container(
      margin: EdgeInsets.symmetric(vertical: 5.6),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color,
          border:
              Border.all(color: color == whiteColor ? primaryColor : color)),
      height: height,
      width: width,
      child: text(btnText,
          color: color == primaryColor ? whiteColor : Colors.black,
          letterSpacing: 1.0,
          fontSize: fontSize,
          fontWeight: FontWeight.w500),
    ),
  );
}

InputDecoration getInputDecoration(
    {String hintText = '',
    String? errorText,
    IconData? iconData,
    Widget? suffixIcon,
    Widget? suffix}) {
  return InputDecoration(
    hintText: hintText,
    hintStyle: Get.textTheme.caption,
    prefixIcon: iconData != null
        ? Icon(iconData, color: Get.theme.focusColor).marginOnly(right: 14)
        : SizedBox(),
    prefixIconConstraints: iconData != null
        ? BoxConstraints.expand(width: 38, height: 38)
        : BoxConstraints.expand(width: 0, height: 0),
    floatingLabelBehavior: FloatingLabelBehavior.never,
    contentPadding: EdgeInsets.all(0),
    border: OutlineInputBorder(borderSide: BorderSide.none),
    focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
    enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
    suffixIcon: suffixIcon,
    suffix: suffix,
    errorText: errorText,
  );
}

class Ui {
  static GetBar ErrorSnackBar({String title = 'Error', String? message}) {
    Get.log("[$title] $message", isError: true);
    return GetBar(
      titleText: text(title.tr, color: whiteColor),
      messageText: text(message!, color: whiteColor),
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.all(20),
      backgroundColor: Colors.redAccent,
      icon: Icon(Icons.remove_circle_outline, size: 32, color: whiteColor),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      borderRadius: 8,
      duration: Duration(seconds: 5),
    );
  }
}

showProgressIndicator() {
  return EasyLoading.show(
      maskType: EasyLoadingMaskType.black, dismissOnTap: false);
}

class CustomTextField extends StatelessWidget {
  final String? lableText;
  final String? hintText;
  final IconData? iconData;
  final bool? isEnable;
  final bool obscureText;
  final TextEditingController? controller;
  const CustomTextField({
    Key? key,
    this.lableText,
    this.hintText,
    this.iconData,
    this.controller,
    this.isEnable = true,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: lableText == null ? 5 : 20,
          bottom: lableText == null ? 5 : 14,
          left: 20,
          right: 20),
      // margin: EdgeInsets.only(left: 0, right: 0, top: topMargin, bottom: bottomMargin),
      decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Get.theme.focusColor.withOpacity(0.1),
                blurRadius: 10,
                offset: Offset(0, 5)),
          ],
          border: Border.all(color: Get.theme.focusColor.withOpacity(0.05))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          lableText == null
              ? Container()
              : Text(
                  lableText!,
                  style: Get.textTheme.bodyText1,
                  textAlign: TextAlign.start,
                ),
          TextField(
              enabled: isEnable,
              obscureText: obscureText,
              controller: controller,
              decoration: getInputDecoration(
                hintText: hintText!,
                iconData: iconData,
              )),
        ],
      ),
    );
  }
}
