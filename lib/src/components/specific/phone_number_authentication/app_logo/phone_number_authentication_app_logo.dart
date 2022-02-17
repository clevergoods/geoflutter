import 'package:flutter/material.dart';

class PhoneNumberAuthenticationAppLogo extends StatelessWidget {
  const PhoneNumberAuthenticationAppLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 100,
      child: Image(
          image: AssetImage('lib/src/assets/images/newlogo_white.png')),
    );
  }
}