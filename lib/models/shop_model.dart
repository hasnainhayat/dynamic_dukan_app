import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dynamic_dukan/controllers/auth_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:get/get.dart';

class ShopModel {
  AuthController _authController = Get.put(AuthController());

  ShopModel(
      {this.shopName,
      this.vendorRef,
      this.image,
      this.shopReference,
      this.location,
      this.category});

  factory ShopModel.fromDocumentSnapshot(DocumentSnapshot doc) => ShopModel(
      shopName: doc['shopName'],
      image: doc['image'],
      shopReference: doc.reference,
      vendorRef: doc['vendorRef'],
      category: doc['category'],
      location: doc['location']);

  Map<String, dynamic> toMap() => {
        'image': image,
        'shopName': shopName,
        'vendorRef': _authController.currentUser!.userReference,
        'location': location,
        'category': category,
      };
  String? image;
  String? shopName;
  DocumentReference? vendorRef;
  DocumentReference? shopReference;
  DocumentReference? category;
  var location;
}
