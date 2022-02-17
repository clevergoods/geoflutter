import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:true_flutter/src/components/common/privacy_policy_and_user_agreements/privacy_policy_and_user_agreements.dart';
import 'package:true_flutter/src/components/common/privacy_policy_modal/privacy_policy_modal.dart';
import 'package:true_flutter/src/components/common/user_agreement_modal/user_agreement_modal.dart';
import 'package:true_flutter/src/components/specific/authentication/authentication_invitation/authentication_invitation.dart';
import 'package:true_flutter/src/components/specific/authentication/authentication_options/authentication_options.dart';
import 'package:true_flutter/src/components/specific/authentication/authentication_options/logout_options.dart';
import 'package:true_flutter/src/components/specific/authentication/support/authentication_support.dart';
import '../../../data/state/network_request_state.dart';
import '../../../utils/common/system_log/flogger.dart';
import '../../map/views/map_screen_view.dart';
import '../controllers/authentication_screen_controller.dart';
import '../models/authentication_screen_model_state.dart';

class AuthenticationScreenView extends ConsumerStatefulWidget {
  const AuthenticationScreenView({Key? key}) : super(key: key);

  @override
  ConsumerState<AuthenticationScreenView> createState() =>
      AuthenticationScreenState();
}

class AuthenticationScreenState
    extends ConsumerState<AuthenticationScreenView> {
  static const logTag = 'AuthenticationScreenView';
  Flogger get logger => GetIt.instance.get<Flogger>();
  final authenticationProvider = StateNotifierProvider<AuthenticationScreenController, AuthenticationScreenModelState>(
          (ref) => AuthenticationScreenController(ref));

  late AuthenticationScreenController controller;
  late String title;

  @override
  initState() {
    super.initState();
      controller = ref.read(authenticationProvider.notifier);
    controller.autoLogIn(() => null);
  }

  Future<bool> showExitPopup() async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Exit App'),
            content: Text('Do you want to exit an App?'),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No'),
              ),
              ElevatedButton(
                onPressed: () {
                  controller.closeStore();
                  exit(0);
                },
                child: Text('Yes'),
              ),
            ],
          ),
        ) ??
        false; //if showDialouge had returned null, then return false
  }

  Future<bool> _willPopCallback() async {
    return await showExitPopup();
  }

  @override
  Widget build(BuildContext context) {
    final modelState = ref.watch(authenticationProvider);
    final signInState = modelState.signInState;
    final title = modelState.getTitle(context).toString();
    if (signInState == const NetworkRequestState.canSubmit()) {
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => const MapScreenView()));
      });
    }

    return Scaffold(
        body: WillPopScope(
            onWillPop: _willPopCallback,
            child:
              Stack(
                children: [
                  Positioned(
                      child: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            'lib/src/assets/images/login_background.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                    height: 200,
                    width: double.infinity,
                  )),
                  Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(),
                      ),
                      AuthenticationInvitation(title: title),
                      Visibility(
                        visible: signInState == const NetworkRequestState.error(),
                        child: Container(
                          padding: const EdgeInsets.all(10.0),
                          height: 200,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: const [
                              CircularProgressIndicator(),
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        visible: signInState ==
                                const NetworkRequestState.loginLoading() ||
                            signInState == const NetworkRequestState.logoutLoading() ||
                            signInState == const NetworkRequestState.syncDataLoading(),
                        child: Container(
                          padding: const EdgeInsets.all(10.0),
                          height: 200,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: const [
                              CircularProgressIndicator(),
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        visible: signInState == const NetworkRequestState.notValid(),
                        child: AuthenticationOptions(
                          onGoogleOptionPress:
                              controller.googleAuthOptionPressHandler,
                          //Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => const AuthenticationScreen()));
                          onVkontakteOptionPress:
                              controller.vkontakteAuthOptionPressHandler,
                          onPhoneNumberOptionPress:
                              controller.phoneNumberAuthOptionPressHandler,
                        ),
                      ),
                      Visibility(
                        visible: signInState == const NetworkRequestState.canSubmit(),
                        child: LogoutOptions(
                          onLogoutOptionPress:
                              controller.logoutOptionPressHandler,
                        ),
                      ),
                      Center(
                        child: AuthenticationSupport(
                          onSupportPress: controller.supportPressHandler,
                        ),
                      ),
                      Center(
                          child: PrivacyPolicyAndUserAgreements(
                        onUserAgreementPress: () {
                          _showUserAgreementModal(context);
                        },
                        onPrivacyPolicyPress: () {
                          _showPrivacyPolicyModal(context);
                        },
                      )),
                    ],
                  ),
                ],
              )
            ));
  }

  void _showPrivacyPolicyModal(BuildContext context) {
    showGeneralDialog(
        context: context,
        barrierDismissible: false,
        pageBuilder: (context, animation, secondaryAnimation) {
          return const PrivacyPolicyModal();
        });
  }

  void _showUserAgreementModal(BuildContext context) {
    showGeneralDialog(
        context: context,
        barrierDismissible: false,
        pageBuilder: (context, animation, secondaryAnimation) {
          return const UserAgreementModal();
        });
  }
}
