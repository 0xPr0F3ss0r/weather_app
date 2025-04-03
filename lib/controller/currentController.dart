import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:weather_app/model/weather/current.dart';

class CurrentController extends GetxController {
  final Rx<Current?> currentData = Rx<Current?>(null);
  final RxString? timezone = "".obs;
  RxList<dynamic> temp = [].obs;
  List text = ['CLOUDY', 'WIND_SPEED', 'HUMIDITY'];
   // update data of Current class directly when they changed
  void updateCurrent(Current? data,String? data_timezone) {
    currentData.value = data;
    timezone!.value = data_timezone!;
    List<String> tempLocal = [currentData.value!.windSpeed.toString(),currentData.value!.humidity.toString(),currentData.value!.clouds.toString()];
    temp.value = tempLocal;
  }
}