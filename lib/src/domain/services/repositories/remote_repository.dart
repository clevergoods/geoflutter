import 'package:get_it/get_it.dart';
import 'package:true_flutter/src/domain/entities/user_profile.dart';
import 'package:true_flutter/src/domain/services/repositories/repository.dart';

import '../../../data/common/routes/remote_routes.dart';
import '../../../utils/common/repositories/dio_request_utils.dart';
import '../../../utils/common/system_log/flogger.dart';
import '../../entities/friend_profile.dart';

class RemoteRepository implements Repository {
  static const logTag = 'RemoteRepository';
  Flogger get logger => GetIt.instance.get<Flogger>();

  DioRequestUtils dioService = DioRequestUtils.instance;

  @override
  Future<UserProfile?> getUser(int? id) async {
    if (id != null) {
      var requestJson = <String, dynamic>{
        'sessid': id,
      };
      var responseJson =
          await dioService.jsonRequest(requestJson, RemoteRoutes.syncDataUrl);
      logger.onDebug(logTag, "sync data response $responseJson");
      logger.onDebug(logTag, "_syncData $responseJson");
      if (responseJson.toString().contains("AUTHREQ")) {
        return null;
      } else {
        return UserProfile.fromJson(responseJson);
      }
    }
  }

  @override
  Future<UserProfile?> storeUser(UserProfile? user) async {
    if (user != null) {
      var requestJson = <String, dynamic>{
        'platform': user.platform,
        'sessid': user.sessionid,
        'timezone': user.timezone,
      };
      if (user.features != null) {
        requestJson["features"] = user.features;
      }
      if (user.innerDeviceType != null) {
        requestJson["deviceType"] = user.innerDeviceType;
      }
      var responseJson =
          await dioService.jsonRequest(requestJson, RemoteRoutes.syncDataUrl);
      logger.onDebug(logTag, "sync data response $responseJson");
      if (responseJson != null) {
        logger.onDebug(logTag, "_syncData $responseJson");
        if (responseJson.toString().contains("AUTHREQ")) {
          return null;
        } else {
          user.syncDatafromJson(responseJson);
          return user;
        }
      }
    }
  }

  @override
  Future<List<FriendProfile>> getFriends() async{
    List<FriendProfile> userFriends = [];
    var requestJson = <String, dynamic>{"contacts": []};
    var responseJson =
    await dioService.jsonRequest(requestJson, RemoteRoutes.syncContactsUrl);
    logger.onDebug(logTag, "_syncContacts $responseJson");
    if(responseJson.containsKey("contacts")){
      for(var json in responseJson.entries){
        if(json.key.toString() == "contacts") {
          for(var json in json.value) {
            var friend = FriendProfile.fromJson(json);
            userFriends.add(friend);
            logger.onDebug(logTag, friend.name.toString());
          }
        }
      }
    }
    return userFriends;
  }

  @override
  Future<List<FriendProfile>?> storeFriends(List<FriendProfile> friends) async {
    return List.empty();
  }

  @override
  Future<void> closeRepository() async{
    dioService.closeClient();
  }
}
