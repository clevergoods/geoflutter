import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

import '../../../../domain/entities/user_profile.dart';
import '../../../../domain/services/repositories/local_repository.dart';
import '../../../../utils/common/system_log/flogger.dart';
import '../models/user_model_state.dart';

class UserController extends StateNotifier<UserModelState> {
  UserController(StateNotifierProviderRef<UserController, UserModelState> ref) : super(UserModelState.empty()) {}

  static const logTag = 'UserController';
  Flogger get logger => GetIt.instance.get<Flogger>();
  LocalRepository get localRepository => GetIt.instance.get<LocalRepository>();

  store(UserProfile user) async {
    var storedUser = await localRepository.storeUser(user);
    state = state.copyWith(user: storedUser);
  }
}
