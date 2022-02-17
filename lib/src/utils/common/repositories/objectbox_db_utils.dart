import 'dart:io';
import 'package:get_it/get_it.dart';
import 'package:objectbox/objectbox.dart';
import 'package:path_provider/path_provider.dart';
import '../../../../objectbox.g.dart';
import '../../../domain/entities/friend_profile.dart';
import '../../../domain/entities/user_profile.dart';
import '../system_log/flogger.dart';

class ObjectboxDBUtils {
  static const logTag = 'ObjectboxDBUtils';
  Flogger get logger => GetIt.instance.get<Flogger>();

  initObjectbox() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    _store = await openStore(directory: appDocDir.path + 'objectbox');
    _userBox = _store.box<UserProfile>();
    _friendBox = _store.box<FriendProfile>();
  }

  late Store _store;
  late Box<UserProfile> _userBox;
  late Box<FriendProfile> _friendBox;

  Future<void> storeUser(UserProfile user) async {
    var existedUser = await getUser(user.id);
    if (existedUser == null) {
      _userBox.put(user);
    } else {
      existedUser = user;
      _userBox.put(existedUser);
    }
  }

  Future<FriendProfile?> storeFriend(FriendProfile friend) async {
    var existedFriend = await getFriend(friend.login);
    if (existedFriend == null) {
      _friendBox.put(friend);
    } else {
      existedFriend = friend;
      _friendBox.put(existedFriend);
    }
    return await getFriend(friend.login);
  }

  Future<FriendProfile?> getFriend(String? login) async {
    if(login != null) {
      Query<FriendProfile> query = _friendBox.query(
          FriendProfile_.login.equals(login)).build();
      List<FriendProfile> friends = query.find();
      query.close();
      return friends.isNotEmpty ? friends.first : null;
    } else {
      return null;
    }
  }

  Future<List<FriendProfile>> getFriends() async{
    var friends = _friendBox.getAll();
    logger.onDebug(logTag, "friends count = ${friends.length}");
    return friends;
  }

  Future<UserProfile?> getUser(int? id) async {
    final users = _userBox.getAll();
    if (users.isNotEmpty) {
      logger.onDebug(logTag, "users count = ${users.length}");
      return users.first;
    } else {
      return null;
    }
  }

  closeStore() async {
    if (_store.awaitAsyncCompletion()) {
      _store.close();
    }
  }
}
