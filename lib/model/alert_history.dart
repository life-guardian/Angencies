class AlertHistory {
  AlertLocation? alertLocation;
  String? alertId;
  String? locality;
  String? alertName;
  String? alertSeverity;
  String? alertForDate;
  String? agencyId;
  List<String>? receivers;
  String? createdAt;
  String? updatedAt;
  int? iV;

  AlertHistory(
      {this.alertLocation,
      this.alertId,
      this.alertName,
      this.alertSeverity,
      this.alertForDate,
      this.agencyId,
      this.receivers,
      this.createdAt,
      this.updatedAt,
      this.iV});

  AlertHistory.fromJson(Map<String, dynamic> json) {
    alertLocation = json['alertLocation'] != null
        ? AlertLocation.fromJson(json['alertLocation'])
        : null;
    alertId = json['_id'];
    alertName = json['alertName'];
    alertSeverity = json['alertSeverity'];
    alertForDate = json['alertForDate'];
    agencyId = json['agencyId'];
    receivers = json['receivers'].cast<String>();
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }
}

class AlertLocation {
  String? type;
  List<double>? coordinates;

  AlertLocation({this.type, this.coordinates});

  AlertLocation.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'].cast<double>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['coordinates'] = coordinates;
    return data;
  }
}
