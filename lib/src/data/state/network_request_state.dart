import 'package:freezed_annotation/freezed_annotation.dart';

part 'network_request_state.freezed.dart';

@freezed
class NetworkRequestState with _$NetworkRequestState {
  const factory NetworkRequestState.notValid() = _NotValid;
  const factory NetworkRequestState.canSubmit() = _CanSubmit;
  const factory NetworkRequestState.logoutLoading() = _LogoutLoading;
  const factory NetworkRequestState.loginLoading() = _LoginLoading;
  const factory NetworkRequestState.syncDataLoading() = _SyncDataLoading;
  const factory NetworkRequestState.success() = _Success;
  const factory NetworkRequestState.error() = _Error;
}

