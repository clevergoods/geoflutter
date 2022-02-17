enum InnerDeviceType {
  CONTACT,
  TRACKER,
  WATCH_ANDROID
}

extension DeviceTypeExtension on InnerDeviceType {
  String get value {
    switch (this) {
      case InnerDeviceType.CONTACT:
        return '0.contact';
      case InnerDeviceType.TRACKER:
        return '1.tracker';
      case InnerDeviceType.WATCH_ANDROID:
        return '2.androidwatch';
      default:
        return '';
    }
  }
}