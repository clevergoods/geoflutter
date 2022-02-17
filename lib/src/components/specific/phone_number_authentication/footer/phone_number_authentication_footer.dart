import 'package:flutter/material.dart';
import 'package:true_flutter/src/assets/localization/localization.dart';
import 'package:true_flutter/src/components/common/privacy_policy_and_user_agreements/privacy_policy_and_user_agreements.dart';
import 'package:true_flutter/src/components/common/touchable_opacity/touchable_opacity.dart';

class PhoneNumberAuthenticationFooter extends StatelessWidget {
  final bool showUserAgreementsAndPrivacyPolicy;
  final void Function() onUserAgreementPress;
  final void Function() onPrivacyPolicyPress;
  final void Function() onRequestPasswordPress;
  final void Function() onRegisterNowPress;

  const PhoneNumberAuthenticationFooter({
    Key? key,
    required this.showUserAgreementsAndPrivacyPolicy,
    required this.onUserAgreementPress,
    required this.onPrivacyPolicyPress,
    required this.onRequestPasswordPress,
    required this.onRegisterNowPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 100,
        child: showUserAgreementsAndPrivacyPolicy ?
        Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(),
            ),
            PrivacyPolicyAndUserAgreements(
                onUserAgreementPress: onUserAgreementPress,
                onPrivacyPolicyPress: onPrivacyPolicyPress
            )
          ],
        ) : Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(),
            ),
            Center(
              child: TouchableOpacity(
                child: Text(
                    t(context).phoneNumberAuthenticationScreen_requestPassword,
                    style: const TextStyle(
                      fontSize: 16,
                      decoration: TextDecoration.underline,
                    )
                ),
                onTap: onRequestPasswordPress,
              ),
            ),
            Container(
              height: 15,
            ),
            Center(
              child: Text(
                  t(context).phoneNumberAuthenticationScreen_notInWokkaLokkaYet,
                  style: const TextStyle(
                    fontSize: 14,
                  )
              ),
            ),
            Center(
              child: TouchableOpacity(
                  child: Text(
                      t(context).phoneNumberAuthenticationScreen_registerNow,
                      style: const TextStyle(
                        fontSize: 15,
                        decoration: TextDecoration.underline,
                      )
                  ),
                  onTap: onRegisterNowPress
              ),
            ),
            Container(
              height: 8,
            )
          ],
        )
    );
  }
}