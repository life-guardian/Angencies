class EventHistory {
  Location? location;
  String? sId;
  String? eventName;
  String? description;
  String? eventDate;
  String? agencyId;
  // List<Null>? registrations;
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
      // this.registrations,
      this.createdAt,
      this.updatedAt,
      this.iV});

  EventHistory.fromJson(Map<String, dynamic> json) {
    location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
    sId = json['_id'];
    eventName = json['eventName'];
    description = json['description'];
    eventDate = json['eventDate'];
    agencyId = json['agencyId'];
    if (json['registrations'] != null) {
      // registrations = <Null>[];
      json['registrations'].forEach((v) {
        // registrations!.add(v);
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
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
}
