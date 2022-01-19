import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class NetworkController extends GetxController {
  RxBool isConnected = false.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    final subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        isConnected.value = false;
        Get.defaultDialog(
          title: 'No Internet',
          content: Text('Please connect to wifi or mobile data'),
          onCancel: () => Get.back(),
        );
      } else {
        isConnected.value = true;
        Get.snackbar('connected', '');
      }
    });
  }
}
