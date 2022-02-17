import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:true_flutter/src/data/state/network_request_state.dart';

import '../../../../domain/entities/friend_profile.dart';
import '../../../../domain/services/repositories/local_repository.dart';
import '../../../../domain/services/repositories/remote_repository.dart';
import '../../../../utils/common/system_log/flogger.dart';
import '../models/friends_model_state.dart';

class FriendsController extends StateNotifier<FriendsModelState> {
  FriendsController(StateNotifierProviderRef<FriendsController, FriendsModelState> ref) : super(FriendsModelState.empty()) {}

  static const logTag = 'FriendsController';
  Flogger get logger => GetIt.instance.get<Flogger>();
  LocalRepository get localRepository => GetIt.instance.get<LocalRepository>();

  store(List<FriendProfile> friends) async {
    var storedFriends = await localRepository.storeFriends(friends);
    state = state.copyWith(friends: storedFriends);
  }
}