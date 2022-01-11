import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewOrders extends StatelessWidget {
  const NewOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text('New Orders'),
        ),
        body: Container(
          child: Column(
            children: [
              Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Expanded(
                          child: Text(
                        'Name',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      )),
                      Expanded(
                          child: Text(
                        'Status',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      )),
                      Expanded(
                          child: Text(
                        'Total',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      )),
                      Expanded(
                        child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.download_done_sharp,
                              size: 30,
                              color: Colors.green,
                            )),
                      )
                    ],
                  )),
              Divider(height: 1, color: Colors.black)
            ],
          ),
        ));
  }
}
