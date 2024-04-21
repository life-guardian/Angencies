class RescueOperationHistory {
  AgencyLocation? agencyLocation;
  String? sId;
  String? name;
  String? locality;
  String? description;
  String? agencyId;
  int? rescueTeamSize;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? iV;

  RescueOperationHistory(
      {this.agencyLocation,
      this.sId,
      this.name,
      this.description,
      this.agencyId,
      this.rescueTeamSize,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.iV});

  RescueOperationHistory.fromJson(Map<String, dynamic> json) {
    agencyLocation = json['agencyLocation'] != null
        ? AgencyLocation.fromJson(json['agencyLocation'])
        : null;
    sId = json['_id'];
    name = json['name'];
    description = json['description'];
    agencyId = json['agencyId'];
    rescueTeamSize = json['rescueTeamSize'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (agencyLocation != null) {
      data['agencyLocation'] = agencyLocation!.toJson();
    }
    data['_id'] = sId;
    data['name'] = name;
    data['description'] = description;
    data['agencyId'] = agencyId;
    data['rescueTeamSize'] = rescueTeamSize;
    data['status'] = status;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class AgencyLocation {
  String? type;
  List<double>? coordinates;

  AgencyLocation({this.type, this.coordinates});

  AgencyLocation.fromJson(Map<String, dynamic> json) {
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
