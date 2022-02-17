extension ParseBool on String {
  bool parseBool() {
    return this.toLowerCase() == 'true';
  }
}

extension ParseNumbers on String {
  int parseInt() {
    return int.parse(this);
  }
  double parseDouble() {
    return double.parse(this);
  }
}
