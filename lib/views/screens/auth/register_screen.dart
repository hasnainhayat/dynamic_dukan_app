import 'package:dynamic_dukan/constants/colors.dart';
import 'package:dynamic_dukan/controllers/auth_controller.dart';
import 'package:dynamic_dukan/views/screens/auth/login_screen.dart';
import 'package:dynamic_dukan/views/widgets/custom_button.dart';
import 'package:dynamic_dukan/views/widgets/custom_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  AuthController _authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: GetBuilder<AuthController>(builder: (authController) {
            return Column(
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
                    CustomInputField(
                      labelText: 'Name',
                      textController: _authController.userNameController,
                    ),
                    CustomInputField(
                      labelText: 'Email',
                      textController: _authController.emailController,
                    ),
                    CustomInputField(
                        labelText: 'Mobile',
                        textController: _authController.mobileController),
                    Padding(
                      padding: EdgeInsets.all(10.sp),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'User Type:',
                            style: TextStyle(fontSize: 20.sp),
                          )),
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () => authController.selectUserType('buyer'),
                          child: Container(
                            padding: EdgeInsets.all(15.sp),
                            margin: EdgeInsets.symmetric(horizontal: 10.sp),
                            decoration: BoxDecoration(
                                color: authController.userType == 'buyer'
                                    ? primaryColor
                                    : Colors.transparent,
                                border: Border.all(color: primaryColor),
                                borderRadius: BorderRadius.circular(10)),
                            child: Text('Buyer'),
                          ),
                        ),
                        InkWell(
                          onTap: () => authController.selectUserType('vendor'),
                          child: Container(
                            padding: EdgeInsets.all(15.sp),
                            margin: EdgeInsets.symmetric(horizontal: 10.sp),
                            decoration: BoxDecoration(
                                color: authController.userType == 'vendor'
                                    ? primaryColor
                                    : Colors.transparent,
                                border: Border.all(color: primaryColor),
                                borderRadius: BorderRadius.circular(10)),
                            child: Text('Vendor'),
                          ),
                        ),
                        InkWell(
                          onTap: () => authController.selectUserType('rider'),
                          child: Container(
                            padding: EdgeInsets.all(15.sp),
                            margin: EdgeInsets.symmetric(horizontal: 10.sp),
                            decoration: BoxDecoration(
                                color: authController.userType == 'rider'
                                    ? primaryColor
                                    : Colors.transparent,
                                border: Border.all(color: primaryColor),
                                borderRadius: BorderRadius.circular(10)),
                            child: Text('Rider'),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 13.h,
                    ),
                    CustomInputField(
                      labelText: 'Password',
                      isPassword: true,
                      textController: _authController.passwordController,
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
                                color: secondaryColor)),
                        InkWell(
                          onTap: () => Get.back(),
                          child: Text('Login ',
                              style: GoogleFonts.roboto(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                  color: primaryColor)),
                        ),
                        SizedBox(
                          width: 20.w,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 14.h,
                    ),
                    CustomButton(
                        action: () => {_authController.register()},
                        btnLabel: 'Register'),
                  ],
                ))
              ],
            );
          }),
        ),
      ),
    ));
  }
}
