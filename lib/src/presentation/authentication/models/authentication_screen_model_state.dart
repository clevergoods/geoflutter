import 'package:flutter/cupertino.dart';
import 'package:true_flutter/src/data/state/network_request_state.dart';

import '../../../assets/localization/localization.dart';

class AuthenticationScreenModelState {
  final DateTime dateTime;
  final NetworkRequestState signInState;
  final String? error;

  AuthenticationScreenModelState({
    required this.dateTime,
    required this.signInState,
    required this.error,
  });

  AuthenticationScreenModelState.empty()
      : dateTime = DateTime.now(),
        signInState = const NetworkRequestState.notValid(),
        error = null;

  AuthenticationScreenModelState copyWith({
    DateTime? dateTime,
    NetworkRequestState? signInState,
    String? error,
  }) {
    return AuthenticationScreenModelState(
        dateTime: dateTime ?? this.dateTime,
        signInState: signInState ?? this.signInState,
        error: error,
    );
  }

  String? getTitle(BuildContext context){
    String title;
    if (signInState == const NetworkRequestState.loginLoading() || signInState == const NetworkRequestState.logoutLoading() || signInState == const NetworkRequestState.syncDataLoading()) {
      title = t(context).authenticationScreen_InProcessInvitation;
    }else if (signInState == const NetworkRequestState.canSubmit()) {
      title = t(context).authenticationScreen_logoutInvitation;
    }else if(signInState == const NetworkRequestState.error()){
      title = t(context).authenticationScreen_errorInvitation;
    }else {
      title = t(context).authenticationScreen_loginInvitation;
    }
    return title;
  }
}