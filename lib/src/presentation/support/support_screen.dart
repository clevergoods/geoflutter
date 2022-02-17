import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:true_flutter/src/assets/localization/localization.dart';
import 'package:true_flutter/src/presentation/support/views/support_screen_view.dart';

import 'controllers/support_screen_controller.dart';

class SupportScreen extends ConsumerWidget {
  const SupportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(SupportScreenController.provider);

    return GestureDetector(
      onTap: () {
        controller.screenFreeAreaPressHandler(context: context);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(t(context).supportScreen_headerTitle),
          backgroundColor: const Color(0xff1ca8ae),
          elevation: 0,
        ),
        body: const SupportScreenView(),
      )
    );
  }
}