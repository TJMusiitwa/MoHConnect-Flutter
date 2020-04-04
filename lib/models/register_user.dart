class User {
  String firstName;
  String lastName;
  String phoneNumber;
  String email;
  String address;
  String gender;

  User(
      {this.firstName,
      this.lastName,
      this.phoneNumber,
      this.email,
      this.address,
      this.gender});

  User.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    address = json['address'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['phoneNumber'] = this.phoneNumber;
    data['email'] = this.email;
    data['address'] = this.address;
    data['gender'] = this.gender;
    return data;
  }
}
