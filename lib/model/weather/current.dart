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
}


