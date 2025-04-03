import 'dart:convert';
import 'package:get/get.dart';
import 'package:weather_app/Service_API/api_key.dart';
import 'package:weather_app/controller/currentController.dart';
import 'package:weather_app/controller/dailyController.dart';
import 'package:weather_app/controller/homeController.dart';
import 'package:weather_app/controller/hourlyController.dart';
import 'package:weather_app/geolocator/geolocate.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/model/weather/weather.dart';
class HttpService extends GetxController{
  final Rx<Weather?> weatherData = Rx<Weather?>(null);
  final homeController = Get.lazyPut(()=>HomeController);
  final currentController =  Get.put(CurrentController());
  final hourlyController = Get.put(Hourlycontroller());
  final dailyController = Get.put(Dailycontroller());
  Map<String,dynamic> dataresponse = {};
  // start the request and get the response
  void requestdata()async{
    Get.find<HomeController>().data_found.value =false;
    Get.find<HomeController>().is_loading.value = false;
    geolocator geocontroller = Get.put(geolocator());
    double latitude = geocontroller.getlatitude().value;
    double longitude = geocontroller.getlongitude().value; 
    String url = "https://api.openweathermap.org/data/3.0/onecall?lat=$latitude&lon=$longitude&appid=${ApiKey.apikey}&exclude=minutely&units=metric";
  // parse the url to uri format
    final MY_URL = Uri.parse(url);
    Get.find<HomeController>().is_loading.value = true;
    var response = await http.get(MY_URL);
    // is response is 200 so data is available and take them 
    if(response.statusCode == 200){
      dataresponse = jsonDecode(response.body);
      //get data from json format and put the value of this result to the constructor variable of weather class
      weatherData.value = Weather.fromJson(dataresponse);
      //get data of the current weather and put them to the variables of current class
      currentController.updateCurrent(weatherData.value!.current,weatherData.value!.timezone);
       //get data of the hourly weather  and put them to the variables of Hourly class
      hourlyController.updateHourly(weatherData.value!.hourly!);
       //get data of the daily weather hourly  and put them to the variables of Daily class
      dailyController.updateDaily(weatherData.value!.daily!);
      // change value of bool to stop loading indicator 
        Get.find<HomeController>().data_found.value =true;
        Get.find<HomeController>().is_loading.value = false;
      // if the response is not 200 ,give me an error
    }else{
      Get.find<HomeController>().is_loading.value = false;
      Get.find<HomeController>().data_found.value = false;
    }
  }
  void requestdataFromPlace(String mylatidude , String mylongitude)async{
    Get.find<HomeController>().is_loading.value = false;
    Get.find<HomeController>().data_seach_found.value =false;
    String url = "https://api.openweathermap.org/data/3.0/onecall?lat=$mylatidude&lon=$mylongitude&appid=${ApiKey.apikey}&exclude=minutely&units=metric";
  // parse the url to uri format
    final MY_URL = Uri.parse(url);
    var response = await http.get(MY_URL);
    //change value of search 
    //start loading 
    Get.find<HomeController>().is_loading.value = true;
    await Future.delayed(const Duration(seconds: 5));
    // is response is 200 so data is available and take them 
    if(response.statusCode == 200){
      dataresponse = jsonDecode(response.body);
      //get data from json format and put the value of this result to the constructor variable of weather class
      weatherData.value = Weather.fromJson(dataresponse);
      //get data of the current weather and put them to the variables of current class
      currentController.updateCurrent(weatherData.value!.current,weatherData.value!.timezone);
       //get data of the hourly weather  and put them to the variables of Hourly class
      hourlyController.updateHourly(weatherData.value!.hourly!);
       //get data of the daily weather hourly  and put them to the variables of Daily class
      dailyController.updateDaily(weatherData.value!.daily!);
      // change value of bool to stop loading indicator and tell us that there is data
      Get.find<HomeController>().is_loading.value = false;
      Get.find<HomeController>().data_seach_found.value =true;
      //Get.find<HomeController>().search.value = false;
      // if the response is not 200 ,give me an error
    }else{
      Get.find<HomeController>().is_loading.value = false;
      Get.find<HomeController>().data_seach_found.value =false;
    }
  }
}