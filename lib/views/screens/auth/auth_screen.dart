import 'package:dynamic_dukan/views/screens/auth/login_screen.dart';
import 'package:dynamic_dukan/views/screens/auth/register_screen.dart';
import 'package:dynamic_dukan/views/screens/vendor/vendor_home_screen.dart';
import 'package:dynamic_dukan/views/widgets/tab_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

/// Flutter code sample for TabBar

// This sample shows the implementation of [TabBar] and [TabBarView] using a [DefaultTabController].
// Each [Tab] corresponds to a child of the [TabBarView] in the order they are written.

import 'package:flutter/material.dart';

/// This is the main application widget.

/// This is the stateless widget that the main application instantiates.
class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: SizedBox(
        height: Get.height,
        child: SingleChildScrollView(
          child: SizedBox(
            height: Get.height - 10,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                  height: 59.h,
                ),
                SizedBox(
                  child: AuthTab(),
                  height: 500.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: 
//   }
// }
