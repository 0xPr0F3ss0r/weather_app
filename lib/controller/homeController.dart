import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:weather_app/Service_API/http_service.dart';
import 'package:weather_app/controller/currentController.dart';
import 'package:weather_app/geolocator/geolocate.dart';
import 'package:weather_app/model/weather/current.dart';
import 'package:intl/intl.dart';
//import 'package:geocoding/geocoding.dart';

class HomeController extends GetxController {
  TextEditingController searchController = TextEditingController();
  HttpService service = Get.put(HttpService());
  CurrentController currentController = Get.put(CurrentController());
  Current current = Get.put(Current());
  RxString currentLocation = ''.obs;
  RxString DataToday = ''.obs;
  RxBool data_found = false.obs;
  RxBool data_seach_found = false.obs;
  RxBool is_loading = false.obs;
  RxBool search= false.obs;
  //initialize variable and get date of today and get data when app start
  @override
  void onInit() {
    data_found = false.obs;
    data_seach_found = false.obs;
    is_loading = false.obs;
    DateTime now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd');
    DataToday.value = formatter.format(now);
    currentLocation.value =
        currentController.timezone!.toString().replaceFirst(RegExp(r'/'), ',');
    GetStarted();
    super.onInit();
  }
//function work when user clik to search icon 
  void Search() {
    if (searchController.text.isNotEmpty) {
      is_loading.value= true;
      getCoordinatesFromPlaceName(searchController.text);
    }
  }
  //function to get latitude and longitude from placename
 Future<void> getCoordinatesFromPlaceName(String placeName) async {
        try {
          search.value= true;
          is_loading.value = true;
          List<Location> locations = await locationFromAddress(placeName);
          if (locations.isNotEmpty) {
            Location location = locations.first;
            service.requestdataFromPlace(location.latitude.toString(), location.longitude.toString());
          } else {
            is_loading.value = false;
          data_seach_found.value =false;
          data_found.value =false;
            return;
          }
        } catch (e) {
          is_loading.value = false;
          data_seach_found.value =false;
          data_found.value =false;
        }
      }
      //clear text search in home page
  @override
  void onClose() {
    search.value =false;
    searchController.dispose();
    super.onClose();
  }
  //function to start get weather data from latitude and longitude that we have
  void GetStarted() async {
    geolocator controller = Get.put(geolocator(), permanent: true);
    if (controller.getlatitude() == 0.0 && controller.getlongitude() == 0.0) {
      await controller.determinePosition();
    }
    HttpService servicehttp = Get.put(HttpService());
    servicehttp.requestdata();
  }
}
