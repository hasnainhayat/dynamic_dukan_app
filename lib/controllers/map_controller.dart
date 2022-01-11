// import 'dart:typed_data';
// import 'dart:ui' as ui;
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:location/location.dart' as loc;
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:geocoding/geocoding.dart';

// class MapController extends GetxController {
//   var initialCameraPosition = LatLng(33.56149689804258, 73.14651890297009);
//   late GoogleMapController googleMapController;
//   loc.Location location = loc.Location();
//   final Geolocator geolocator = Geolocator();
//   String address = "...";
//   late loc.LocationData deviceLocation;

//   // Map<PolylineId, Polyline> polylines = {};
//   // List<LatLng> polylineCoordinates = [];
//   // PolylinePoints polylinePoints = PolylinePoints();
//   // String googleApiKey = "AIzaSyDJnKHdTY5zVSzdE4P57YXl2X2NzMFnEEU";

//   final Set<Polyline> polyline = {};
//   PolylineResult? routeCoords;
//   String googleApiKey = "AIzaSyDSOwKZ3H47LtniMbrYerqIqqZNTZxjxjQ";
//   PolylinePoints polylinePoints = PolylinePoints();
//   List<LatLng> polylineCoordinates = [];

//   List<Marker> markers = [];
//   List<Marker> locationSpecificMarker = [];

//   @override
//   void onInit() {
//     super.onInit();
//   }

//   setMarker(LatLng currentPostition) {
//     markers.clear();
//     markers.add(Marker(
//       markerId: const MarkerId('abc-123'),
//       position: currentPostition,
//     ));
//   }

  // getDeviceLocation() async {
  //   bool serviceEnabled = await location.serviceEnabled();
  //   if (!serviceEnabled) {
  //     serviceEnabled = await location.requestService();
  //     if (!serviceEnabled) {
  //       return;
  //     }
  //   }

  //   loc.PermissionStatus permissionGranted = await location.hasPermission();
  //   if (permissionGranted == loc.PermissionStatus.denied) {
  //     permissionGranted = await location.requestPermission();
  //     if (permissionGranted != loc.PermissionStatus.granted) {
  //       return;
  //     }
  //   }

  //   deviceLocation = await location.getLocation();
  //   initialCameraPosition =
  //       LatLng(deviceLocation.latitude!, deviceLocation.longitude!);

  //   location.onLocationChanged.listen((loc.LocationData currentLocation) {
  //     deviceLocation = currentLocation;
  //     initialCameraPosition =
  //         LatLng(deviceLocation.latitude!, deviceLocation.longitude!);
  //     getLocationAddress();
  //     update();
  //   });
  // }

// //   void setCustomMapPin() async {
// //     final Uint8List ziyaratImage =
// //         await getBytesFromAsset('assets/images/mosque.png', 150);
// //     final Uint8List locationImage =
// //         await getBytesFromAsset('assets/images/location.png', 130);
// //     final Uint8List fooAndDrinksImage =
// //         await getBytesFromAsset('assets/images/restaurant.png', 130);
// //     final Uint8List restRoomImage =
// //         await getBytesFromAsset('assets/images/restroom.png', 130);
// //     final Uint8List emergencyImage =
// //         await getBytesFromAsset('assets/images/hospital.png', 130);

// //     ziyaratIcon = BitmapDescriptor.fromBytes(ziyaratImage);
// //     localPlace = BitmapDescriptor.fromBytes(locationImage);
// //     emergency = BitmapDescriptor.fromBytes(emergencyImage);
// //     restRoom = BitmapDescriptor.fromBytes(restRoomImage);
// //     foodAndDrinks = BitmapDescriptor.fromBytes(fooAndDrinksImage);
// //     update();
// //   }

//   getLocationAddress() async {
// // From coordinates
//     List<Placemark> placemarks = await placemarkFromCoordinates(
//         deviceLocation.latitude!, deviceLocation.longitude!);
//     Placemark place = placemarks[0];
//     String address =
//         'Street ${place.street}, ${place.subLocality}, ${place.locality}, ${place.country}';
//     update();
//   }

//   // getPoints(PlacesModel placesModel) async {
//   //   routeCoords = await polylinePoints.getRouteBetweenCoordinates(
//   //     googleApiKey,
//   //     PointLatLng(deviceLocation.latitude, deviceLocation.longitude),
//   //     PointLatLng(double.parse(placesModel.latitude),
//   //         double.parse(placesModel.longitude)),
//   //     travelMode: TravelMode.driving,
//   //   );
//   //   if (routeCoords!.points.isNotEmpty) {
//   //     routeCoords!.points.forEach((PointLatLng point) {
//   //       polylineCoordinates.add(LatLng(point.latitude, point.longitude));
//   //     });
//   //   }
//   //   placePolylines();
//   // }

//   placePolylines() {
//     polyline.add(
//       Polyline(
//         polylineId: PolylineId('route1'),
//         visible: true,
//         points: polylineCoordinates,
//         width: 4,
//         color: Colors.blue,
//         startCap: Cap.roundCap,
//         endCap: Cap.buttCap,
//       ),
//     );
//     update();
//   }

//   Future<Uint8List> getBytesFromAsset(String path, int width) async {
//     ByteData data = await rootBundle.load(path);
//     ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
//         targetWidth: width);
//     ui.FrameInfo fi = await codec.getNextFrame();
//     return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
//         .buffer
//         .asUint8List();
//   }
// }
