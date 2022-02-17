class LocationItem {
  int timestamp;
  double? longitude;
  double? latitude;
  int? direction;
  int? accuracy;
  double? speed;
  int? batteryLevel;

  LocationItem(
      {required this.timestamp,
       });

  factory LocationItem.fromJson(Map<String, dynamic> json) {
    var locationItem =  LocationItem(
        timestamp: json['time'],
    );
    locationItem.syncDatafromJson(json);
    return locationItem;
  }

  Map<String, dynamic> toJson() {
    return {
      'time': timestamp,
      'lat': latitude,
      'lon': longitude,
      'lat': latitude,
      'dir': direction,
      'acc': accuracy,
      'speed': speed,
      'bat': batteryLevel,

    };
  }

  syncDatafromJson(Map<String, dynamic> json) {
    timestamp = json['time'] ?? timestamp;
    longitude = json['lon'] ?? longitude;
    latitude = json['lat'] ?? latitude;
    direction = json['dir'] ?? direction;
    accuracy = json['acc'] ?? accuracy;
    speed = json['speed'] ?? speed;
    batteryLevel = json['bat'] ?? batteryLevel;
  }
}
