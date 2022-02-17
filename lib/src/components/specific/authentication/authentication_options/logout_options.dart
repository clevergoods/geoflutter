import 'package:flutter/material.dart';
import 'package:true_flutter/src/assets/localization/localization.dart';
import 'package:true_flutter/src/components/common/simple_rounded_button/simple_rounded_button.dart';

class LogoutOptions extends StatelessWidget {
  final void Function() onLogoutOptionPress;

  const LogoutOptions({
    Key? key,
    required this.onLogoutOptionPress
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
            title: t(context).logoutScreen_optionLogout,
            color: const Color(0xff4c6c91),
            onPress: onLogoutOptionPress,
          ),
      ],
      ),
    );
  }
}