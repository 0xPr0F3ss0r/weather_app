class Current {
  int? dt;
  double? temp;
  int? humidity;
  int? clouds;
  int? visibility;
  double? windSpeed;
  int? windDeg;
  List? weather;

  Current({
    this.dt,
    this.temp,
    this.humidity,
    this.clouds,
    this.visibility,
    this.windSpeed,
    this.windDeg,
    this.weather,
  });

  factory Current.fromJson(Map<String, dynamic> json) {
    // print("data before return constructor $json");
  return Current(
        dt: json['dt'] as int?,
        temp: (json['temp'] as num?)?.toDouble(),
        humidity: json['humidity'] as int?,
        clouds: json['clouds'] as int?,
        visibility: json['visibility'] as int?,
        windSpeed: (json['wind_speed'] as num?)?.toDouble(),
        windDeg: json['wind_deg'] as int?,
        weather: (json['weather'] as List<dynamic>?),
      );
  }

  Map<String, dynamic> toJson() => {
        'dt': dt,
        'temp': temp,
        'humidity': humidity,
        'clouds': clouds,
        'visibility': visibility,
        'wind_speed': windSpeed,
        'wind_deg': windDeg,
        'weather': weather?.map((e) => e.toJson()).toList(),
      };
}


// class weather{
//   // "id": 804,
//   //       "main": "Clouds",
//   //       "description": "overcast clouds",
//   //       "icon": "04d"
//   String? main;
//   String? description;
//   String? icon;
//   weather({this.description,this.icon,this.main});
//   factory weather.fromJson(List data_list) {
//     // print("data before return constructor $json");
//   return weather(
//        main : data_list[0]['main'],
//        description : data_list[0]['description'],
//        icon: data_list[0]['icon']
//       );
//   }
// }