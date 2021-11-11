import 'package:dynamic_dukan/views/screens/auth/login_screen.dart';
import 'package:dynamic_dukan/views/screens/vendor/vendor_home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: landingpage(),
    );
  }
}

landingpage() {
  return ScreenUtilInit(
      designSize: Size(
        375,
        812,
      ),
      builder: () => const LoginScreen());
}
