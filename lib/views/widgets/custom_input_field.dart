import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomInputField extends StatelessWidget {
  const CustomInputField({
    Key? key,
    this.isPassword,
    required this.labelText,
    required this.textController,
  }) : super(key: key);
  final bool? isPassword;
  final labelText;
  final textController;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 27.h),
      width: 358.w,
      decoration: BoxDecoration(
        color: Color(0xFFEFF0F7),
        borderRadius: BorderRadius.circular(16.sp),
      ),
      padding: EdgeInsets.only(left: 20.sp),
      child: TextFormField(
        obscureText: isPassword ?? false,
        controller: textController,
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: labelText,
        ),
      ),
    );
  }
}
