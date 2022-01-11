import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dynamic_dukan/controllers/auth_controller.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:get/get.dart';

class CategoryModel {
  AuthController _authController = Get.put(AuthController());

  CategoryModel({this.name, this.categoryRef});

  factory CategoryModel.fromDocumentSnapshot(DocumentSnapshot doc) =>
      CategoryModel(
        name: doc['name'],
        categoryRef: doc.reference,
      );

  Map<String, dynamic> toMap() => {
        'name': name,
      };

  String? name;
  DocumentReference? categoryRef;
}
