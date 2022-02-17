class SubscriptionItem{

  String id;
  int months;
  bool isFavorite;
  bool isRenewable;

  SubscriptionItem(
      {
        required this.id,
        required this.months,
        required this.isFavorite,
        required this.isRenewable,
      });

  factory SubscriptionItem.fromJson(Map<String, dynamic> json) {
    return SubscriptionItem(
        id: json['id'].toString(),
        months: json['months'].toInt(),
        isFavorite: json['fav'].toBool(),
        isRenewable: json['renewable'].toBool(),
    );
  }
}