import 'package:dynamic_dukan/constants/colors.dart';
import 'package:dynamic_dukan/controllers/auth_controller.dart';
import 'package:dynamic_dukan/controllers/product_controller.dart';
import 'package:dynamic_dukan/controllers/shop_controller.dart';
import 'package:dynamic_dukan/views/screens/auth/register_screen.dart';
import 'package:dynamic_dukan/views/widgets/custom_button.dart';
import 'package:dynamic_dukan/views/widgets/custom_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class EditProductScreen extends StatelessWidget {
  ProductController productController = Get.put(ProductController());
  @override
  Widget build(BuildContext context) {
    productController.productImage =
        productController.selectedProduct!.image.toString();
    productController.productNameController.value =
        TextEditingValue(text: productController.selectedProduct!.productName!);
    productController.descriptionController.value =
        TextEditingValue(text: productController.selectedProduct!.description!);
    productController.quantityController.value = TextEditingValue(
        text: productController.selectedProduct!.quantity.toString());
    productController.priceController.value = TextEditingValue(
        text: productController.selectedProduct!.price.toString()!);
    return Scaffold(body: Center(
      child: SafeArea(
        child: GetBuilder<ProductController>(builder: (productController) {
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Edit Product',
                    style: GoogleFonts.poppins(
                      fontSize: 25.sp,
                      fontWeight: FontWeight.w700,
                    )),
                SizedBox(
                  height: 30.h,
                ),
                Form(
                    child: Column(
                  children: [
                    CustomInputField(
                      labelText: 'Product Name',
                      textController: productController.productNameController,
                    ),
                    CustomInputField(
                      labelText: 'Quantity',
                      textController: productController.quantityController,
                    ),
                    CustomInputField(
                      labelText: 'Description',
                      textController: productController.descriptionController,
                    ),
                    CustomInputField(
                      labelText: 'Price',
                      textController: productController.priceController,
                    ),
                    SizedBox(height: 10.h),
                    productController.productImage == null
                        ? GestureDetector(
                            onTap: () {
                              productController.imagePicker();
                            },
                            behavior: HitTestBehavior.translucent,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    spreadRadius: 3,
                                    blurRadius: 7,
                                    offset: Offset(
                                        3, 10), // changes position of shadow
                                  ),
                                ],
                              ),
                              height: 200.h,
                              width: double.maxFinite,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.image,
                                    size: 50.sp,
                                  ),
                                  Text(
                                    'Upload Product Photo',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.3),
                                        spreadRadius: 3,
                                        blurRadius: 7,
                                        offset: Offset(10,
                                            3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  height: 150.h,
                                  width: double.maxFinite,
                                  child: Image.network(
                                    productController.productImage.toString(),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              GestureDetector(
                                onTap: () {
                                  productController.imagePicker();
                                },
                                behavior: HitTestBehavior.translucent,
                                child: Column(
                                  children: [
                                    Text(
                                      'Edit',
                                      style: GoogleFonts.poppins(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Icon(
                                      Icons.edit,
                                      color: Color(0xff52a99a),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                    SizedBox(
                      height: 13.h,
                    ),
                    CustomButton(
                      btnLabel: 'Update',
                      action: () {
                        productController.editProduct(
                            productController.selectedProduct!.productRef!);
                      },
                    ),
                  ],
                ))
              ],
            ),
          );
        }),
      ),
    ));
  }
}
