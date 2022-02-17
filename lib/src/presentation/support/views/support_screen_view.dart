import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:true_flutter/src/components/specific/support/ask_in_telegram_button/support_screen_ask_in_telegram_button.dart';
import 'package:true_flutter/src/components/specific/support/attach_file_button/support_screen_attach_file_button.dart';
import 'package:true_flutter/src/components/specific/support/email_input/support_screen_email_input.dart';
import 'package:true_flutter/src/components/specific/support/message_input/support_screen_message_input.dart';
import 'package:true_flutter/src/components/specific/support/message_invitation/support_screen_message_invitation.dart';
import 'package:true_flutter/src/components/specific/support/remove_attached_file/support_screen_remove_attached_file.dart';
import 'package:true_flutter/src/components/specific/support/send_button/support_screen_send_button.dart';

import '../controllers/support_screen_controller.dart';
import '../models/support_screen_model.dart';

class SupportScreenView extends ConsumerWidget {
  const SupportScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(SupportScreenModel.provider);
    final controller = ref.watch(SupportScreenController.provider);

    return Column(
      children: [
        const SupportScreenMessageInvitation(),
        SupportScreenEmailInput(
          userEmail: model.userEmail,
          onTextChanged: controller.emailChangedHandler,
        ),
        SupportScreenMessageInput(
          userMessage: model.userMessage,
          onTextChanged: controller.messageChangedHandler,
        ),
        model.hasAttachedFile
            ? SupportScreenRemoveAttachedFile(
          onPress: controller.removeAttachedFileButtonPressHandler,
        )
            : SupportScreenAttachFileButton(
          onPress: controller.attachFileButtonPressHandler,
        ),
        SupportScreenSendButton(
          onPress: controller.sendButtonPressHandler,
        ),
        Container(
          height: 10,
        ),
        SupportScreenAskInTelegramButton(
          onPress: controller.askInTelegramButtonPressHandler,
        ),
        Expanded(
          flex: 1,
          child: Container(),
        )
      ],
    );
  }
}