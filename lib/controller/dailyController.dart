import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/model/weather/daily.dart';

class Dailycontroller extends GetxController{
  final Rx<List<Daily?>?> daily = Rx<List<Daily?>?>(null);
  RxList<dynamic> weatherValues = [].obs;
   //get day name from dt that has type int
   String date(int dt){
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(dt * 1000);
      String formattedTime24 =  DateFormat('EEEE').format(dateTime);
      return formattedTime24;
  }
  // update data of Daily class directly when they changed
  void updateDaily(List<Daily?> data){
    daily.value = data;
      weatherValues.addAll([daily.value![0]!.windSpeed,daily.value![0]!.clouds,daily.value![0]!.humidity]);
  }

  
}