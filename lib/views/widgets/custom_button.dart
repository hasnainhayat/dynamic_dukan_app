import 'package:dynamic_dukan/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  CustomButton({Key? key, required this.action, required this.btnLabel})
      : super(key: key);

  dynamic action;
  final String btnLabel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: action,
      child: Container(
        width: 358.w,
        padding: EdgeInsets.symmetric(vertical: 19.sp),
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(20.sp),
        ),
        child: Center(
          child: Text(
            btnLabel,
            style: GoogleFonts.roboto(
                color: Color(0xFFFCFCFC), fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }
}
