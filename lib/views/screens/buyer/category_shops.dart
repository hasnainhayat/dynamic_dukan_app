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
  CategoryController _categoryController = Get.put(CategoryController());
  ShopController shopController = Get.put(ShopController(), permanent: true);
  @override
  Widget build(BuildContext context) {
    shopController.getAllShops();
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: GetBuilder<ShopController>(builder: (shopController) {
        print(_categoryController.selectedCategory!.categoryRef);
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
                      print(shopController.nearbyShops[0].category);
                      return Container(
                        child: (shopController.nearbyShops[index].category ==
                                _categoryController
                                    .selectedCategory!.categoryRef)
                            ? NearbyShops_Tile(
                                color: Color(0xffDFECF8),
                                action: () {
                                  shopController.selectShop(
                                      shopController.nearbyShops[index]);
                                  Get.to(ShoppingScreen());
                                },
                                title:
                                    '${shopController.nearbyShops[index].shopName}',
                                assetPath:
                                    '${shopController.nearbyShops[index].image}',
                              )
                            : SizedBox(),
                      );
                      print('${shopController.nearbyShops.length}');

                      // shopController.nearbyShops[index].category ==
                      //         _categoryController.selectedCategory!.categoryRef
                      //     ? NearbyShops_Tile(
                      //         color: Color(0xffDFECF8),
                      //         action: () {
                      //           shopController.selectShop(
                      //               shopController.nearbyShops[index]);
                      //           Get.to(ShoppingScreen());
                      //         },
                      //         title:
                      //             '${shopController.nearbyShops[index].shopName}',
                      //         assetPath:
                      //             '${shopController.nearbyShops[index].image}',
                      //       )
                      //     : SizedBox();
                    }),
              ),
            )
          ],
        );
      }),
    );
  }
}
