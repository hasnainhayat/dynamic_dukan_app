import 'package:dynamic_dukan/controllers/product_controller.dart';
import 'package:dynamic_dukan/views/widgets/toproducts_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MyProducts extends StatelessWidget {
  MyProducts({Key? key}) : super(key: key);
  ProductController _productController = Get.put(ProductController());
  @override
  Widget build(BuildContext context) {
    _productController.getMyProduct();
    return Scaffold(
      appBar: AppBar(
        title: Text('My Products'),
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
                        crossAxisCount: 2, crossAxisSpacing: 4),
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
