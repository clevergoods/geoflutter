import 'package:true_flutter/src/domain/entities/friend_profile.dart';

import '../../../data/state/network_request_state.dart';
import '../../../domain/entities/user_profile.dart';

class MapScreenModelState {
  final DateTime dateTime;
  final NetworkRequestState networkRequestState;
  final String? error;
  final UserProfile? user;

  MapScreenModelState({
    required this.dateTime,
    required this.networkRequestState,
    required this.error,
    required this.user,
  });

  MapScreenModelState.empty()
      : dateTime = DateTime.now(),
        networkRequestState = const NetworkRequestState.notValid(),
        user = null,
        error = null;

  MapScreenModelState copyWith({
    DateTime? dateTime,
    NetworkRequestState? signInState,
    UserProfile? user,
    String? error,
  }) {
    return MapScreenModelState(
      dateTime: dateTime ?? this.dateTime,
      networkRequestState: signInState ?? this.networkRequestState,
      user: user ?? this.user,
      error: error,
    );
  }
}