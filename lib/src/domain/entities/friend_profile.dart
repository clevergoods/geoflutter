import 'dart:convert';
import 'package:objectbox/objectbox.dart';

import 'location_item.dart';

@Entity()
class FriendProfile {
  int id = 0;
  String login;

  String? name;
  int? familyrelation;
  int? trackInterval;
  String? features;
  String? photo;
  String? avatar;
  String? phone;
  int? version;
  int? newversion;
  String? deviceType;
  String? platform;
  String? apilevel;
  String? location;//json

  FriendProfile({
    required this.login,
  });

  factory FriendProfile.fromJson(Map<String, dynamic> json) {
    var friend = FriendProfile(
      login: json['login'],
    );
    friend.syncDatafromJson(json);
    return friend;
  }

  syncDatafromJson(Map<String, dynamic> json) {
    location = json["time"] != null ? jsonEncode(LocationItem.fromJson(json).toJson()) : location;
    login = json['login'] ?? login;
    name = json['name'] ?? name;
    familyrelation = json['familyrelation'] ?? familyrelation;
    trackInterval = json['trackInterval'] ?? trackInterval;
    features = json['features'] ?? features;
    photo = json['photo'] ?? photo;
    avatar = json['avatar'] ?? avatar;
    phone = json['phone'] ?? phone;
    version = json['version'] ?? version;
    newversion = json['newversion'] ?? newversion;
    deviceType = json['deviceType'] ?? deviceType;
    platform = json['platform'] ?? platform;
    apilevel = json['apilevel'] ?? apilevel;
  }

  LocationItem? get getLocation {
    if (location != null) {
      var json = jsonDecode(location!);
      return LocationItem.fromJson(json);
    } else {
      return null;
    }
  }
}
