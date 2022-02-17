import 'dart:convert';
import 'dart:ffi';

import 'package:objectbox/objectbox.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:true_flutter/src/domain/entities/friend_profile.dart';
import 'package:true_flutter/src/domain/entities/subscription_item.dart';
import 'dart:math';
import '../../data/common/device/inner_device_type.dart';
import '../../data/common/routes/platform_name.dart';
import 'location_item.dart';

@Entity()
class UserProfile {
  int id = 0;
  int? sessionid;
  int? timezone;
  int? familyRelation;
  int? subscriptionData;
  bool? isSyncPurchasing;
  bool? features;
  bool? isWatch;
  String? login;
  int? password;
  String? phone;
  String? email;
  String? name;
  String? photoUrl;
  String? appVersion;
  String? platform;
// TODO init !!!
  String? innerDeviceType = InnerDeviceType.CONTACT.value;
  String? firebaseID;
  String? voipID;
  String? location; //json
  String? store;

//from syncdata
  // activate_trial: false,
  // subscr_exp_attr: 0,
  // subscr_seconds_left: 0,
  // subscr_exp: 0,
  // usdesk_company_id: 156532,
  // usdesk_channel_id: 7273,
  // push_enabled: true,
  // emailisconfirmed: false,
  // zendesk_account_key: 4Xm9AT0zzPcQBoKGE3cNlYzkC8PRCc5S,
  // creation_date: 30.11.2019 19:10:32,
  // creation_date_time: 1575141032,
  // sex: 1,
  // trackInterval: 60,
  // invis: false,
  // birthdate: 2019-12-13,
  // smtp: {smtp_sender: log@wokkalokka.ru, smtp_password: 2Kq8Z6HbPF, smtp_recipients: clevergoods@gmail.com, maxgenkin@wokkalokka.ru},
  // coord: {time: 1643017031, lon: 36.5876007080078, lat: 50.5794982910156, dir: 257, acc: 36, bat: 74},
  // bleNames: [{name: misstag}]
  //name: Wokka Lokka, email: wokkalokka.app@gmail.com, phone: 75805809999
  //familyrelation: 0

  UserProfile({
    this.login,
    this.password,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    var user = UserProfile(
      login: json['login'],
      password: json['pass'],
    );
    user.syncDatafromJson(json);
    return user;
  }

  syncDatafromJson(Map<String, dynamic> json) {
    location = json["coord"] != null ? jsonEncode(json["coord"]) : location;
    store = json["store"] != null ? jsonEncode(json["store"]) : store;
    login = json['login'] ?? login;
    password = json['pass'] ?? password;
    email = json['email'] ?? email;
    name = json['name'] ?? name;
    photoUrl = json['photoUrl'] ?? photoUrl;
    appVersion = json['appVersion'] ?? appVersion;
    phone = json['phone'] ?? phone;
    platform = json['platform'] ?? platform;
    sessionid = json['sessionid'] ?? sessionid;
    timezone = json['timezone'] ?? timezone;
    innerDeviceType = json['innerDeviceType'] ?? innerDeviceType;
    firebaseID = json['firebaseID'] ?? firebaseID;
    voipID = json['voipID'] ?? voipID;
    isSyncPurchasing = json['isSyncPurchasing'] ?? isSyncPurchasing;
    features = json['features'] ?? features;
    familyRelation = json['familyRelation'] ?? familyRelation;
    isWatch = json['isWatch'] ?? isWatch;
    subscriptionData = json['subscriptionData'] ?? subscriptionData;
  }

  List<SubscriptionItem>getSubscriptionList(){
    if(store != null) {
      List<SubscriptionItem> subscriptionList = <SubscriptionItem>[];
      for(dynamic val in jsonDecode(store!).toList()){
        subscriptionList.add(SubscriptionItem.fromJson(val));
      }
      return subscriptionList;
    }else{
      return List.empty();
    }
  }

  LocationItem? get getLocation {
    if (location != null) {
      var json = jsonDecode(location!);
      return LocationItem.fromJson(json);
    } else {
      return null;
    }
  }

  void initAppVersion() {
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      //String appName = packageInfo.appName;
      //String packageName = packageInfo.packageName;
      appVersion = packageInfo.version;
      //String buildNumber = packageInfo.buildNumber;
    });
  }

  void initPlatform() {
    platform = PlatformName.getName();
  }

  void initSessionid() {
    var now = DateTime.now();
    Random rnd = Random(now.millisecondsSinceEpoch);
    int min = 10000, max = 99999;
    sessionid = min + rnd.nextInt(max - min);
  }

  void initTimeZone() {
    timezone = DateTime.now().timeZoneOffset.inSeconds;
  }
}
