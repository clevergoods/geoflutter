class SystemLog {
  static void onInfo({required String info}) {
    print(info);
  }

  static void onError({required String error}) {
    print(error);
  }
}