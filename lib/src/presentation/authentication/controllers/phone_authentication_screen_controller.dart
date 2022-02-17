import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

import '../../../../main.dart';
import '../../../data/specific/phone_number_authentication/phone_number_authentication_mode/phone_number_authentication_mode.dart';
import '../../../data/state/network_request_state.dart';
import '../../../utils/common/system_log/flogger.dart';
import '../../common/user/controllers/user_controller.dart';
import '../models/phone_authentication_screen_model_state.dart';

class PhoneAuthenticationScreenController extends StateNotifier<PhoneAuthenticationScreenModelState> {
  PhoneAuthenticationScreenController() : super(PhoneAuthenticationScreenModelState.empty()) {}

  UserController? userController;
  static const logTag = 'PhoneAuthenticationScreenController';
  Flogger get logger => GetIt.instance.get<Flogger>();
  CountryWithPhoneCode? _selectedCountry;
  Map? _phoneNumber;

  CountryWithPhoneCode? get selectedCountry => _selectedCountry;
  String? get phoneCode => _selectedCountry?.phoneCode;
  String get formattedPhoneNumber => _phoneNumber != null ? _phoneNumber!['international'] : '';

  Future<void> loadCountries() async {
    List<CountryWithPhoneCode> _countries = [];
    try {
      await FlutterLibphonenumber().init();
      _countries = CountryManager().countries;
      _countries.sort((a, b) {
        if(a.countryName != null && b.countryName != null){
        return a.countryName! .toLowerCase() .compareTo(b.countryName!.toLowerCase());
      } else {
          return 0;
        }
      });

      final langCode = ui.window.locale.languageCode.toUpperCase();
      var filteredCountries =
          _countries.where((item) => item.countryCode == langCode);

      if (filteredCountries.isEmpty) {
        filteredCountries = _countries.where((item) => item.countryCode == 'RU');
      }
      if (filteredCountries.isEmpty) {
        throw Exception('Unable to find a default country!');
      }
      setCountry(filteredCountries.first);
    } catch (e) {
      state = state.copyWith(signInState: const NetworkRequestState.error(), error: e.toString());
    }
    state = state.copyWith(countries: _countries);
  }

  void setCountry(CountryWithPhoneCode selectedCountry) {
    _selectedCountry = selectedCountry;

  }

  Future<void> parsePhoneNumber(String inputText) async {
    print("parsing $inputText // ${_selectedCountry?.phoneCode}${inputText}");
    _phoneNumber = await FlutterLibphonenumber().parse(
      "+${_selectedCountry?.phoneCode}${inputText}",
      region: _selectedCountry?.countryCode,
    );
    if (_phoneNumber == null || _phoneNumber!['type'] != 'mobile') {
      throw Exception('You must enter a mobile phone number.');
    }
  }

  Future<void> verifyPhone(Function() completion) async {

  }

  Future<void> verifyCode(String smsCode, Function() completion) async {
    // final AuthCredential credential = PhoneAuthProvider.credential(
    //   verificationId: _verificationId,
    //   smsCode: smsCode,
    // );
    // final user = await _firebaseAuth.signInWithCredential(credential);
    // if (user != null) {
    //   completion();
    // }
  }



  Future<void> signOut() async {
    //await _firebaseAuth.signOut();
  }

  void screenFreeAreaPressHandler({required BuildContext context}) {
    logger.onInfo(logTag, '_PhoneNumberAuthenticationControllerImplementation->screenFreeAreaPressHandler()');

    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  void userAgreementPressHandler() {
    logger.onInfo(logTag, '_PhoneNumberAuthenticationControllerImplementation->userAgreementPressHandler()');
  }

  void privacyPolicyPressHandler() {
    logger.onInfo(logTag, '_PhoneNumberAuthenticationControllerImplementation->privacyPolicyPressHandler()');
  }

  void registerPressHandler() {
    logger.onInfo(logTag, '_PhoneNumberAuthenticationControllerImplementation->registerPressHandler()');
  }

  void signInPressHandler() {
    logger.onInfo(logTag, '_PhoneNumberAuthenticationControllerImplementation->signInPressHandler()');

    String currentMode = state.currentMode;
    if (currentMode == PhoneNumberAuthenticationMode.Registration) {
      _changeAuthenticationMode();
    }
  }

  void countryCodePressHandler() {
    logger.onInfo(logTag, '_PhoneNumberAuthenticationControllerImplementation->countryCodePressHandler()');
  }

  void passwordVisibilityPressHandler() {
    logger.onInfo(logTag, '_PhoneNumberAuthenticationControllerImplementation->passwordVisibilityPressHandler()');

    bool passwordVisible = state.passwordVisible;
    _setPasswordVisible(!passwordVisible);
  }

  void phoneNumberChangeHandler(String phoneNumber) {
    logger.onInfo(logTag, '_PhoneNumberAuthenticationControllerImplementation->phoneNumberChangeHandler(): ' + phoneNumber);
  }

  void passwordChangeHandler(String password) {
    logger.onInfo(logTag, '_PhoneNumberAuthenticationControllerImplementation->passwordChangeHandler(): ' + password);
  }

  void requestPasswordPressHandler() {
    logger.onInfo(logTag, '_PhoneNumberAuthenticationControllerImplementation->requestPasswordPressHandler()');
  }

  void registerNowPressHandler() {
    logger.onInfo(logTag, '_PhoneNumberAuthenticationControllerImplementation->registerNowPressHandler()');
    _changeAuthenticationMode();
  }

  void _changeAuthenticationMode() {
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

  void _setShowPasswordField(bool needShow) {
    state = state.copyWith(showPasswordField: needShow);
  }

  void _setPasswordVisible(bool visible) {
    state = state.copyWith(passwordVisible: visible);
  }

}
