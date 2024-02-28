class RegisteredUsers {
  String? userName;
  int? phoneNumber;

  RegisteredUsers({this.userName, this.phoneNumber});

  RegisteredUsers.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    phoneNumber = json['phoneNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userName'] = userName;
    data['phoneNumber'] = phoneNumber;
    return data;
  }
}
