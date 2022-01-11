import 'package:dynamic_dukan/controllers/auth_controller.dart';
import 'package:dynamic_dukan/controllers/shop_controller.dart';
import 'package:dynamic_dukan/views/screens/vendor/add_product.dart';
import 'package:dynamic_dukan/views/screens/vendor/daily_report.dart';
import 'package:dynamic_dukan/views/screens/vendor/my_products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../constants/colors.dart';

class VendorHomeScreen extends StatelessWidget {
  VendorHomeScreen({Key? key}) : super(key: key);
  ShopController _shopController = Get.put(ShopController());
  AuthController _authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    _shopController.getShopData();
    return Scaffold(
      backgroundColor: textColor,
      body: SafeArea(
        child: GetBuilder<ShopController>(builder: (shopController) {
          return Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(.5), BlendMode.darken),
                        image: NetworkImage(
                            shopController.currentShop!.image.toString()))),
                padding: EdgeInsets.all(20.sp),
                height: 120.h,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          shopController.currentShop != null
                              ? shopController.currentShop!.shopName!
                              : 'Nill',
                          style: GoogleFonts.nunito(
                              fontSize: 30.sp,
                              fontWeight: FontWeight.bold,
                              color: primaryColor),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Text(
                          "We Deliver the best quality",
                          style: GoogleFonts.nunito(
                              fontSize: 15.sp, color: accentColor),
                        ),
                      ],
                    ),
                    IconButton(
                        onPressed: () => {_authController.logOut()},
                        icon: Icon(
                          Icons.logout,
                          color: primaryColor,
                          size: 35.sp,
                        )),
                  ],
                ),
              ),
              Container(
                height: 650.h,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.sp),
                        topRight: Radius.circular(30.sp))),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DashboardButton(
                          title: 'My Products',
                          icon: Icons.shop_2_outlined,
                          description: 'View Your Products',
                          action: () => Get.to(() => MyProducts()),
                        ),
                        DashboardButton(
                          title: 'Daily Report',
                          icon: Icons.shopping_bag,
                          description: 'View Your Products',
                          action: () => Get.to(DailyReport()),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DashboardButton(
                          title: 'Add Products',
                          icon: Icons.add_circle_outline,
                          description: 'Add new Product',
                          action: () => Get.to(AddProductScreen()),
                        ),
                        DashboardButton(
                          title: 'Orders',
                          icon: Icons.shopping_bag,
                          description: 'View Your Products',
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}

class DashboardButton extends StatelessWidget {
  DashboardButton(
      {Key? key, this.title, this.icon, this.description, this.action})
      : super(key: key);
  String? title;
  IconData? icon;
  String? description;
  dynamic action;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: action,
      child: Container(
        margin: EdgeInsets.all(15.sp),
        height: 140.sp,
        width: 140.sp,
        decoration: BoxDecoration(
            border: Border.all(color: primaryColor),
            borderRadius: BorderRadius.circular(15.sp)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              icon,
              color: primaryColor,
              size: 30.sp,
            ),
            Text(
              title!,
              style: GoogleFonts.nunito(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: primaryColor),
            ),
            Text(
              description!,
              style: GoogleFonts.nunito(fontSize: 15.sp, color: secondaryColor),
            )
          ],
        ),
      ),
    );
  }
}
