import 'package:dynamic_dukan/controllers/auth_controller.dart';
import 'package:dynamic_dukan/controllers/cart_controller.dart';
import 'package:dynamic_dukan/controllers/product_controller.dart';
import 'package:dynamic_dukan/models/product_model.dart';
import 'package:dynamic_dukan/views/screens/vendor/edit_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class TopProducts_Tile extends StatelessWidget {
  final Color color;
  final String title;
  final String assetPath;
  final String price;
  final String? shopName;

  final ProductModel? product;

  TopProducts_Tile(
      {Key? key,
      required this.color,
      required this.title,
      required this.assetPath,
      required this.price,
      this.product,
      this.shopName})
      : super(key: key);
  AuthController _authController = Get.put(AuthController());
  ProductController _productController = Get.put(ProductController());
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: this.color,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      height: 200.h,
      width: 150.w,
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  this.assetPath,
                  height: 80,
                  width: 80,
                ),
                Text(
                  this.title,
                  style: GoogleFonts.varelaRound(
                      fontSize: 15, fontWeight: FontWeight.w600),
                ),
                Text(
                  this.price,
                  style: GoogleFonts.varelaRound(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  this.assetPath,
                  height: 80,
                  width: 80,
                ),
                Text(
                  this.title,
                  style: GoogleFonts.varelaRound(
                      fontSize: 15, fontWeight: FontWeight.w600),
                ),
                Text(
                  this.price,
                  style: GoogleFonts.varelaRound(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey),
                ),
              ],
            ),
          ),
          Positioned(
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    child: _authController.currentUser!.userType == 'vendor'
                        ? IconButton(
                            onPressed: () => {
                                  _productController
                                      .deleteProduct(this.product!.productRef!)
                                },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ))
                        : FlatButton(
                            minWidth: 1,
                            child: Icon(Icons.add),
                            onPressed: () {
                              CartController().addToCart(product!);
                            },
                          ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
              child: _authController.currentUser!.userType == 'vendor'
                  ? IconButton(
                      onPressed: () => {
                            _productController.setSelectedProduct(product!),
                            Get.to(EditProductScreen())
                          },
                      icon: Icon(
                        Icons.edit,
                      ))
                  : FlatButton(
                      minWidth: 1,
                      child: Icon(Icons.favorite_border),
                      onPressed: () {},
                    ),
            ),
          ),
          if (shopName != null)
            Padding(
              padding: EdgeInsets.all(10.sp),
              child: Row(
                children: [
                  Icon(Icons.store),
                  Text(
                    shopName.toString(),
                    style: GoogleFonts.varelaRound(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
