import 'package:dynamic_dukan/controllers/auth_controller.dart';
import 'package:dynamic_dukan/controllers/category_controller.dart';
import 'package:dynamic_dukan/controllers/nearby_controller.dart';
import 'package:dynamic_dukan/controllers/product_controller.dart';
import 'package:dynamic_dukan/controllers/shop_controller.dart';
import 'package:dynamic_dukan/views/screens/buyer/category_shops.dart';
import 'package:dynamic_dukan/views/screens/buyer/no_shops.dart';
import 'package:dynamic_dukan/views/screens/buyer/shopping_cart.dart';
import 'package:dynamic_dukan/views/screens/buyer/shopping_screen.dart';
import 'package:dynamic_dukan/views/widgets/categories_tile.dart';
import 'package:dynamic_dukan/views/widgets/nav_drawer.dart';
import 'package:dynamic_dukan/views/widgets/nearbyshops_tile.dart';
import 'package:dynamic_dukan/views/widgets/toproducts_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';

class Buyer_Home extends StatefulWidget {
  Buyer_Home({Key? key}) : super(key: key);

  @override
  _Buyer_HomeState createState() => _Buyer_HomeState();
}

class _Buyer_HomeState extends State<Buyer_Home> {
  int selectedOptionIndex = 0;
  bool showDrawer = false;
  AuthController _authController = Get.put(AuthController());
  CategoryController categoryController =
      Get.put(CategoryController(), permanent: true);
  ShopController shopController = Get.put(ShopController(), permanent: true);
  NearbyController nearbyController =
      Get.put(NearbyController(), permanent: true);
  List topProductList = [
    TopProducts_Tile(
      color: Color(0xffDFECF8),
      title: 'kiwi',
      assetPath: 'images/kiwi.png',
      price: 'PKR 120',
    ),
    TopProducts_Tile(
      color: Color(0xffDFECF8),
      title: 'strawberry',
      assetPath: 'images/strawberry.png',
      price: 'PKR 600',
    ),
    TopProducts_Tile(
      color: Color(0xffDFECF8),
      title: 'apple',
      assetPath: 'images/apple.png',
      price: 'PKR 200',
    ),
    TopProducts_Tile(
      color: Color(0xffDFECF8),
      title: 'bread',
      assetPath: 'images/bread.png',
      price: 'PKR 70',
    ),
  ];
  List nearbyShopsList = [
    NearbyShops_Tile(
      color: Color(0xffDFECF8),
      title: 'Hasnain Store',
      assetPath: 'images/shop.png',
    ),
    NearbyShops_Tile(
      color: Color(0xffDFECF8),
      title: 'Feroz Mart',
      assetPath: 'images/shop.png',
    ),
    NearbyShops_Tile(
      color: Color(0xffDFECF8),
      title: 'Imran Store',
      assetPath: 'images/shop.png',
    ),
    NearbyShops_Tile(
      color: Color(0xffDFECF8),
      title: 'Ghazi Mart',
      assetPath: 'images/shop.png',
    ),
  ];
  ProductController _productController = Get.put(ProductController());
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      _productController.getAllProducts();
      categoryController.getAllCategories();
      await nearbyController.getNearByShops();
      if (nearbyController.nearbyShops.isEmpty) {
        Get.offAll(NoShops());
      }
    });
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();

    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        drawer: NavDrawer(),
        appBar: AppBar(
          backgroundColor: Colors.green,
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(Icons.menu),
            color: Colors.white,
            tooltip: 'Menu',
            onPressed: () {
              _scaffoldKey.currentState!.openDrawer();
            },
          ),
          actions: _buildActions(),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(top: 10),
            color: Colors.white,
            child: Column(
              children: [
                Center(
                  child: Image.asset('images/banner.png'),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Categories',
                              style: GoogleFonts.varelaRound(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                            ),
                            // FlatButton(
                            //   onPressed: () {},
                            //   child: Container(
                            //     padding: EdgeInsets.all(10),
                            //     decoration: BoxDecoration(
                            //       color: Color(0xffE0E6EE),
                            //       borderRadius: BorderRadius.only(
                            //         topLeft: Radius.circular(10),
                            //         topRight: Radius.circular(10),
                            //         bottomLeft: Radius.circular(10),
                            //       ),
                            //     ),
                            //     child: Text(
                            //       'Explore All',
                            //       style: GoogleFonts.varelaRound(
                            //         fontSize: 15,
                            //         fontWeight: FontWeight.w600,
                            //         color: Colors.grey[700],
                            //       ),
                            //     ),
                            //   ),
                            // )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GetBuilder<CategoryController>(
                          builder: (categoryController) {
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              for (var data in categoryController.categories)
                                InkWell(
                                  onTap: () async {
                                    // await shopController.getCategoryShops(data);
                                    categoryController.selectCategory(data);
                                    Get.to(CategoryShops());
                                  },
                                  child: Categories_Tiles(
                                    assetPath: 'images/bread.png',
                                    color: Color(0xffFCE8A8),
                                    title: '${data.name}',
                                  ),
                                ),
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.all(20.0),
                //   child: Column(
                //     children: [
                //       Container(
                //         width: MediaQuery.of(context).size.width,
                //         child: Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //           children: [
                //             Text(
                //               'Top Products',
                //               style: GoogleFonts.varelaRound(
                //                   fontSize: 20, fontWeight: FontWeight.w600),
                //             ),
                //             FlatButton(
                //               onPressed: () {},
                //               child: Container(
                //                 padding: EdgeInsets.all(10),
                //                 decoration: BoxDecoration(
                //                   color: Color(0xffE0E6EE),
                //                   borderRadius: BorderRadius.only(
                //                     topLeft: Radius.circular(10),
                //                     topRight: Radius.circular(10),
                //                     bottomLeft: Radius.circular(10),
                //                   ),
                //                 ),
                //                 child: Text(
                //                   'Explore All',
                //                   style: GoogleFonts.varelaRound(
                //                     fontSize: 15,
                //                     fontWeight: FontWeight.w600,
                //                     color: Colors.grey[700],
                //                   ),
                //                 ),
                //               ),
                //             )
                //           ],
                //         ),
                //       ),
                //       SizedBox(
                //         height: 20,
                //       ),
                //       Column(
                //         children: [
                //           GetBuilder<ProductController>(
                //               builder: (productController) {
                //             {
                //               return Container(
                //                 height: 200,
                //                 child: ListView.separated(
                //                     scrollDirection: Axis.horizontal,
                //                     itemBuilder: (context, index) {
                //                       productController.getShopName(
                //                           productController
                //                               .products[index].shopRef!);
                //                       return TopProducts_Tile(
                //                           color: Color(0xffDFECF8),
                //                           title: productController
                //                               .products[index].productName!,
                //                           assetPath: productController
                //                               .products[index].image
                //                               .toString(),
                //                           price: productController
                //                               .products[index].price!
                //                               .toString(),
                //                           product:
                //                               productController.products[index],
                //                           shopName: productController.shopName);
                //                     },
                //                     separatorBuilder: (context, index) =>
                //                         SizedBox(width: 20),
                //                     itemCount:
                //                         productController.products.length),
                //               );
                //             }
                //           })
                //         ],
                //       ),
                //     ],
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Nearby Shops',
                              style: GoogleFonts.varelaRound(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                            ),

                            // FlatButton(
                            //   onPressed: () {},
                            //   child: Container(
                            //     padding: EdgeInsets.all(10),
                            //     decoration: BoxDecoration(
                            //       color: Color(0xffE0E6EE),
                            //       borderRadius: BorderRadius.only(
                            //         topLeft: Radius.circular(10),
                            //         topRight: Radius.circular(10),
                            //         bottomLeft: Radius.circular(10),
                            //       ),
                            //     ),
                            //     child: Text(
                            //       'Explore All',
                            //       style: GoogleFonts.varelaRound(
                            //         fontSize: 15,
                            //         fontWeight: FontWeight.w600,
                            //         color: Colors.grey[700],
                            //       ),
                            //     ),
                            //   ),
                            // )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: [
                          GetBuilder<NearbyController>(
                              builder: (nearbyController) {
                            return nearbyController.isLoadind
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : nearbyController.nearbyShops.length > 0
                                    ? Container(
                                        height: 200,
                                        child: ListView.separated(
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context, index) =>
                                                NearbyShops_Tile(
                                                  color: Color(0xffDFECF8),
                                                  action: () {
                                                    shopController.selectShop(
                                                        nearbyController
                                                                .nearbyShops[
                                                            index]);
                                                    Get.to(ShoppingScreen());
                                                  },
                                                  title:
                                                      '${nearbyController.nearbyShops[index].shopName}',
                                                  assetPath:
                                                      '${nearbyController.nearbyShops[index].image}',
                                                ),
                                            separatorBuilder:
                                                (context, index) =>
                                                    SizedBox(width: 20),
                                            itemCount: nearbyController
                                                .nearbyShops.length),
                                      )
                                    : Center(
                                        child: Text('No shop in this area'));
                          })
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildActions() => <Widget>[
        IconButton(
          icon: Icon(Icons.shopping_bag_outlined),
          color: Colors.white,
          tooltip: 'Cart',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Shopping_Cart()),
            );
          },
        )
      ];
}
