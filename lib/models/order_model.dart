import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dynamic_dukan/controllers/auth_controller.dart';
import 'package:get/get.dart';

class OrderModel {
  AuthController _authController = Get.put(AuthController());

  OrderModel(
      {this.shopName,
      this.shopReference,
      this.buyerRef,
      this.productRef,
      this.quantity,
      this.status,
      this.total,
      this.subTotal,
      this.date,
      this.itemTotal,
      this.deliveryCharges});

  factory OrderModel.fromDocumentSnapshot(DocumentSnapshot doc) => OrderModel(
        shopName: doc['shopName'],
        status: doc['status'],
        shopReference: doc['shopRef'],
        buyerRef: doc['buyerRef'],
        total: doc['total'],
        subTotal: doc['subTotal'],
        deliveryCharges: doc['deliveryCharges'],
        date: doc['date'],
      );
  factory OrderModel.fromDocumentSnapshotOrderItems(DocumentSnapshot doc) =>
      OrderModel(
        productRef: doc['productRef'],
        quantity: doc['quantity'],
        itemTotal: doc['itemTotal'],
      );
  Map<String, dynamic> toMap() => {
        'shopName': shopName,
        'status': status,
        'shopRef': shopReference,
        'total': total,
        'subTotal': subTotal,
        'deliveryCharges': deliveryCharges,
        'date': date,
        'buyerRef': _authController.currentUser!.userReference,
      };
  Map<String, dynamic> toMapOrderItems() => {
        'productRef': productRef,
        'quantity': quantity,
        'itemTotal': itemTotal,
      };
  String? image;
  String? shopName;
  DocumentReference? buyerRef;
  DocumentReference? shopReference;
  String? status;
  DocumentReference? productRef;
  int? quantity;
  int? itemTotal;
  int? deliveryCharges;
  int? subTotal;
  int? total;
  Timestamp? date;
}
