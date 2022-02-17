import 'package:flutter/cupertino.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
import 'package:true_flutter/src/data/state/network_request_state.dart';

import '../../../assets/localization/localization.dart';
import '../../../data/specific/phone_number_authentication/phone_number_authentication_mode/phone_number_authentication_mode.dart';

class PhoneAuthenticationScreenModelState {
  final DateTime dateTime;
  List<CountryWithPhoneCode>? countries;
  final String currentMode;
  final bool showPasswordField;
  final bool passwordVisible;
  final CountryWithPhoneCode selectedCountry;
  final int correctNumberOfDigitsInPhoneNumber;
  final String enteredPhoneNumber;
  final String enteredPassword;
  final NetworkRequestState signInState;
  final String? error;

  PhoneAuthenticationScreenModelState({
    required this.dateTime,
    required this.countries,
    required this.currentMode,
    required this.showPasswordField,
    required this.passwordVisible,
    required this.selectedCountry,
    required this.correctNumberOfDigitsInPhoneNumber,
    required this.enteredPhoneNumber,
    required this.enteredPassword,
    required this.signInState,
    required this.error,
  });

  PhoneAuthenticationScreenModelState.empty()
      : dateTime = DateTime.now(),
        countries = List.empty(),
        currentMode = PhoneNumberAuthenticationMode.SignIn,
        showPasswordField = false,
        passwordVisible = false,
        selectedCountry = const CountryWithPhoneCode.us(),
        correctNumberOfDigitsInPhoneNumber = 10,
        enteredPhoneNumber = '',
        enteredPassword = '',
        signInState = const NetworkRequestState.notValid(),
        error = null;

  PhoneAuthenticationScreenModelState copyWith({
    DateTime? dateTime,
    List<CountryWithPhoneCode>? countries,
    String? currentMode,
    bool? showPasswordField,
    bool? passwordVisible,
    int? correctNumberOfDigitsInPhoneNumber,
    String? enteredPhoneNumber,
    String? enteredPassword,
    NetworkRequestState? signInState,
    String? error,
  }) {
    return PhoneAuthenticationScreenModelState(
      dateTime: dateTime ?? this.dateTime,
      countries: countries ?? this.countries,
      currentMode: currentMode ?? this.currentMode,
      showPasswordField: showPasswordField ?? this.showPasswordField,
      passwordVisible: passwordVisible ?? this.passwordVisible,
      correctNumberOfDigitsInPhoneNumber: correctNumberOfDigitsInPhoneNumber ??
          this.correctNumberOfDigitsInPhoneNumber,
      enteredPhoneNumber: enteredPhoneNumber ?? this.enteredPhoneNumber,
      enteredPassword: enteredPassword ?? this.enteredPassword,
      signInState: signInState ?? this.signInState,
      error: error, selectedCountry: CountryWithPhoneCode.us(),
    );
  }
}
