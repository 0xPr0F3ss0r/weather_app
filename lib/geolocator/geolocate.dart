import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class geolocator extends GetxController {
  //variables to get latitude and longitude of place
  final RxDouble _latitude = 0.0.obs;
  final RxDouble _longitude = 0.0.obs;
  //variable to check if data is ready or not
  final RxBool _isloading = true.obs;
  //function to get private latitude and longitude and is_loading variables data 
  RxDouble getlatitude() => _latitude;
  RxDouble getlongitude() => _longitude;
  RxBool getisloading() => _isloading;
  //function of live circle of application ,when page is start check if data is ready and also get position of place
  @override
  void onInit() {
    if (_isloading.value) {
      determinePosition();
    }
    super.onInit();
  }
  //function to get latitude and longitude from location service
  Future<void> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    // check if service is enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Geolocator.requestPermission();
      //return Future.error('Location services are disabled.');
    }
    //check permission to access the service
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high)
        .then((value) {
      _latitude.value = value.latitude;
      _longitude.value = value.longitude;
      _isloading.value = false;
    });
  }
}
