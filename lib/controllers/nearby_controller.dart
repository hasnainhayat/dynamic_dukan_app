import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dynamic_dukan/controllers/LocationController.dart';
import 'package:dynamic_dukan/models/shop_model.dart';
import 'package:dynamic_dukan/views/screens/buyer/no_shops.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class NearbyController extends GetxController {
  LocationController _locationController = Get.put(LocationController());

  List<ShopModel> nearbyShops = [];

  getNearByShops() async {
    _locationController.checkPosition();
    QuerySnapshot snap = await FirebaseFirestore.instance
        .collection('shops')
        .where('shopStatus', isEqualTo: 'active')
        .get();

    nearbyShops.clear();
    Future.forEach(snap.docs, (DocumentSnapshot element) {
      if (element.get('location') != null) {
        double distance = (Geolocator.distanceBetween(
                _locationController.currentLat.value,
                _locationController.currentLng.value,
                element.get('location')['geopoint'].latitude,
                element.get('location')['geopoint'].longitude) /
            1000);

        if (distance <= 10) {
          print(element);
          nearbyShops.add(ShopModel.fromDocumentSnapshot(element));
        }
      }
    });

    update();
  }
}
