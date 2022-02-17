import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:true_flutter/src/data/specific/phone_number_authentication/phone_number_authentication_mode/phone_number_authentication_mode.dart';
import 'package:true_flutter/src/presentation/phone_number_authentication/models/phone_number_authentication_model_state.dart';

class PhoneNumberAuthenticationModelStateNotifier extends StateNotifier<PhoneNumberAuthenticationModelState> {
  PhoneNumberAuthenticationModelStateNotifier(PhoneNumberAuthenticationModelState state)
      : super(state);

  void setShowPasswordField(bool needShow) {
    state = state.copyWith(showPasswordField: needShow);
  }

  void setPasswordVisible(bool visible) {
    state = state.copyWith(passwordVisible: visible);
  }

  void changeAuthenticationMode() {
    String currentMode = state.currentMode;
    if (currentMode == PhoneNumberAuthenticationMode.Registration) {
      state = state.copyWith(
        showPasswordField: true,
        currentMode: PhoneNumberAuthenticationMode.SignIn,
      );
    } else if (currentMode == PhoneNumberAuthenticationMode.SignIn) {
      state = state.copyWith(
        showPasswordField: false,
        currentMode: PhoneNumberAuthenticationMode.Registration
      );
    }
  }
}