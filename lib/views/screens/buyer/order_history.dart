import 'package:dynamic_dukan/controllers/order_controller.dart';
import 'package:dynamic_dukan/views/screens/buyer/order_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Order_Screen extends StatelessWidget {
  Order_Screen({Key? key}) : super(key: key);
  OrderController orderController = Get.put(OrderController());
  @override
  Widget build(BuildContext context) {
    orderController.getAllOrders();
    return GetBuilder<OrderController>(builder: (orderController) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Orders History'),
        ),
        body: Container(
          alignment: Alignment.topCenter,
          child: DataTable(
            columns: [
              DataColumn(
                label: Text('Shop'),
              ),
              DataColumn(
                label: Text('Bill'),
              ),
              DataColumn(
                label: Text(''),
              ),
            ],
            rows: [
              for (var order in orderController.orderList)
                DataRow(
                  cells: [
                    DataCell(
                      Text('${order.shopName}'),
                    ),
                    DataCell(
                      Text('${order.total}'),
                    ),
                    DataCell(
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Order_Details(),
                            ),
                          );
                        },
                        child: Text('View Details'),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      );
    });
  }
}
