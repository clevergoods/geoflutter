import 'package:flutter/material.dart';
import 'package:true_flutter/src/assets/localization/localization.dart';

class PhoneNumberAuthenticationRegistrationHint extends StatelessWidget {
  const PhoneNumberAuthenticationRegistrationHint({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      // color: Colors.grey,
      child: Text(
        t(context).phoneNumberAuthenticationScreen_smsHint,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }
}