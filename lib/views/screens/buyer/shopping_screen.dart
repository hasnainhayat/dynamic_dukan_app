import 'package:dynamic_dukan/controllers/product_controller.dart';
import 'package:dynamic_dukan/controllers/shop_controller.dart';
import 'package:dynamic_dukan/views/widgets/toproducts_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ShoppingScreen extends StatelessWidget {
  ShoppingScreen({Key? key}) : super(key: key);
  ProductController productController = Get.find();
  ShopController shopController = Get.find();
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      await productController.getShopProducts();
    });
    return Scaffold(
      appBar: AppBar(
        title: Text('${shopController.selectedShop!.shopName}'),
      ),
      body: GetBuilder<ProductController>(builder: (productController) {
        return Column(
          children: [
            SizedBox(
              height: Get.height - 100,
              child: Padding(
                padding: EdgeInsets.all(10.sp),
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 4,
                        mainAxisSpacing: 5),
                    itemCount: productController.products.length,
                    itemBuilder: (context, index) {
                      return TopProducts_Tile(
                          color: Color(0xffDFECF8),
                          title: productController.products[index].productName
                              .toString(),
                          assetPath: productController.products[index].image
                              .toString(),
                          product: productController.products[index],
                          price: productController.products[index].price
                              .toString());
                    }),
              ),
            )
          ],
        );
      }),
    );
  }
}
