class Daily {
  final int? dt;
  final double? tempday;
  final int? humidity;
  final num? windSpeed;
  final int? clouds;
  final List? weather;

  Daily({ 
     this.dt,
     this.tempday,
     this.humidity,
     this.windSpeed,
     this.weather,
     this.clouds,
  });

  factory Daily.fromJson(Map<String, dynamic> json) {
    return Daily(
      dt: json['dt'],
      tempday: (json['temp']['day']).toDouble(),
      humidity: json['humidity'],
      windSpeed: json['wind_speed'],
      weather: (json['weather'] as List<dynamic>?),
      clouds: json['clouds'],
    );
  }
}