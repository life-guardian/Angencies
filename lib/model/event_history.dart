class EventHistory {
  Location? location;
  String? sId;
  String? locality;
  String? eventName;
  String? description;
  String? eventDate;
  String? agencyId;
  List<String>? registrations;
  String? createdAt;
  String? updatedAt;
  int? iV;

  EventHistory(
      {this.location,
      this.sId,
      this.eventName,
      this.description,
      this.eventDate,
      this.agencyId,
      this.registrations,
      this.createdAt,
      this.updatedAt,
      this.iV});

  EventHistory.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null
        ? Location.fromJson(json['location'])
        : null;
    sId = json['_id'];
    eventName = json['eventName'];
    description = json['description'];
    eventDate = json['eventDate'];
    agencyId = json['agencyId'];
    registrations = json['registrations'].cast<String>();
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (location != null) {
      data['location'] = location!.toJson();
    }
    data['_id'] = sId;
    data['eventName'] = eventName;
    data['description'] = description;
    data['eventDate'] = eventDate;
    data['agencyId'] = agencyId;
    data['registrations'] = registrations;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class Location {
  String? type;
  List<double>? coordinates;

  Location({this.type, this.coordinates});

  Location.fromJson(Map<String, dynamic> json) {
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
