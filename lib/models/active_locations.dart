class LiveAgencies {
  double? lat;
  double? lng;
  String? agencyId;
  String? agencyName;
  int? phoneNumber;
  String? representativeName;
  String? rescueOpsName;
  String? rescueOpsDescription;
  int? rescueTeamSize;

  LiveAgencies(
      {this.lat,
        this.lng,
        this.agencyId,
        this.agencyName,
        this.phoneNumber,
        this.representativeName,
        this.rescueOpsName,
        this.rescueOpsDescription,
        this.rescueTeamSize,});

  LiveAgencies.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
    agencyId = json['agencyId'];
    agencyName = json['agencyName'];
    phoneNumber = json['phoneNumber'];
    representativeName = json['representativeName'];
    rescueOpsName = json['rescueOpsName'];
    rescueOpsDescription = json['rescueOpsDescription'];
    rescueTeamSize = json['rescueTeamSize'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['lat'] = lat;
    data['lng'] = lng;
    data['agencyId'] = agencyId;
    data['agencyName'] = agencyName;
    data['phoneNumber'] = phoneNumber;
    data['representativeName'] = representativeName;
    data['rescueOpsName'] = rescueOpsName;
    data['rescueOpsDescription'] = rescueOpsDescription;
    data['rescueTeamSize'] = rescueTeamSize;
    return data;
  }
}