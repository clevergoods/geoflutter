import '../../entities/friend_profile.dart';
import '../../entities/user_profile.dart';

abstract class Repository{
  Future<UserProfile?> getUser(int? id);
  Future<UserProfile?> storeUser(UserProfile? user);
  Future<List<FriendProfile>> getFriends();
  Future<List<FriendProfile>?> storeFriends(List<FriendProfile> userFriends);
  Future<void> closeRepository();
}