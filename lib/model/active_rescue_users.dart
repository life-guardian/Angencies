class LiveRescueUsers {
  double? lat;
  double? lng;
  String? userId;
  String? userName;
  int? phoneNumber;
  bool? isInDanger;
  String? rescueReason;

  LiveRescueUsers({
    this.lat,
    this.lng,
    this.userId,
    this.userName,
    this.phoneNumber,
    this.isInDanger,
    this.rescueReason,
  });

  LiveRescueUsers.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
    userId = json['userId'];
    userName = json['userName'];
    phoneNumber = json['phoneNumber'];
    phoneNumber = json['phoneNumber'];
    isInDanger = json['isInDanger'];
    rescueReason = json['rescueReason'];
  }
}
