import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:true_flutter/src/assets/localization/localization.dart';

class PrivacyPolicyAndUserAgreements extends StatelessWidget {
  final void Function() onUserAgreementPress;
  final void Function() onPrivacyPolicyPress;

  const PrivacyPolicyAndUserAgreements({
    Key? key,
    required this.onUserAgreementPress,
    required this.onPrivacyPolicyPress
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(8.0),
          child: Text.rich(
            TextSpan(
              text: t(context)
                  .authenticationScreen_privacyPolicyAndUserAgreementsIntro,
              style: const TextStyle(fontSize: 14),
              children: [
                TextSpan(
                    text: t(context).authenticationScreen_privacyPolicy,
                    style: const TextStyle(
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () =>
                      {
                        onUserAgreementPress()
                      }
                ),
                TextSpan(
                  text: t(context)
                      .authenticationScreen_authenticationScreen_privacyPolicyAndUserAgreementsAnd,
                ),
                TextSpan(
                    text: t(context).authenticationScreen_userAgreement,
                    style: const TextStyle(
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () =>
                      {
                        onPrivacyPolicyPress()
                      }
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}