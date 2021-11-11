import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'Helpers/Constants/constant.dart';
import 'Helpers/Routes/app_pages.dart';
import 'Helpers/Routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: GetStorage().read(CURRENT_USER) == null
          ? AppPages.INITIAL
          : Routes.DASHBOARD,
      getPages: AppPages.routes,
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      builder: EasyLoading.init(),
    );
  }
}
