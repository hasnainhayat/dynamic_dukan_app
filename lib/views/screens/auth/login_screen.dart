import 'package:dynamic_dukan/constants/colors.dart';
import 'package:dynamic_dukan/controllers/auth_controller.dart';
import 'package:dynamic_dukan/controllers/validation_controller.dart';
import 'package:dynamic_dukan/views/screens/auth/register_screen.dart';
import 'package:dynamic_dukan/views/widgets/custom_button.dart';
import 'package:dynamic_dukan/views/widgets/custom_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatelessWidget {
  // LoginScreen({Key? key}) : super(key: key);
  AuthController _authController = Get.put(AuthController());
  ValidationController validationController = Get.put(ValidationController());
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
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
              Text('Dynamic  Dukan',
                  style: GoogleFonts.poppins(
                      fontSize: 32.sp, fontWeight: FontWeight.w700)),
              SizedBox(
                height: 26.h,
              ),
              Text('We Deliver fresh products on doorstep',
                  style: GoogleFonts.roboto(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: primaryColor)),
              SizedBox(
                height: 50.h,
              ),
              Text('Login',
                  style: GoogleFonts.poppins(
                    fontSize: 25.sp,
                    fontWeight: FontWeight.w700,
                  )),
              SizedBox(
                height: 30.h,
              ),
              Form(
                  key: loginFormKey,
                  child: Column(
                    children: [
                      CustomInputField(
                        labelText: 'Email',
                        validate: (value) =>
                            validationController.validateEmail(value),
                        textController: _authController.emailController,
                      ),
                      CustomInputField(
                        labelText: 'Password',
                        textController: _authController.passwordController,
                        validate: (value) =>
                            validationController.validatePassword(value),
                        isPassword: true,
                      ),
                      SizedBox(
                        height: 13.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('Don\'t have an account? ',
                              style: GoogleFonts.roboto(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                  color: secondaryColor)),
                          InkWell(
                            onTap: () => Get.to(() => RegisterScreen()),
                            child: Text('Register ',
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
                        height: 13.h,
                      ),
                      CustomButton(
                        btnLabel: 'Login',
                        action: () {
                          if (loginFormKey.currentState!.validate())
                            _authController.login();
                        },
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
