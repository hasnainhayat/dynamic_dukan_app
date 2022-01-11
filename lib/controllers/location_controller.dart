// // ignore: file_names
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:get/get.dart';

// class LocationController extends GetxController {
//   var currentLat = 0.0.obs;
//   var currentLng = 0.0.obs;
//   RxString address = "".obs;

//   getCountryName(double? lat, double? lng) async {
//     List<Placemark> placemarks = await placemarkFromCoordinates(lat!, lng!);
//     Placemark place = placemarks[0];
//     String country = '${place.country}';
//     return country;
//   }

//   checkPosition() async {
//     bool serviceEnabled;
//     LocationPermission permission;
//     // Test if location services are enabled.
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       // Location services are not enabled don't continue
//       // accessing the position and request users of the
//       // App to enable the location services.
//       await Geolocator.openLocationSettings();
//       return Future.error('Location services are disabled.');
//     }
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         return Future.error('Location permissions are denied');
//       }
//     }
//     if (permission == LocationPermission.deniedForever) {
//       // Permissions are denied forever, handle appropriately.
//       return Future.error(
//           'Location permissions are permanently denied, we cannot request permissions.');
//     }
//     // When we reach here, permissions are granted and we can
//     // continue accessing the position of the device.

//     Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);
//     address.value =
//         await getAddressFromLatLng(position.latitude, position.longitude);
//     currentLat.value = position.latitude;
//     currentLng.value = position.longitude;
//     update();
//   }

//   // Future checkPosition() async {
//   //   print('here to check position');
//   //   Location location = new Location();
//   //
//   //   bool _serviceEnabled;
//   //   PermissionStatus _permissionGranted;
//   //
//   //   _serviceEnabled = await location.serviceEnabled();
//   //   if (!_serviceEnabled) {
//   //     _serviceEnabled = await location.requestService();
//   //     if (!_serviceEnabled) {
//   //       return;
//   //     }
//   //   }
//   //   _permissionGranted = await location.hasPermission();
//   //   if (_permissionGranted == PermissionStatus.denied) {
//   //     _permissionGranted = await location.requestPermission();
//   //     if (_permissionGranted != PermissionStatus.granted) {
//   //       return;
//   //     }
//   //   }
//   //   print('Service enabled $_serviceEnabled Permission $_permissionGranted');
//   //   await location.getLocation().then((value) async {
//   //     currentLat.value = value.latitude!;
//   //     currentLng.value = value.longitude!;
//   //
//   //     await getAddressFromLatLng(currentLat.value, currentLng.value)
//   //         .then((value) {
//   //       address.value = value;
//   //     });
//   //   });
//   //   return await location.getLocation();
//   // }

//   getAddressFromLatLng(double? lat, double? lng) async {
//     List<Placemark> placemarks = await placemarkFromCoordinates(lat!, lng!);
//     Placemark place = placemarks[0];
//     String Address = '${place.locality}, ${place.country}';

//     // print(lat);
//     // print(lng);
//     // String _host = 'https://maps.google.com/maps/api/geocode/json';
//     // final url =
//     //     'https://locationiq.com/v1/reverse.php?key=pk.5f775a4f0a9aade8c530c764a21a4aef&lat=$lat&lon=$lng&format=json';
//     // if (lat != null && lng != null) {
//     //   var response = await http.get(Uri.parse(url));
//     //   if (response.statusCode == 200) {
//     //     Map data = jsonDecode(response.body);
//     //     // log(response.body);
//     //     String _formattedAddress = "${data['address']['road']}"
//     //             ", ${data['address']['city']}" +
//     //         ", ${data['address']['state']}" +
//     //         ", ${data['address']['country']}";
//     //     print(_formattedAddress);
//     //     return _formattedAddress;
//     //   } else
//     //     return null;
//     // } else
//     //   return null;

//     return Address;
//   }

//   @override
//   void onInit() {
//     checkPosition();
//     // TODO: implement onInit
//     super.onInit();
//   }
// }
