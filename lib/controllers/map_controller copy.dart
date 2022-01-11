import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart' as loc;

class MapController extends GetxController {
  Set<Polyline> polylines = Set<Polyline>();
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();

  GoogleMapController? googleMapController;
  var initialCameraPosition = LatLng(33.56149689804258, 73.14651890297009);
  final Geolocator geolocator = Geolocator();
  String address = "...";
  List<Marker> markers = [];
  List<Marker> locationSpecificMarker = [];
  loc.Location location = loc.Location();
  // StreamSubscription _locationSubscription;
  // Location _locationTracker = Location();
  Marker? marker;
  Circle? circle;
  GoogleMapController? _controller;
  loc.LocationData? deviceLocation;
  setMarker(LatLng currentPostition) async {
    markers.clear();
    markers.add(Marker(
      markerId: const MarkerId('abc-123'),
      position: currentPostition,
    ));
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    Position? myPosition;
    if (permission != LocationPermission.denied) {
      myPosition = await Geolocator.getCurrentPosition();
    }
    List<Placemark> placemarks = await placemarkFromCoordinates(
        myPosition!.latitude, myPosition!.longitude);
    Placemark place = placemarks[0];
    String Address = '${place.locality}, ${place.country}';

    update();
  }

  getDeviceLocation() async {
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();

      if (!serviceEnabled) {
        return;
      }
    }

    loc.PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == loc.PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != loc.PermissionStatus.granted) {
        return;
      }
    }

    deviceLocation = await location.getLocation();
    initialCameraPosition =
        LatLng(deviceLocation!.latitude!, deviceLocation!.longitude!);

    location.onLocationChanged.listen((loc.LocationData currentLocation) {
      deviceLocation = currentLocation;
      initialCameraPosition =
          LatLng(deviceLocation!.latitude!, deviceLocation!.longitude!);
      // getLocationAddress();
      update();
    });
  }

  void updateMarkerAndCircle(
      loc.LocationData newLocalData, Uint8List imageData) {
    LatLng latlng = LatLng(newLocalData.latitude!, newLocalData.longitude!);

    marker = Marker(
        markerId: MarkerId("home"),
        position: latlng,
        rotation: newLocalData.heading!,
        draggable: false,
        zIndex: 2,
        flat: true,
        anchor: Offset(0.5, 0.5),
        icon: BitmapDescriptor.fromBytes(imageData));
    circle = Circle(
        circleId: CircleId("car"),
        radius: newLocalData.accuracy!,
        zIndex: 1,
        strokeColor: Colors.blue,
        center: latlng,
        fillColor: Colors.blue.withAlpha(70));
  }

  void setPolylines() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        "AIzaSyAaBv6mAmcwtxhzW9WDEJcc_11i6gGEQuI",
        PointLatLng(33.5662642, 73.1511891),
        PointLatLng(33.56267, 73.1481051));
    print(result.errorMessage);
    if (result.status == 'OK') {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });

      polylines.add(Polyline(
          width: 10,
          polylineId: PolylineId('polyLine'),
          color: Color(0xFF08A5CB),
          points: polylineCoordinates));
    }
    update();
  }
}
