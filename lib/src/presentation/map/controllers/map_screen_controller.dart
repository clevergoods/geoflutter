import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:true_flutter/main.dart';
import 'package:true_flutter/src/domain/entities/friend_profile.dart';
import '../../../data/state/network_request_state.dart';
import '../../../domain/services/repositories/local_repository.dart';
import '../../../domain/services/repositories/remote_repository.dart';
import '../../../utils/common/system_log/flogger.dart';
import '../../common/friends/controllers/friends_controller.dart';
import '../../common/friends/models/friends_model_state.dart';
import '../models/map_screen_model_state.dart';


class MapScreenController extends StateNotifier<MapScreenModelState> {
  MapScreenController(this.ref): super(MapScreenModelState.empty()){
    this.friendsController = ref.read(friendsProvider.notifier);
  }
  final Ref ref;
  FriendsController? friendsController;
  static const logTag = 'MapScreenController';
  Flogger get logger => GetIt.instance.get<Flogger>();
  LocalRepository get localRepository => GetIt.instance.get<LocalRepository>();
  RemoteRepository get remoteRepository => GetIt.instance.get<RemoteRepository>();

  Future<void> syncContacts() async {
    try {
      state = state.copyWith(signInState: const NetworkRequestState.syncDataLoading());
      List<FriendProfile> friends = await remoteRepository.getFriends();
      friendsController?.store(friends);
      state =
          state.copyWith(signInState: const NetworkRequestState.success());
    } catch (exception) {
      logger.onError(logTag, exception.toString());
      state = state.copyWith(
          signInState: const NetworkRequestState.error(), error: exception.toString());
    }
  }
}
