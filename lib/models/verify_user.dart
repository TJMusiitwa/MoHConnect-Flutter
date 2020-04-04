class VerifyUser {
  Client client;
  bool response;

  VerifyUser({this.client, this.response});

  VerifyUser.fromJson(Map<String, dynamic> json) {
    client =
        json['client'] != null ? new Client.fromJson(json['client']) : null;
    response = json['response'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.client != null) {
      data['client'] = this.client.toJson();
    }
    data['response'] = this.response;
    return data;
  }
}

class Client {
  String dateCreated;
  String dateUpdated;
  String id;
  String status;
  String address;
  String email;
  String firstName;
  String gender;
  String lastName;
  String phoneNumber;

  Client(
      {this.dateCreated,
      this.dateUpdated,
      this.id,
      this.status,
      this.address,
      this.email,
      this.firstName,
      this.gender,
      this.lastName,
      this.phoneNumber});

  Client.fromJson(Map<String, dynamic> json) {
    dateCreated = json['dateCreated'];
    dateUpdated = json['dateUpdated'];
    id = json['id'];
    status = json['status'];
    address = json['address'];
    email = json['email'];
    firstName = json['firstName'];
    gender = json['gender'];
    lastName = json['lastName'];
    phoneNumber = json['phoneNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dateCreated'] = this.dateCreated;
    data['dateUpdated'] = this.dateUpdated;
    data['id'] = this.id;
    data['status'] = this.status;
    data['address'] = this.address;
    data['email'] = this.email;
    data['firstName'] = this.firstName;
    data['gender'] = this.gender;
    data['lastName'] = this.lastName;
    data['phoneNumber'] = this.phoneNumber;
    return data;
  }
}
