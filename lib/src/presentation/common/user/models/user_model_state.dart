import 'package:true_flutter/src/domain/entities/friend_profile.dart';

import '../../../../data/state/network_request_state.dart';
import '../../../../domain/entities/user_profile.dart';

class UserModelState {
  final DateTime dateTime;
  late final UserProfile? user;
  final String? error;

  UserModelState({
    required this.dateTime,
    required this.user,
    required this.error,
  });

  UserModelState.empty()
      : dateTime = DateTime.now(),
        user = null,
        error = null;

  UserModelState copyWith({
    DateTime? dateTime,
    UserProfile? user,
    NetworkRequestState? networkRequestState,
    String? error,
  }) {
    return UserModelState(
      dateTime: dateTime ?? this.dateTime,
      user: user ?? this.user,
      error: error,
    );
  }
}