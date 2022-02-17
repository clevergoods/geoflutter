import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:true_flutter/src/data/common/routes/app_routes.dart';
import 'package:true_flutter/src/domain/services/repositories/local_repository.dart';
import 'package:true_flutter/src/domain/services/repositories/remote_repository.dart';
import 'package:true_flutter/src/presentation/common/user/controllers/user_controller.dart';
import 'package:true_flutter/src/utils/common/system_log/system_log.dart';
import '../../../../main.dart';
import '../../../data/state/network_request_state.dart';
import '../../../domain/services/authentication/net_authentication_service.dart';
import '../../../utils/common/system_log/flogger.dart';
import '../../../domain/services/authentication/google_autentication_service.dart';
import '../../../domain/entities/user_profile.dart';
import '../models/authentication_screen_model_state.dart';



class AuthenticationScreenController
    extends StateNotifier<AuthenticationScreenModelState> {
  AuthenticationScreenController(this.ref): super(AuthenticationScreenModelState.empty()){
    this.userController = ref.read(userProvider.notifier);
  }
  final Ref ref;
  UserController? userController;
  static const logTag = 'AuthenticationController';

  Flogger get logger => GetIt.instance.get<Flogger>();
  LocalRepository get localRepository => GetIt.instance.get<LocalRepository>();
  RemoteRepository get remoteRepository => GetIt.instance.get<RemoteRepository>();
  NetAuthentictionService get netService => GetIt.instance.get<NetAuthentictionService>();
  GoogleAuthenticationService get googleService => GetIt.instance.get<GoogleAuthenticationService>();

  void supportPressHandler({required BuildContext context}) {
    Navigator.pushNamed(context, AppRoutes.Support);
  }

  Future<void> googleAuthOptionPressHandler(
      {required BuildContext context}) async {
    state = state.copyWith(signInState: const NetworkRequestState.loginLoading());
    try {
      var user = await localRepository.getUser(1);
      if (user == null) {
        var googleJson = await googleService.logIn(() => null);
        if (googleJson != null) {
          var responseJson = await netService.loginWithToken(googleJson);
          user = UserProfile.fromJson(responseJson);
          user.syncDatafromJson(googleJson);
        }
      }
      if (user != null) {
        user.initAppVersion;
        user.initPlatform();
        user.initSessionid();
        user.initTimeZone();
        await userController?.store(user);
        await _login(user);
      }
    } catch (exception) {
      logger.onError(logTag, exception.toString());
      state = state.copyWith(
          signInState: const NetworkRequestState.error(), error: exception.toString());
    }
  }

  Future<void> vkontakteAuthOptionPressHandler() async {
    SystemLog.onInfo(
        info:
            '_AuthenticationControllerImplementation->vkontakteAuthOptionPressHandler()');
  }

  Future<void> phoneNumberAuthOptionPressHandler(
      {required BuildContext context}) async {
    Navigator.pushNamed(context, AppRoutes.PhoneNumberAuthentication);
  }

  Future<void> logoutOptionPressHandler() async {
    try {
      state = state.copyWith(signInState: const NetworkRequestState.logoutLoading());
      var user = await localRepository.getUser(1);
      logger.onDebug(logTag,
          "user?.getLocation()?.latitude = ${user?.getLocation?.latitude}");
      if (user != null) {
        var json = <String, dynamic>{
          'login': user.login,
          'sessid': user.sessionid,
          'platform': user.platform
        };
        var responseJson = await netService.logout(json);
        logger.onDebug(logTag, "LOGOUT $responseJson");
        await googleService.logOut(() => null);
      }
      state = state.copyWith(signInState: const NetworkRequestState.notValid());
    } catch (exception) {
      logger.onError(logTag, exception.toString());
      state = state.copyWith(
          signInState: const NetworkRequestState.error(), error: exception.toString());
    }
  }

  Future<void> autoLogIn(Function() completion) async {
    try {
      var user = await localRepository.getUser(1);
      await _login(user);
    } catch (exception) {
      logger.onError(logTag, exception.toString());
      state = state.copyWith(
          signInState: const NetworkRequestState.error(), error: exception.toString());
    }
  }

  Future<void> _login(UserProfile? user) async {
    try {
      if (user != null) {
        var requestJson = <String, dynamic>{
          'login': user.login,
          'password': user.password,
          'service': 0,
          'version': user.appVersion,
          'email': user.email,
          'phone': user.phone,
          'platform': user.platform,
          'name': user.name,
          'sessid': user.sessionid
        };
        logger.onDebug(logTag, "LogIn $requestJson");
        state = state.copyWith(signInState: const NetworkRequestState.loginLoading());
        var responseJson =
            await netService.login(requestJson);

        logger.onDebug(logTag, "LOGIN $responseJson");
        if (responseJson.toString().contains("AUTHREQ")) {
          state = state.copyWith(signInState: const NetworkRequestState.notValid());
        } else {
          user.syncDatafromJson(responseJson);
          await userController?.store(user);
          await _syncData(user);
        }
      } else {
        state = state.copyWith(signInState: const NetworkRequestState.notValid());
      }
    } catch (exception) {
      logger.onError(logTag, exception.toString());
      state = state.copyWith(
          signInState: const NetworkRequestState.error(), error: exception.toString());
    }
  }

  Future<void> _syncData(UserProfile? user) async {
    try {
      state =
          state.copyWith(signInState: const NetworkRequestState.syncDataLoading());
      var storedUser = await remoteRepository.storeUser(user);
      if(storedUser == null){
        state = state.copyWith(signInState: const NetworkRequestState.notValid());
      }else{
        await userController?.store(storedUser);
        state = state.copyWith(signInState: const NetworkRequestState.canSubmit());
      }
    } catch (exception) {
      logger.onError(logTag, exception.toString());
      state = state.copyWith(
          signInState: const NetworkRequestState.error(), error: exception.toString());
    }
  }

  closeStore() async{
    await localRepository.closeRepository();
    await remoteRepository.closeRepository();
  }
}
