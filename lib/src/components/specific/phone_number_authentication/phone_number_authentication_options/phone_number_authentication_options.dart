import 'package:flutter/material.dart';
import 'package:true_flutter/src/assets/localization/localization.dart';
import 'package:true_flutter/src/components/common/simple_rounded_button/simple_rounded_button.dart';
import 'package:true_flutter/src/data/specific/phone_number_authentication/phone_number_authentication_mode/phone_number_authentication_mode.dart';

class PhoneNumberAuthenticationOptions extends StatelessWidget {
  final String currentMode;
  final void Function() onRegisterPress;
  final void Function() onSignInPress;

  const PhoneNumberAuthenticationOptions({
    Key? key,
    required this.currentMode,
    required this.onRegisterPress,
    required this.onSignInPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool showRegistrationButton = currentMode ==
        PhoneNumberAuthenticationMode.Registration;
    final Color signInButtonColor = currentMode ==
        PhoneNumberAuthenticationMode.Registration
        ? const Color(0xff1fb2b5)
        : const Color(0xffff1f44);

    return Container(
      padding: const EdgeInsets.all(10.0),
      height: 150,
      // color: Colors.grey,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            flex: 1,
            child: Container(),
          ),
          showRegistrationButton ?
          SimpleRoundedButton(
            title: t(context).phoneNumberAuthenticationScreen_registerButton,
            color: const Color(0xffff1f44),
            onPress: onRegisterPress,
          ) : Container(),
          Container(
            height: 10,
          ),
          SimpleRoundedButton(
            title: t(context).phoneNumberAuthenticationScreen_signInButton,
            color: signInButtonColor,
            onPress: onSignInPress,
          ),
          // Expanded(
          //   flex: 1,
          //   child: Container(),
          // )
        ],
      ),
    );
  }
}