import 'package:dynamic_dukan/constants/colors.dart';
import 'package:dynamic_dukan/controllers/auth_controller.dart';
import 'package:dynamic_dukan/controllers/category_controller.dart';
import 'package:dynamic_dukan/controllers/map_controller%20copy.dart';
import 'package:dynamic_dukan/controllers/shop_controller.dart';
import 'package:dynamic_dukan/models/category_model.dart';
import 'package:dynamic_dukan/views/screens/auth/register_screen.dart';
import 'package:dynamic_dukan/views/widgets/custom_button.dart';
import 'package:dynamic_dukan/views/widgets/custom_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CreateShopScreen extends StatelessWidget {
  ShopController _shopController = Get.put(ShopController());
  MapController mapController = Get.put(MapController());
  CategoryController categoryController = Get.put(CategoryController());
  @override
  Widget build(BuildContext context) {
    categoryController.getAllCategories();
    return Scaffold(body: Center(
      child: SafeArea(
        child: GetBuilder<ShopController>(builder: (shopController) {
          return SizedBox(
            height: Get.height,
            width: Get.width,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Create shop',
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
                            labelText: 'Shop Name',
                            textController: _shopController.shopNameController,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.black12)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: DropdownButton(
                                  isExpanded: true,
                                  underline: SizedBox(),
                                  value: shopController.categoryRef,
                                  onChanged: (var val) {
                                    shopController.categoryRef = val.toString();
                                    shopController.update();
                                  },
                                  items: [
                                    for (CategoryModel data
                                        in categoryController.categories)
                                      DropdownMenuItem(
                                          value: data.categoryRef!.toString(),
                                          child: Text(data.name!)),
                                  ]),
                            ),
                          ),
                          Container(
                            width: Get.width,
                            height: 160.h,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(
                                      3, 10), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Container(
                                  width: Get.width,
                                  height: 150.h,
                                  child: Stack(
                                    children: [
                                      GoogleMap(
                                        initialCameraPosition: CameraPosition(
                                          target:
                                              shopController.myLocation != null
                                                  ? mapController
                                                      .markers[0].position
                                                  : mapController
                                                      .initialCameraPosition,
                                          zoom: 15,
                                        ),
                                        mapType: MapType.normal,
                                        // rotateGesturesEnabled: true,
                                        // myLocationButtonEnabled: true,
                                        myLocationEnabled: false,
                                        // zoomGesturesEnabled: true,
                                        // zoomControlsEnabled: true,
                                        // compassEnabled: false,
                                        onMapCreated: (controller) {
                                          mapController.googleMapController =
                                              controller;
                                          mapController.markers;
                                          mapController.getDeviceLocation();
                                        },
                                        onTap: (coordinate) {
                                          shopController.mapVisibility = true;

                                          shopController.islocationChanged =
                                              true;
                                          shopController.update();
                                        },
                                        markers: mapController.markers.toSet(),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10.h),
                          shopController.shopImage == null
                              ? GestureDetector(
                                  onTap: () {
                                    shopController.imagePicker();
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
                                          offset: Offset(3,
                                              10), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    height: 200.h,
                                    width: double.maxFinite,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.image,
                                          size: 50.sp,
                                        ),
                                        Text(
                                          'Upload Shop Photo',
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.3),
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
                                            shopController.shopImage.toString(),
                                            fit: BoxFit.cover,
                                          )),
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        shopController.imagePicker();
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
                            btnLabel: 'CreateShop',
                            action: () {
                              _shopController.createShop();
                            },
                          ),
                        ],
                      ))
                    ],
                  ),
                  if (shopController.mapVisibility)
                    Container(
                      width: Get.width,
                      height: Get.height,
                      color: Colors.white,
                      child: Column(
                        children: [
                          Container(
                            width: Get.width,
                            height: Get.height - 200,
                            child: Stack(
                              children: [
                                GoogleMap(
                                  initialCameraPosition: CameraPosition(
                                    target: mapController.markers.length > 0
                                        ? mapController.markers[0].position
                                        : mapController.initialCameraPosition,
                                    zoom: 15,
                                  ),
                                  mapType: MapType.normal,
                                  // rotateGesturesEnabled: true,
                                  // myLocationButtonEnabled: true,
                                  myLocationEnabled: false,
                                  // zoomGesturesEnabled: true,
                                  // zoomControlsEnabled: true,
                                  // compassEnabled: false,
                                  onMapCreated: (controller) {
                                    mapController.googleMapController =
                                        controller;
                                    mapController.markers;
                                    mapController.getDeviceLocation();
                                  },
                                  onTap: (coordinate) {
                                    mapController.setMarker(coordinate);
                                    shopController.setcurrentAddress(
                                        mapController
                                            .markers[0].position.latitude,
                                        mapController
                                            .markers[0].position.longitude);

                                    shopController.islocationChanged = true;
                                    shopController.update();
                                  },
                                  markers: mapController.markers.toSet(),
                                ),
                              ],
                            ),
                          ),
                          Center(
                              child: SizedBox(
                            width: Get.width - 40,
                            child: Text(
                              shopController.currentAddress,
                              style: TextStyle(color: Colors.black),
                              maxLines: 2,
                            ),
                          )),
                          SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: Container(
                              width: Get.width - 100,
                              color: Color(0xff52a99a),
                              child: TextButton(
                                  onPressed: () => {
                                        shopController.myLocation =
                                            GeoFirePoint(
                                                mapController.markers[0]
                                                    .position.latitude,
                                                mapController.markers[0]
                                                    .position.longitude),
                                        shopController.mapVisibility = false,
                                        shopController.locationSelected = true,
                                        shopController.update()
                                      },
                                  child: Text(
                                    'Save Address',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    )
                ],
              ),
            ),
          );
        }),
      ),
    ));
  }
}
