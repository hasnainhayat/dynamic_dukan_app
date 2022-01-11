import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dynamic_dukan/controllers/auth_controller.dart';
import 'package:dynamic_dukan/controllers/cart_controller.dart';
import 'package:dynamic_dukan/controllers/shop_controller.dart';
import 'package:dynamic_dukan/models/cart_model.dart';
import 'package:dynamic_dukan/models/order_model.dart';
import 'package:dynamic_dukan/models/product_model.dart';
import 'package:dynamic_dukan/models/user_model.dart';
import 'package:dynamic_dukan/views/screens/vendor/vendor_home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  List<CartModel> cartItems = [];
  AuthController authController = Get.put(AuthController());
  CartController _cartController = Get.put(CartController());
  List<ProductModel> orderItems = [];
  placeOrder(List<CartModel> cartItems) async {
    var date = DateTime.now();

    cartItems.forEach((element) async {
      OrderModel order = OrderModel(
          date: Timestamp.now(),
          deliveryCharges: 60,
          shopReference: element.shopRef,
          buyerRef: element.userRef,
          subTotal: _cartController.cartTotal,
          total: _cartController.total);
      OrderModel orderItem = OrderModel(
          quantity: element.quantity,
          itemTotal:
              element.cartItem!.price!.toInt() * element.quantity!.toInt(),
          productRef: element.product);
      var doc = await FirebaseFirestore.instance
          .collection('orders')
          .doc(element.shopRef!.id + element.userRef!.id + date.toString())
          .get();
      if (!doc.exists) {
        await FirebaseFirestore.instance
            .collection('orders')
            .doc(element.shopRef!.id + element.userRef!.id + date.toString())
            .set(order.toMap());
        await FirebaseFirestore.instance
            .collection('orders')
            .doc(element.shopRef!.id + element.userRef!.id + date.toString())
            .collection('orderItems')
            .add(orderItem.toMapOrderItems());
      } else {
        await FirebaseFirestore.instance
            .collection('orders')
            .doc(element.shopRef!.id + element.userRef!.id + date.toString())
            .collection('orderItems')
            .add(orderItem.toMapOrderItems());
      }
    });
    var snaps = await authController.currentUser!.userReference!
        .collection('cart')
        .get();
    snaps.docs.forEach((element) async {
      await element.reference.delete();
    });
    CartController().cartItems.clear();
    CartController().update();
    cartItems.clear();
    update();
  }

  getOrderItems() async {
    cartItems.clear();
    FirebaseFirestore.instance
        .collection('orders')
        .where('userRef', isEqualTo: authController.currentUser!.userReference)
        .snapshots()
        .listen((event) {
      cartItems.clear();
      event.docs.forEach((element) async {
        var doc = await element.data()['product'].get();
        ProductModel newProduct = ProductModel.fromDocumentSnapshot(doc);

        cartItems.add(CartModel.fromDocumentSnapshot(element, newProduct));
        update();
      });
    });
  }

  getShopOrders() {
    FirebaseFirestore.instance.collection('orders').where('shopRef',
        isEqualTo: ShopController().currentShop!.shopReference);
  }

  clearTextFields() {}
}
