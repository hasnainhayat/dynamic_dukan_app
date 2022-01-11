import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dynamic_dukan/controllers/auth_controller.dart';
import 'package:dynamic_dukan/models/cart_model.dart';
import 'package:dynamic_dukan/models/product_model.dart';
import 'package:dynamic_dukan/models/user_model.dart';
import 'package:dynamic_dukan/views/screens/vendor/vendor_home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  List<CartModel> cartItems = [];
  AuthController authController = Get.put(AuthController());
  int cartTotal = 0;
  int total = 0;

  addToCart(ProductModel product) async {
    CartModel cartItem = CartModel(product: product.productRef, shopRef: product.shopRef, quantity: 1);
    try {
      var doc = await authController.currentUser!.userReference! .collection('cart').doc(product.productRef!.id)
      .get();
      var snaps = await authController.currentUser!.userReference!.collection('cart').get();
      if (doc.exists) {
        authController.currentUser!.userReference!.collection('cart').doc(product.productRef!.id).update({'quantity': (doc.get('quantity') + 1)});
      } else {
        var check = await authController.currentUser!.userReference!.collection('cart').where('shopRef', isEqualTo: product.shopRef).get();
        if (!check.docs.isEmpty || snaps.size == 0) {
          authController.currentUser!.userReference!.collection('cart').doc(product.productRef!.id).set(cartItem.toMap());
        } else {
          return Get.defaultDialog(
              title: 'You have products from another shop?',
              content: Text('if you continue shopping your previous cart items will be removed'),
              onCancel: () => Get.back(),
              onConfirm: () async {
                snaps.docs.forEach((element) async {
                  await element.reference.delete();
                });
                await authController.currentUser!.userReference!.collection('cart').doc(product.productRef!.id).set(cartItem.toMap());
                Get.back();
              });
        }
      }
      Get.snackbar('Done', 'Product added to cart');
    } on Exception catch (e) {
      Get.snackbar('Failed', e.toString());
    }
  }

  getAllCartItems() async {
    cartItems.clear();
    authController.currentUser!.userReference!
        .collection('cart')
        .snapshots()
        .listen((event) {
      cartItems.clear();
      event.docs.forEach((element) async {
        var doc = await element.data()['product'].get();
        ProductModel newProduct = ProductModel.fromDocumentSnapshot(doc);

        cartTotal = 0;

        cartItems.add(CartModel.fromDocumentSnapshot(element, newProduct));
        update();
      });
    });
  }

  // calculateTotal(int price) {
  //   cartTotal = cartTotal + price;
  //   update();
  // }

  icreaseQuantity(ProductModel product) async {
    var doc = await authController.currentUser!.userReference!
        .collection('cart')
        .doc(product.productRef!.id)
        .get();
    await authController.currentUser!.userReference!
        .collection('cart')
        .doc(product.productRef!.id)
        .update({'quantity': (doc.get('quantity') + 1)});
  }

  decreaseQuantity(ProductModel product) async {
    var doc = await authController.currentUser!.userReference!
        .collection('cart')
        .doc(product.productRef!.id)
        .get();
    await authController.currentUser!.userReference!
        .collection('cart')
        .doc(product.productRef!.id)
        .update({'quantity': (doc.get('quantity') - 1)});
    if (doc.get('quantity') <= 1) {
      await authController.currentUser!.userReference!
          .collection('cart')
          .doc(product.productRef!.id)
          .delete();
      cartItems.clear();
      update();
    }
  }

  calculateTotal() {
    cartTotal = 0;
    total = 0;
    for (int i = 0; i < cartItems.length; i++) {
      cartTotal = cartTotal +
          (cartItems[i].cartItem!.price! * cartItems[i].quantity!).toInt();
    }
    if (cartTotal > 0) total = cartTotal + 60;
    update();
  }

  clearTextFields() {}
}
