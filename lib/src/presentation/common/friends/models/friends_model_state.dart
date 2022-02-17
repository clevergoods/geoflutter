import 'package:true_flutter/src/domain/entities/friend_profile.dart';

import '../../../../data/state/network_request_state.dart';

class FriendsModelState {
  final DateTime dateTime;
  List<FriendProfile>?friends;
  final String? error;

  FriendsModelState({
    required this.dateTime,
    required this.friends,
    required this.error,
  });

  FriendsModelState.empty()
      : dateTime = DateTime.now(),
        friends = List.empty(),
        error = null;

  FriendsModelState copyWith({
    DateTime? dateTime,
    List<FriendProfile>? friends,
    String? error,
  }) {
    return FriendsModelState(
      dateTime: dateTime ?? this.dateTime,
      friends: friends ?? this.friends,
      error: error,
    );
  }
}