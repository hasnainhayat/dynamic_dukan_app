import 'package:dynamic_dukan/constants/colors.dart';
import 'package:dynamic_dukan/controllers/cart_controller.dart';
import 'package:dynamic_dukan/controllers/order_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  CartController _cartController = Get.put(CartController());
  OrderController _orderController = Get.put(OrderController());
  @override
  Widget build(BuildContext context) {
    _cartController.getAllCartItems();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'My Order',
            style: GoogleFonts.openSans(
              textStyle: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        body: GetBuilder<CartController>(builder: (cartController) {
          cartController.calculateTotal();
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16, right: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "My Order",
                              style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              "",
                              style: GoogleFonts.openSans(
                                  textStyle: TextStyle(
                                      color: Color(0xffa29aac),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                    height: 300.h,
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(bottom: 10.sp),
                          padding:
                              EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey[200],
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(20),
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  color: Color(0xffDFECF8),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Image.network(cartController
                                    .cartItems[index].cartItem!.image
                                    .toString()),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(right: 50),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 100,
                                        child: Text(
                                          cartController.cartItems[index]
                                              .cartItem!.productName
                                              .toString(),
                                          style: GoogleFonts.openSans(
                                            textStyle: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        children: [
                                          InkWell(
                                            onTap: () => cartController
                                                .decreaseQuantity(cartController
                                                    .cartItems[index]
                                                    .cartItem!),
                                            child: Container(
                                              width: 25,
                                              height: 25,
                                              decoration: BoxDecoration(
                                                color: Colors.grey[300],
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Icon(
                                                Icons.remove,
                                                size: 15,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8),
                                            child: Text(
                                              cartController
                                                  .cartItems[index].quantity
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () => cartController
                                                .icreaseQuantity(cartController
                                                    .cartItems[index]
                                                    .cartItem!),
                                            child: Container(
                                              width: 25,
                                              height: 25,
                                              decoration: BoxDecoration(
                                                color: Colors.grey[300],
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Icon(
                                                Icons.add,
                                                size: 15,
                                              ),
                                            ),
                                          ),
                                          Spacer(),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 15.sp,
                                      ),
                                      Text(
                                        'PKR ${(cartController.cartItems[index].cartItem!.price)! * cartController.cartItems[index].quantity!}',
                                        style: GoogleFonts.openSans(
                                            textStyle: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      itemCount: cartController.cartItems.length,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                    decoration: BoxDecoration(
                        color: Color(0xffDFECF8),
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Item Total',
                              style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(
                              'PKR ${cartController.cartTotal}',
                              style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Delivery Cost',
                              style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(
                              'PKR 60',
                              style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total',
                              style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(
                              'PKR ${cartController.total}',
                              style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Center(
                    child: FlatButton(
                      color: Color(0xff00c853),
                      child: Text(
                        'Confirm Order',
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                        ),
                      ),
                      // Within the `FirstRoute` widget
                      onPressed: () {
                        _orderController.placeOrder(_cartController.cartItems);
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
