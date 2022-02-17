import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:true_flutter/src/assets/localization/localization.dart';
import 'package:true_flutter/src/presentation/authentication/views/phone_authentication/phone_number_authentication_screen_view.dart';

import 'controllers/phone_number_authentication_controller.dart';

class PhoneNumberAuthenticationScreen extends ConsumerWidget {
  const PhoneNumberAuthenticationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(PhoneNumberAuthenticationController.provider);

    return GestureDetector(
        onTap: () {
          controller.screenFreeAreaPressHandler(context: context);
        },
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: Text(
                  t(context).phoneNumberAuthenticationScreen_authenticationHeaderTitle
              ),
              backgroundColor: const Color(0xff1ca8ae),
              elevation: 0,
            ),
            body: const PhoneAuthenticationScreenView()
        )
    );
  }
}