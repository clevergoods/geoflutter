import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:true_flutter/src/utils/common/system_log/system_log.dart';

import '../models/support_screen_model.dart';

class SupportScreenController {
  static final provider = Provider<_SupportScreenControllerImplementation>((ref) {
    return _SupportScreenControllerImplementation(ref: ref);
  });
}

class _SupportScreenControllerImplementation {
  final Ref ref;

  _SupportScreenControllerImplementation({required this.ref});

  void screenFreeAreaPressHandler({required BuildContext context}) {
    SystemLog.onInfo(info: '_SupportScreenControllerImplementation->screenFreeAreaPressHandler()');

    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  void sendButtonPressHandler() {
    SystemLog.onInfo(info: '_SupportScreenControllerImplementation->sendButtonPressHandler()');
  }

  void attachFileButtonPressHandler() {
    SystemLog.onInfo(info: '_SupportScreenControllerImplementation->attachFileButtonPressHandler()');

    ref.read(SupportScreenModel.provider.notifier).attachFile();
  }

  void removeAttachedFileButtonPressHandler() {
    SystemLog.onInfo(info: '_SupportScreenControllerImplementation->removeAttachedFileButtonPressHandler()');

    ref.read(SupportScreenModel.provider.notifier).removeAttachedFile();
  }

  void askInTelegramButtonPressHandler() {
    SystemLog.onInfo(info: '_SupportScreenControllerImplementation->askInTelegramButtonPressHandler()');
  }

  void emailChangedHandler(String email) {
    SystemLog.onInfo(info: '_SupportScreenControllerImplementation->emailChangedHandler(): ' + email);

    ref.read(SupportScreenModel.provider.notifier).setUserEmail(email);
  }

  void messageChangedHandler(String message) {
    SystemLog.onInfo(info: '_SupportScreenControllerImplementation->messageChangedHandler(): ' + message);

    ref.read(SupportScreenModel.provider.notifier).setUserMessage(message);
  }
}