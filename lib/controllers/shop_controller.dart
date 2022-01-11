import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dynamic_dukan/controllers/LocationController.dart';
import 'package:dynamic_dukan/models/category_model.dart';
import 'package:dynamic_dukan/models/shop_model.dart';
import 'package:dynamic_dukan/models/user_model.dart';
import 'package:dynamic_dukan/views/screens/vendor/vendor_home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ShopController extends GetxController {
  TextEditingController shopNameController = TextEditingController();
  ShopModel? currentShop;
  String? categoryRef;
  bool locationSelected = false;
  bool mapVisibility = false;
  List<ShopModel> nearbyShops = [];
  GeoFirePoint? myLocation;
  String? shopImage;
  ShopModel? selectedShop;
  bool islocationChanged = false;
  String currentAddress = '';
  var shopCollection = FirebaseFirestore.instance.collection('shops');
  setcurrentAddress(double lat, double lng) async {
    currentAddress = await LocationController().getAddressFromLatLng(lat, lng);
    update();
  }

  Future getCategoryShops(CategoryModel category) async {
    var snapshot = await shopCollection
        .where('category', isEqualTo: category.categoryRef)
        .get();
    // nearbyShops.clear();
    snapshot.docs.forEach((element) {
      nearbyShops.add(ShopModel.fromDocumentSnapshot(element));
    });
    update();
  }

  createShop() async {
    DocumentReference docRef = FirebaseFirestore.instance.doc(categoryRef!);
    ;
    ShopModel newShop = ShopModel(
        image: '',
        shopName: shopNameController.text,
        location: myLocation!.data,
        category: docRef);
    try {
      await shopCollection
          .doc('shop-${FirebaseAuth.instance.currentUser!.uid}')
          .set(newShop.toMap());
      clearTextFields();
      Get.snackbar('Done', 'Shop Created Successfully');
      Get.off(() => VendorHomeScreen());
    } on Exception catch (e) {
      Get.snackbar('Failed', e.toString());
    }
  }

  getShopData() async {
    var doc = await shopCollection
        .doc('shop-${FirebaseAuth.instance.currentUser!.uid}')
        .get();
    currentShop = ShopModel.fromDocumentSnapshot(doc);

    update();
  }

  getAllShops() async {
    var snapshot = await shopCollection.get();
    nearbyShops.clear();
    snapshot.docs.forEach((element) {
      nearbyShops.add(ShopModel.fromDocumentSnapshot(element));
    });
    update();
  }

  selectShop(ShopModel shop) {
    selectedShop = shop;
    update();
  }

  imagePicker() async {
    final ImagePicker _picker = ImagePicker();
    // Pick an image
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      File uploadFile = File(image.path.toString());
      // Uint8List? uploadFile = result.files.single.bytes;

      String? fileName = image.name;

      Reference reference =
          FirebaseStorage.instance.ref('images').child(fileName);

      // print(reference);
      // print(uuid.v4());

      final UploadTask uploadTask = reference.putFile(uploadFile);
      // final UploadTask uploadTask = reference.putData(uploadFile);

      // if (uploadTask.snapshot.state == TaskState.success) {
      //   String downloadUrl = await uploadTask.snapshot.ref.getDownloadURL();
      //   print(downloadUrl);
      //   print('file uploaded');
      // } else {
      //   print("error");
      //

      uploadTask.whenComplete(() async {
        String downloadUrl = await uploadTask.snapshot.ref.getDownloadURL();
        // ignore: avoid_print
        print(downloadUrl + '   downloadurlsad');
        print('file uploaded');

        shopImage = downloadUrl;
        update();
      }).catchError((e) {
        print(e);
      });

      print(fileName);
    } else {
      // User canceled the picker
    }
  }

  clearTextFields() {
    shopNameController.clear();
  }
}
