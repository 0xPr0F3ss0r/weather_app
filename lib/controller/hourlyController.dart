import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/model/weather/hourly.dart';

class Hourlycontroller extends GetxController{
   //define variable to get data when it changed in real time
  final Rx<List<Hourly?>> hourly = Rx<List<Hourly?>>([]);
  //function to get data format as 'jm' like this 5am ,18pm
  String date(int dt){
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(dt * 1000);
      String formattedTime24 =  DateFormat('jm').format(dateTime);
      return formattedTime24;
  }
  // update data of hourly class directly when they changed with loop to get each value
  void updateHourly(List<Hourly?> data){
    for(int i=0;i<data.length;i++){
      hourly.value.add(data[i]);
    }
  }
}