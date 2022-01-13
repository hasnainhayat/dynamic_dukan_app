import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dynamic_dukan/models/category_model.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  List<CategoryModel> categories = [];
  CategoryModel? selectedCategory;
  getAllCategories() async {
    var snapshot =
        await FirebaseFirestore.instance.collection('categories').get();
    categories.clear();
    snapshot.docs.forEach((element) {
      categories.add(CategoryModel.fromDocumentSnapshot(element));
    });
    update();
  }

  selectCategory(CategoryModel category) {
    String id = category.categoryRef!.id;
    DocumentReference categoryRef =
        FirebaseFirestore.instance.doc('categories/$id');
    selectedCategory = category;
    selectedCategory!.categoryRef = categoryRef;
    update();
  }
}
