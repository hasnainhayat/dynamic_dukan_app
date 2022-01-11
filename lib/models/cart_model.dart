import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dynamic_dukan/controllers/auth_controller.dart';
import 'package:dynamic_dukan/controllers/shop_controller.dart';
import 'package:dynamic_dukan/models/product_model.dart';
import 'package:get/get.dart';

class CartModel {
  AuthController _authController = Get.put(AuthController());
  ShopController _shopController = Get.put(ShopController());
  CartModel(
      {this.product, this.userRef, this.shopRef, this.quantity, this.cartItem});

  factory CartModel.fromDocumentSnapshot(
          DocumentSnapshot doc, ProductModel item) =>
      CartModel(
          userRef: doc['userRef'],
          shopRef: doc['shopRef'],
          quantity: doc['quantity'],
          cartItem: item,
          product: doc['product']);

  Map<String, dynamic> toMap() => {
        'shopRef': shopRef,
        'userRef': _authController.currentUser!.userReference,
        'product': product,
        'quantity': quantity
      };
  DocumentReference? product;
  DocumentReference? userRef;
  DocumentReference? shopRef;
  int? quantity;
  ProductModel? cartItem;
}
