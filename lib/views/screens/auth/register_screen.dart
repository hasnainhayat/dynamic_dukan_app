import 'package:dynamic_dukan/views/screens/auth/login_screen.dart';
import 'package:dynamic_dukan/views/widgets/custom_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Image.asset('assets/logo.png'),
              ),
              SizedBox(
                height: 18.h,
              ),
              Text('Dynamic Dukan',
                  style: GoogleFonts.poppins(
                      fontSize: 32.sp, fontWeight: FontWeight.w700)),
              SizedBox(
                height: 26.h,
              ),
              Text('We Deliver fresh products on doorstep',
                  style: GoogleFonts.roboto(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF6E7191))),
              SizedBox(
                height: 50.h,
              ),
              Text('Sign Up',
                  style: GoogleFonts.poppins(
                      fontSize: 24.sp, fontWeight: FontWeight.w700)),
              SizedBox(
                height: 30.h,
              ),
              Form(
                  child: Column(
                children: [
                  CustomInputField(labelText: 'Name'),
                  CustomInputField(labelText: 'Email'),
                  CustomInputField(labelText: 'Mobile'),
                  CustomInputField(
                    labelText: 'Password',
                    isPassword: true,
                  ),
                  SizedBox(
                    height: 13.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Already Have an Account? ',
                          style: GoogleFonts.roboto(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF6E7191))),
                      InkWell(
                        onTap: () => Get.back(),
                        child: Text('Login ',
                            style: GoogleFonts.roboto(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF3267E3))),
                      ),
                      SizedBox(
                        width: 20.w,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 14.h,
                  ),
                  InkWell(
                    onTap: () => {Get.snackbar('title', 'message')},
                    child: Container(
                      margin: EdgeInsets.only(bottom: 20),
                      width: 358.w,
                      padding: EdgeInsets.symmetric(vertical: 19.sp),
                      decoration: BoxDecoration(
                        color: Color(0xFF3267E3),
                        borderRadius: BorderRadius.circular(20.sp),
                      ),
                      child: Center(
                        child: Text(
                          'Sign up',
                          style: GoogleFonts.roboto(
                              color: Color(0xFFFCFCFC),
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ),
                ],
              ))
            ],
          ),
        ),
      ),
    ));
  }
}
