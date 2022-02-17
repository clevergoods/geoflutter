import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:true_flutter/src/data/specific/phone_number_authentication/phone_number_authentication_mode/phone_number_authentication_mode.dart';
import 'package:true_flutter/src/utils/common/system_log/system_log.dart';

import '../models/phone_number_authentication_model.dart';

class PhoneNumberAuthenticationController {
  static final provider = Provider<_PhoneNumberAuthenticationControllerImplementation>((ref) {
    return _PhoneNumberAuthenticationControllerImplementation(ref: ref);
  });
}

class _PhoneNumberAuthenticationControllerImplementation {
  final Ref ref;

  _PhoneNumberAuthenticationControllerImplementation({required this.ref});

  void screenFreeAreaPressHandler({required BuildContext context}) {
    SystemLog.onInfo(info: '_PhoneNumberAuthenticationControllerImplementation->screenFreeAreaPressHandler()');

    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  void userAgreementPressHandler() {
    SystemLog.onInfo(info: '_PhoneNumberAuthenticationControllerImplementation->userAgreementPressHandler()');
  }

  void privacyPolicyPressHandler() {
    SystemLog.onInfo(info: '_PhoneNumberAuthenticationControllerImplementation->privacyPolicyPressHandler()');
  }

  void registerPressHandler() {
    SystemLog.onInfo(info: '_PhoneNumberAuthenticationControllerImplementation->registerPressHandler()');
  }

  void signInPressHandler() {
    SystemLog.onInfo(info: '_PhoneNumberAuthenticationControllerImplementation->signInPressHandler()');

    String currentMode = ref.read(PhoneNumberAuthenticationModel.provider).currentMode;
    if (currentMode == PhoneNumberAuthenticationMode.Registration) {
      ref.read(PhoneNumberAuthenticationModel.provider.notifier).changeAuthenticationMode();
    }
  }

  void countryCodePressHandler() {
    SystemLog.onInfo(info: '_PhoneNumberAuthenticationControllerImplementation->countryCodePressHandler()');
  }

  void passwordVisibilityPressHandler() {
    SystemLog.onInfo(info: '_PhoneNumberAuthenticationControllerImplementation->passwordVisibilityPressHandler()');

    bool passwordVisible = ref.read(PhoneNumberAuthenticationModel.provider).passwordVisible;
    ref.read(PhoneNumberAuthenticationModel.provider.notifier).setPasswordVisible(!passwordVisible);
  }

  void phoneNumberChangeHandler(String phoneNumber) {
    SystemLog.onInfo(info: '_PhoneNumberAuthenticationControllerImplementation->phoneNumberChangeHandler(): ' + phoneNumber);
  }

  void passwordChangeHandler(String password) {
    SystemLog.onInfo(info: '_PhoneNumberAuthenticationControllerImplementation->passwordChangeHandler(): ' + password);
  }

  void requestPasswordPressHandler() {
    SystemLog.onInfo(info: '_PhoneNumberAuthenticationControllerImplementation->requestPasswordPressHandler()');
  }

  void registerNowPressHandler() {
    SystemLog.onInfo(info: '_PhoneNumberAuthenticationControllerImplementation->registerNowPressHandler()');

    ref.read(PhoneNumberAuthenticationModel.provider.notifier).changeAuthenticationMode();
  }
}