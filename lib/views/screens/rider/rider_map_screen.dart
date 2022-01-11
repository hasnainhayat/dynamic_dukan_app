import 'package:dynamic_dukan/controllers/map_controller%20copy.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RiderMapScreen extends StatelessWidget {
  MapController mapController = Get.put(MapController());
  @override
  Widget build(BuildContext context) {
    mapController.setPolylines();
    // mapController.setPolylines();
    return GetBuilder<MapController>(
        init: MapController(),
        builder: (mapController) {
          return Scaffold(
              body: SafeArea(
            child: Container(
              height: Get.height,
              width: double.infinity,
              child: GoogleMap(
                polylines: mapController.polylines,
                minMaxZoomPreference: MinMaxZoomPreference(13, 17),
                myLocationButtonEnabled: true,
                onMapCreated: (controller) {
                  mapController.getDeviceLocation();

                  mapController.googleMapController = controller;
                  mapController.markers;
                },
                myLocationEnabled: true,
                markers: mapController.markers.toSet(),
                initialCameraPosition: CameraPosition(
                    target: mapController.initialCameraPosition, zoom: 10),
              ),
            ),
          ));
        });
  }
}
