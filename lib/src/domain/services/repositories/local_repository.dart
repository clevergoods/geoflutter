import 'package:get_it/get_it.dart';
import 'package:true_flutter/src/domain/entities/friend_profile.dart';
import 'package:true_flutter/src/domain/services/repositories/repository.dart';

import '../../../utils/common/repositories/objectbox_db_utils.dart';
import '../../entities/user_profile.dart';

class LocalRepository implements Repository{
  ObjectboxDBUtils get dBService => GetIt.instance.get<ObjectboxDBUtils>();

  @override
  Future<UserProfile?> getUser(int? id) async {
    return await dBService.getUser(id);
  }

  @override
  Future<UserProfile?> storeUser(UserProfile? user) async{
    if(user != null) {
      await dBService.storeUser(user);
      return await dBService.getUser(user.id);
    }else{
      return null;
    }
  }

  @override
  Future<List<FriendProfile>> getFriends() async{
    return dBService.getFriends();
  }

  @override
  Future<List<FriendProfile>?> storeFriends(List<FriendProfile> friends) async {
    List<FriendProfile> storedFriends = [];
    for(var friend in friends) {
      var storedFriend = await dBService.storeFriend(friend);
      if(storedFriend != null) storedFriends.add(storedFriend);
    }
    return storedFriends;
  }

  @override
  Future<void> closeRepository() async{
    await dBService.closeStore();
  }
}




