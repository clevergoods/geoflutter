import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:true_flutter/src/presentation/support/models/support_screen_model_state.dart';

class SupportScreenModelStateNotifier extends StateNotifier<SupportScreenModelState> {
  SupportScreenModelStateNotifier(SupportScreenModelState state)
      : super(state);

  void setUserEmail(String userEmail) {
    state = state.copyWith(userEmail: userEmail);
  }

  void setUserMessage(String userMessage) {
    state = state.copyWith(userMessage: userMessage);
  }

  void attachFile() {
    state = state.copyWith(hasAttachedFile: true);
  }

  void removeAttachedFile() {
    state = state.copyWith(hasAttachedFile: false);
  }
}