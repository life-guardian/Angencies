class OperationHistory {
  AgencyLocation? agencyLocation;
  String? sId;
  String? name;
  String? description;
  String? agencyId;
  int? rescueTeamSize;
  String? createdAt;
  String? updatedAt;
  int? iV;

  OperationHistory(
      {this.agencyLocation,
      this.sId,
      this.name,
      this.description,
      this.agencyId,
      this.rescueTeamSize,
      this.createdAt,
      this.updatedAt,
      this.iV});

  OperationHistory.fromJson(Map<String, dynamic> json) {
    agencyLocation = json['agencyLocation'] != null
        ? AgencyLocation.fromJson(json['agencyLocation'])
        : null;
    sId = json['_id'];
    name = json['name'];
    description = json['description'];
    agencyId = json['agencyId'];
    rescueTeamSize = json['rescueTeamSize'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
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
}
