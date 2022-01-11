import 'package:dynamic_dukan/views/screens/buyer/buyer_home.dart';
import 'package:dynamic_dukan/views/screens/buyer/track_order.dart';
import 'package:dynamic_dukan/views/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OrderSuccessScreen extends StatelessWidget {
  const OrderSuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(child: Image.asset('assets/success.png')),
            SizedBox(height: 50),
            Text(
              'Your Order has been placed successfully',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 50),
            TextButton(
                onPressed: () {
                  Get.to(TrackOrder());
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    'Track Order',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                )),
            TextButton(
                onPressed: () {
                  Get.offAll(Buyer_Home());
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  child: Text(
                    'Back To Home',
                    style: TextStyle(color: Colors.black),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
