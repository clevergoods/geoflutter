import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:true_flutter/src/assets/localization/localization.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:true_flutter/src/data/common/routes/app_routes.dart';
import 'package:true_flutter/src/domain/services/authentication/google_autentication_service.dart';
import 'package:true_flutter/src/domain/services/authentication/net_authentication_service.dart';
import 'package:true_flutter/src/domain/services/repositories/local_repository.dart';
import 'package:true_flutter/src/domain/services/repositories/remote_repository.dart';
import 'package:true_flutter/src/presentation/authentication/authentication_screen.dart';
import 'package:true_flutter/src/presentation/common/friends/controllers/friends_controller.dart';
import 'package:true_flutter/src/presentation/common/friends/models/friends_model_state.dart';
import 'package:true_flutter/src/presentation/common/user/controllers/user_controller.dart';
import 'package:true_flutter/src/presentation/common/user/models/user_model_state.dart';
import 'package:true_flutter/src/presentation/map/map_screen.dart';
import 'package:true_flutter/src/presentation/phone_number_authentication/phone_number_authentication_screen.dart';
import 'package:true_flutter/src/presentation/support/support_screen.dart';
import 'package:true_flutter/src/utils/common/repositories/objectbox_db_utils.dart';
import 'package:true_flutter/src/utils/common/system_log/flogger.dart';
import 'package:get_it/get_it.dart';

const methodChannelName = "samples.flutter.dev/method";
const messageChannelName = "samples.flutter.dev/message";

const methodChannel = MethodChannel(methodChannelName);

const logTag = 'main';
late Flogger logger;

final userProvider = StateNotifierProvider<UserController, UserModelState>((ref) {
  return UserController(ref);
});
final friendsProvider = StateNotifierProvider<FriendsController, FriendsModelState>((ref) {
  return FriendsController(ref);
});


GetIt getIt = GetIt.instance;

void main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    final logger = Flogger();
    GetIt.instance.registerSingleton(logger);
    final dBService = ObjectboxDBUtils();
    await dBService.initObjectbox();
    GetIt.instance.registerSingleton(dBService);
    final localRepository = LocalRepository();
    GetIt.instance.registerSingleton(localRepository);
    final remoteRepository = RemoteRepository();
    GetIt.instance.registerSingleton(remoteRepository);
    final netAuthentictionService = NetAuthentictionService();
    GetIt.instance.registerSingleton(netAuthentictionService);
    final googleAuthenticationService = GoogleAuthenticationService();
    GetIt.instance.registerSingleton(googleAuthenticationService);

    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.presentError(details);
      logger.onError(logTag, "Error :  ${details.exception} /n StackTrace :  ${details.stack}");
    };

    await Firebase.initializeApp();
    runApp(
            const ProviderScope(
              child: MyApp(),
            )
    );
  }, (Object error, StackTrace stack) {
    logger.onError(logTag, "Error :  ${stack.toString()}");
  });
}



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: Localization.all,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      initialRoute: AppRoutes.Authentication,
      routes: {
        AppRoutes.Authentication: (context) => const AuthenticationScreen(),
        AppRoutes.PhoneNumberAuthentication: (context) => const PhoneNumberAuthenticationScreen(),
        AppRoutes.Support: (context) => const SupportScreen(),
        AppRoutes.MapScreen: (context) => const MapScreen(),
      },
    );
  }
}
