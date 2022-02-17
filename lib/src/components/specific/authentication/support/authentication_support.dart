import 'package:flutter/material.dart';
import 'package:true_flutter/src/assets/localization/localization.dart';
import 'package:true_flutter/src/components/common/touchable_opacity/touchable_opacity.dart';

class AuthenticationSupport extends StatelessWidget {
  final void Function({required BuildContext context}) onSupportPress;

  const AuthenticationSupport({
    Key? key,
    required this.onSupportPress
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(),
            ),
            const Center(
              child: Icon(
                Icons.support_agent,
                size: 20,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 8.0),
              child: Text(
                t(context).authenticationScreen_support,
                style: const TextStyle(
                  fontSize: 14,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(),
            )
          ],
        ),
        onTap: () {
          onSupportPress(context: context);
        }
    );
  }
}