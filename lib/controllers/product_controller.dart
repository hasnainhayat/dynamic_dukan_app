import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dynamic_dukan/controllers/shop_controller.dart';
import 'package:dynamic_dukan/models/product_model.dart';
import 'package:dynamic_dukan/models/user_model.dart';
import 'package:dynamic_dukan/views/screens/vendor/vendor_home_screen.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProductController extends GetxController {
  TextEditingController productNameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController measuringUnitController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String? productImage;
  String? shopName;
  ProductModel? selectedProduct;
  ShopController _shopController = Get.put(ShopController());
  List<ProductModel> products = [];
  addProduct() async {
    ProductModel newproduct = ProductModel(
        image: productImage,
        productName: productNameController.text,
        description: '',
        price: double.parse(priceController.text),
        quantity: int.parse(quantityController.text),
        measuringUnit: 'KG');
    try {
      await _shopController.currentShop!.shopReference!
          .collection('products')
          .add(newproduct.toMap());
      clearTextFields();
      Get.snackbar('Done', 'product Created Successfully');
      Get.off(() => VendorHomeScreen());
    } on Exception catch (e) {
      Get.snackbar('Failed', e.toString());
    }
  }

  getAllProducts() async {
    var shopsSnapshot =
        await FirebaseFirestore.instance.collection('shops').get();
    products.clear();

    shopsSnapshot.docs.forEach((element) async {
      var querySnapshot = await element.reference.collection('products').get();
      querySnapshot.docs.forEach((element) {
        products.add(ProductModel.fromDocumentSnapshot(element));
      });
      update();
    });
  }

  getShopName(DocumentReference shopRef) async {
    var doc = await shopRef.get();
    shopName = doc.get('shopName');
    update();
  }

  getShopProducts() async {
    products.clear();
    QuerySnapshot snaps = await _shopController.selectedShop!.shopReference!
        .collection('products')
        .get();

    products.clear();
    snaps.docs.forEach((element) {
      products.add(ProductModel.fromDocumentSnapshot(element));
    });

    update();
  }

  getMyProduct() {
    _shopController.currentShop!.shopReference!
        .collection('products')
        .snapshots()
        .listen((event) {
      products.clear();
      event.docs.forEach((element) {
        products.add(ProductModel.fromDocumentSnapshot(element));
      });

      update();
    });
  }

  editProduct(DocumentReference docRef) async {
    ProductModel newproduct = ProductModel(
        image: productImage,
        productName: productNameController.text,
        description: '',
        price: double.parse(priceController.text),
        quantity: int.parse(quantityController.text),
        measuringUnit: 'KG');

    try {
      await docRef.update(newproduct.toMap());
      Get.back();
      Get.snackbar('Updated', 'Product Updated Successfuly');
      clearTextFields();
    } on Exception catch (e) {
      Get.snackbar('Failed', e.toString());
    }
  }

  deleteProduct(DocumentReference docRef) async {
    try {
      await docRef.delete();
      Get.snackbar('Deleted', 'Product Deleted Successfully');
    } on Exception catch (e) {
      Get.snackbar('Failed', e.toString());
    }
  }

  setSelectedProduct(ProductModel product) {
    selectedProduct = product;
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

        productImage = downloadUrl;
        update();
      }).catchError((e) {
        print(e);
      });
    } else {
      // User canceled the picker
    }
  }

  clearTextFields() {
    productNameController.clear();
    priceController.clear();
    quantityController.clear();
    descriptionController.clear();
    productImage = null;
  }
}
