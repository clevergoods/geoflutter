import 'package:true_flutter/src/data/specific/phone_number_authentication/phone_number_authentication_mode/phone_number_authentication_mode.dart';

class PhoneNumberAuthenticationModelState {
  final bool showPasswordField;
  final bool passwordVisible;
  final int correctNumberOfDigitsInPhoneNumber;

  final String enteredPhoneNumber;
  final String enteredPassword;

  final String currentMode;

  PhoneNumberAuthenticationModelState({
    required this.showPasswordField,
    required this.passwordVisible,
    required this.correctNumberOfDigitsInPhoneNumber,
    required this.enteredPhoneNumber,
    required this.enteredPassword,
    required this.currentMode,
  });

  PhoneNumberAuthenticationModelState.empty()
      : showPasswordField = false,
        passwordVisible = false,
        correctNumberOfDigitsInPhoneNumber = 10,
        enteredPhoneNumber = '',
        enteredPassword = '',
        currentMode = PhoneNumberAuthenticationMode.Registration;

  PhoneNumberAuthenticationModelState copyWith({
    bool? showPasswordField,
    bool? passwordVisible,
    int? correctNumberOfDigitsInPhoneNumber,
    String? enteredPhoneNumber,
    String? enteredPassword,
    String? currentMode,
  }) {
    return PhoneNumberAuthenticationModelState(
      showPasswordField: showPasswordField ?? this.showPasswordField,
      passwordVisible: passwordVisible ?? this.passwordVisible,
      correctNumberOfDigitsInPhoneNumber: correctNumberOfDigitsInPhoneNumber ??
          this.correctNumberOfDigitsInPhoneNumber,
      enteredPhoneNumber: enteredPhoneNumber ?? this.enteredPhoneNumber,
      enteredPassword:  enteredPassword ?? this.enteredPassword,
      currentMode: currentMode ?? this.currentMode,
    );
  }
}