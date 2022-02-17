import 'package:flutter/material.dart';
import 'package:true_flutter/src/assets/localization/localization.dart';
import 'package:true_flutter/src/components/common/simple_rounded_button/simple_rounded_button.dart';

class AuthenticationOptions extends StatelessWidget {
  final void Function({required BuildContext context}) onGoogleOptionPress;
  final void Function() onVkontakteOptionPress;
  final void Function({required BuildContext context}) onPhoneNumberOptionPress;

  const AuthenticationOptions({
    Key? key,
    required this.onGoogleOptionPress,
    required this.onVkontakteOptionPress,
    required this.onPhoneNumberOptionPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      height: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SimpleRoundedButton(
            title: t(context).authenticationScreen_optionGoogle,
            color: Colors.red,
            onPress:() {
              onGoogleOptionPress(context: context);
            }
          ),
          SimpleRoundedButton(
            title: t(context).authenticationScreen_optionVkontakte,
            color: const Color(0xff4c6c91),
            onPress: onVkontakteOptionPress,
          ),
          SimpleRoundedButton(
            title: t(context).authenticationScreen_optionPhoneNumber,
            color: const Color(0xff1fb2b5),
            onPress: () {
              onPhoneNumberOptionPress(context: context);
            }
          ),
        ],
      ),
    );
  }
}