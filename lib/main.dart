import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dynamic_dukan/controllers/auth_controller.dart';
import 'package:dynamic_dukan/views/screens/auth/login_screen.dart';
import 'package:dynamic_dukan/views/screens/buyer/buyer_home.dart';
import 'package:dynamic_dukan/views/screens/buyer/order_success_screen.dart';
import 'package:dynamic_dukan/views/screens/buyer/track_order.dart';
import 'package:dynamic_dukan/views/screens/rider/rider_home_screen.dart';
import 'package:dynamic_dukan/views/screens/rider/rider_map_screen.dart';
import 'package:dynamic_dukan/views/screens/vendor/create_shop_screen.dart';
import 'package:dynamic_dukan/views/screens/vendor/new_orders.dart';
import 'package:dynamic_dukan/views/screens/vendor/vendor_home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

AuthController _authController = Get.put(AuthController());
var shop;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await _authController.getUserdata();
  shop = await FirebaseFirestore.instance
      .collection('shops')
      .doc(
          'shop-${_authController.currentUser != null ? _authController.currentUser!.userReference!.id : ''}')
      .get();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home:
          //  RiderMapScreen(),
          // // // Buyer_Home(),
          // // TrackOrder(),
          // // NewOrders(),
          landingpage(),
    );
  }
}

landingpage() {
  return ScreenUtilInit(
      designSize: Size(
        375,
        812,
      ),
      builder: () => _authController.currentUser != null
          ? _authController.currentUser!.userType == 'vendor'
              ? !shop.exists
                  ? CreateShopScreen()
                  : VendorHomeScreen()
              : Buyer_Home()
          : LoginScreen());
}
