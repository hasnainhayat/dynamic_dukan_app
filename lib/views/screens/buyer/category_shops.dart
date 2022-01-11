import 'package:dynamic_dukan/controllers/category_controller.dart';
import 'package:dynamic_dukan/controllers/product_controller.dart';
import 'package:dynamic_dukan/controllers/shop_controller.dart';
import 'package:dynamic_dukan/views/screens/buyer/shopping_screen.dart';
import 'package:dynamic_dukan/views/widgets/nearbyshops_tile.dart';
import 'package:dynamic_dukan/views/widgets/toproducts_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CategoryShops extends StatelessWidget {
  CategoryShops({Key? key}) : super(key: key);
  // CategoryController _categoryController = Get.put(CategoryController());
  // ShopController shopController = Get.put(ShopController(), permanent: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: GetBuilder<ShopController>(builder: (shopController) {
        return Column(
          children: [
            SizedBox(
              height: Get.height - 100,
              child: Padding(
                padding: EdgeInsets.all(10.sp),
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, crossAxisSpacing: 4),
                    itemCount: shopController.nearbyShops.length,
                    itemBuilder: (context, index) {
                      return NearbyShops_Tile(
                        color: Color(0xffDFECF8),
                        action: () {
                          shopController
                              .selectShop(shopController.nearbyShops[index]);
                          Get.to(ShoppingScreen());
                        },
                        title: '${shopController.nearbyShops[index].shopName}',
                        assetPath: '${shopController.nearbyShops[index].image}',
                      );
                    }),
              ),
            )
          ],
        );
      }),
    );
  }
}
