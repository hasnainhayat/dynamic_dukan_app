import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:dynamic_dukan/models/user_model.dart';
import 'package:dynamic_dukan/views/screens/auth/login_screen.dart';
import 'package:dynamic_dukan/views/screens/buyer/buyer_home.dart';
import 'package:dynamic_dukan/views/screens/vendor/create_shop_screen.dart';
import 'package:dynamic_dukan/views/screens/vendor/vendor_home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  var userCollection = FirebaseFirestore.instance.collection('users');
  UserModel? currentUser;
  var authUser = FirebaseAuth.instance.currentUser;
  String? userType;
  login() async {
    try {
      var authUser = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      await getUserdata();
      var shop = await FirebaseFirestore.instance
          .collection('shops')
          .doc(
              'shop-${currentUser != null ? currentUser!.userReference!.id : ''}')
          .get();
      if (currentUser != null) {
        if (currentUser!.userType == 'vendor') {
          if (!shop.exists) {
            Get.off(CreateShopScreen());
          } else {
            Get.off(VendorHomeScreen());
          }
        } else {
          Get.off(Buyer_Home());
        }
        clearTextFields();
      }
    } catch (e) {
      Get.snackbar('Login failed', e.toString());
    }
  }

  selectUserType(String type) {
    userType = type;
    update();
  }

  logOut() async {
    FirebaseAuth.instance.signOut();
    currentUser = null;
    Get.off(() => LoginScreen());
  }

  register() async {
    if (userType == null) {
      Get.snackbar('Error', 'Please select user type');
      return;
    }
    var authUser = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text, password: passwordController.text);
    UserModel newUser = UserModel(
        userName: userNameController.text,
        email: emailController.text,
        mobileNumber: mobileController.text,
        gender: 'male',
        userType: userType,
        address: '',
        image: '');
    try {
      await userCollection.doc(authUser.user!.uid).set(newUser.toMap());
      getUserdata();
      Get.snackbar('Registration Successfull', 'Account created successfully');
    } catch (e) {
      Get.snackbar('Registration Failed', 'Unable to create account');
    }

    clearTextFields();
  }

  getUserdata() async {
    var auth = FirebaseAuth.instance.currentUser;
    if (auth != null) {
      var doc = await userCollection.doc(auth.uid).get();
      currentUser = UserModel.fromDocumentSnapshot(doc);
      update();
    }
  }

  clearTextFields() {
    userNameController.clear();
    emailController.clear();
    passwordController.clear();
    mobileController.clear();
    typeController.clear();
    genderController.clear();
    addressController.clear();
    userType = null;
  }
}
