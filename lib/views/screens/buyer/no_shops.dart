import 'package:dynamic_dukan/constants/colors.dart';
import 'package:flutter/material.dart';

class NoShops extends StatelessWidget {
  const NoShops({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Icon(
            Icons.warning_amber_sharp,
            size: 200,
            color: primaryColor,
          ),
        ),
        Center(
          child: Container(
            child: Text('Currently There are no shops near you'),
          ),
        ),
      ],
    ));
  }
}
