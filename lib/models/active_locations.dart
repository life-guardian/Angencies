// ignore_for_file: prefer_collection_literals

class LiveAgencies {
  double? lat;
  double? lng;
  String? agencyId;
  String? userName;
  int? phoneNumber;
  String? representativeName; 
  String? rescueOpsName; // can be null
  String? rescueOpsDescription; // can be null
  int? rescueTeamSize; // can be null

  LiveAgencies(
      {this.lat,
        this.lng,
        this.agencyId,
        this.userName,
        this.phoneNumber,
        this.representativeName,
        this.rescueOpsName,
        this.rescueOpsDescription,
        this.rescueTeamSize,});

  LiveAgencies.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
    agencyId = json['agencyId'];
    userName = json['userName'];
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
    data['userName'] = userName;
    data['phoneNumber'] = phoneNumber;
    data['representativeName'] = representativeName;
    data['rescueOpsName'] = rescueOpsName;
    data['rescueOpsDescription'] = rescueOpsDescription;
    data['rescueTeamSize'] = rescueTeamSize;
    return data;
  }
}