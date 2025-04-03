class Hourly {
  int? dt;
  double? temp;
  int? humidity;
  int? clouds;
  int? visibility;
  double? windSpeed;
  int? windDeg;
  double? windGust;
  List? weather;
  Hourly({
    this.dt,
    this.temp,
    this.humidity,
    this.clouds,
    this.visibility,
    this.windSpeed,
    this.windDeg,
    this.windGust,
    this.weather,
  });

  factory Hourly.fromJson(Map<String, dynamic> json) => Hourly(
        dt: json['dt'] as int?,
        temp: (json['temp'] as num?)?.toDouble(),
        humidity: json['humidity'] as int?,
        clouds: json['clouds'] as int?,
        visibility: json['visibility'] as int?,
        windSpeed: (json['wind_speed'] as num?)?.toDouble(),
        windDeg: json['wind_deg'] as int?,
        windGust: (json['wind_gust'] as num?)?.toDouble(),
        weather: (json['weather'] as List<dynamic>?)
      );

  Map<String, dynamic> toJson() => {
        'dt': dt,
        'temp': temp,
        'humidity': humidity,
        'clouds': clouds,
        'visibility': visibility,
        'wind_speed': windSpeed,
        'wind_deg': windDeg,
        'wind_gust': windGust,
        'weather': weather?.map((e) => e.toJson()).toList(),
      };
}
