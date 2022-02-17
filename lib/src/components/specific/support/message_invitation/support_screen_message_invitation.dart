import 'package:flutter/material.dart';
import 'package:true_flutter/src/assets/localization/localization.dart';

class SupportScreenMessageInvitation extends StatelessWidget {
  const SupportScreenMessageInvitation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20.0, right: 20.0),
      height: 100,
      // color: Colors.grey,
      child: Center(
        child: Text(
          t(context).supportScreen_invitationMessage,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}