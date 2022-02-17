import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:true_flutter/src/presentation/support/models/support_screen_model_state.dart';
import 'package:true_flutter/src/presentation/support/models/support_screen_model_state_notifier.dart';

class SupportScreenModel {
  static final provider = StateNotifierProvider<SupportScreenModelStateNotifier, SupportScreenModelState>((ref) {
    return SupportScreenModelStateNotifier(SupportScreenModelState.empty());
  });
}