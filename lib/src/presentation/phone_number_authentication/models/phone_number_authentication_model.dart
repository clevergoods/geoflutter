import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:true_flutter/src/presentation/phone_number_authentication/models/phone_number_authentication_model_state.dart';
import 'package:true_flutter/src/presentation/phone_number_authentication/models/phone_number_authentication_model_state_notifier.dart';

class PhoneNumberAuthenticationModel {
  static final provider = StateNotifierProvider<PhoneNumberAuthenticationModelStateNotifier, PhoneNumberAuthenticationModelState>((ref) {
    return PhoneNumberAuthenticationModelStateNotifier(PhoneNumberAuthenticationModelState.empty());
  });
}