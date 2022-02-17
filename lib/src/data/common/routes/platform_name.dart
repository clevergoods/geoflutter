import 'dart:io' show Platform;

class PlatformName{
  static String getName(){
    if (Platform.isAndroid) {
      return 'android';
    } else if (Platform.isIOS) {
      return 'ios';
    }
    return 'other';
  }
}