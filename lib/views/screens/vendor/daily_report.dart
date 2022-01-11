import 'package:dynamic_dukan/controllers/order_controller.dart';
import 'package:dynamic_dukan/controllers/report_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DailyReport extends StatelessWidget {
  DailyReport({Key? key}) : super(key: key);
  ReportController reportController = Get.put(ReportController());
  @override
  Widget build(BuildContext context) {
    reportController.generateReport();
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            GetBuilder<ReportController>(builder: (reportController) {
              return Table(
                border: TableBorder.symmetric(inside: BorderSide(width: 1)),
                children: [
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        'Date',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        'Orders',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        'Earning',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                  ]),
                  for (var data in reportController.reportDataList)
                    TableRow(children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          '${data["date"]}',
                          style: TextStyle(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          '${data["orders"]}',
                          style: TextStyle(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          '${data["total"]}',
                          style: TextStyle(),
                        ),
                      ),
                    ])
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
