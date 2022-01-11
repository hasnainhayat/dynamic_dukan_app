import 'package:dynamic_dukan/views/screens/buyer/buyer_home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TrackOrder extends StatelessWidget {
  const TrackOrder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              'assets/pending.png',
              height: 200,
              width: 150,
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Text('Pening',
              style: TextStyle(
                  color: Colors.orangeAccent,
                  fontSize: 30,
                  fontWeight: FontWeight.bold)),
          SizedBox(height: 15),
          Text('Your order will be shipped soon'),
          SizedBox(
            height: 50,
          ),
          TextButton(
              onPressed: () {
                Get.offAll(Buyer_Home());
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  'Back To Home',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              )),
        ],
      ),
    ));
  }
}
