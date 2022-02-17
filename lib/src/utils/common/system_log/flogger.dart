

import 'package:flutter/services.dart';

class Flogger {
  static const methodChannelName = "samples.flutter.dev/method";
  static const messageChannelName = "samples.flutter.dev/message";

  final methodChannel = const MethodChannel(methodChannelName);

  Future<void> onInfo(String logTag, String message) async {
    await log('i', logTag, message);
  }

  Future<void> onError(String logTag, String message) async {
    await log('e', logTag, message);
  }

  Future<void> onDebug(String logTag, String message) async {
    await log('d', logTag, message);
  }

  Future<void> log(String logLevel, String logTag, String message) async {
    try {
      final int result = await methodChannel.invokeMethod('log',
          {"logLevel": logLevel, "logTag": logTag, "logMessage": message});
    } on PlatformException catch (e) {
      print(e.stacktrace);
    }
  }
}