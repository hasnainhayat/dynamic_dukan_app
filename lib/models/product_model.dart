import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dynamic_dukan/controllers/shop_controller.dart';
import 'package:get/get.dart';

class ProductModel {
  ShopController _shopController = Get.put(ShopController());

  ProductModel(
      {this.productName,
      this.shopRef,
      this.image,
      this.measuringUnit,
      this.description,
      this.price,
      this.quantity,
      this.productRef});

  factory ProductModel.fromDocumentSnapshot(DocumentSnapshot doc) =>
      ProductModel(
          productName: doc['productName'],
          image: doc['image'],
          shopRef: doc['shopRef'],
          measuringUnit: doc['measuringUnit'],
          price: doc['price'],
          description: doc['description'],
          quantity: doc['quantity'],
          productRef: doc.reference);

  Map<String, dynamic> toMap() => {
        'image': image,
        'productName': productName,
        'shopRef': _shopController.currentShop!.shopReference,
        'measuringUnit': measuringUnit,
        'description': description,
        'price': price,
        'quantity': quantity
      };
  String? image;
  String? productName;
  String? measuringUnit;
  double? price;
  String? description;
  DocumentReference? shopRef;
  int? quantity;
  DocumentReference? productRef;
}
