class EventList {
  String? eventId;
  String? eventName;
  List<double>? eventPlace;
  String? eventDate;

  EventList({this.eventId, this.eventName, this.eventPlace, this.eventDate});

  EventList.fromJson(Map<String, dynamic> json) {
    eventId = json['eventId'];
    eventName = json['eventName'];
    eventPlace = json['eventPlace'].cast<double>();
    eventDate = json['eventDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['eventId'] = eventId;
    data['eventName'] = eventName;
    data['eventPlace'] = eventPlace;
    data['eventDate'] = eventDate;
    return data;
  }
}
