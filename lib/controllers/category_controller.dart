import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dynamic_dukan/models/category_model.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  List<CategoryModel> categories = [];
  getAllCategories() async {
    var snapshot =
        await FirebaseFirestore.instance.collection('categories').get();
    categories.clear();
    snapshot.docs.forEach((element) {
      categories.add(CategoryModel.fromDocumentSnapshot(element));
    });
    update();
  }
}
