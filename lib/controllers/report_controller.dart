import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dynamic_dukan/controllers/order_controller.dart';
import 'package:dynamic_dukan/controllers/shop_controller.dart';
import 'package:dynamic_dukan/models/category_model.dart';
import 'package:dynamic_dukan/models/order_model.dart';
import 'package:dynamic_dukan/models/shop_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ReportController extends GetxController {
  int total = 0;
  int orders = 0;
  String previousDate = "";
  ShopController shopController = Get.put(ShopController());
  List<Map<String, dynamic>> reportDataList = [];
  generateReport() async {
    var snaps = await FirebaseFirestore.instance
        .collection('orders')
        .where('shopRef', isEqualTo: shopController.currentShop!.shopReference)
        .get();
    reportDataList.clear();
    snaps.docs.forEach((element) {
      OrderModel order = OrderModel.fromDocumentSnapshot(element);
      if (DateFormat('dd/MM/yyyy').format(order.date!.toDate()).toString() ==
          previousDate) {
        total += order.total!;
        orders += 1;
      } else {
        if (previousDate.length > 0) {
          reportDataList.add({
            'date': previousDate,
            'total': total,
            'orders': orders,
          });
        }
        orders = 1;
        total = order.total!;
        previousDate =
            DateFormat('dd/MM/yyyy').format(order.date!.toDate()).toString();
      }
    });
    print(reportDataList);
    update();
  }
}
