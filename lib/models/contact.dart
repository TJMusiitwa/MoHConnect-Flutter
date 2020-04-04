class Contact {
  String contact;
  String region;

  Contact({this.contact, this.region});

  Contact.fromJson(Map<String, dynamic> json) {
    contact = json['contact'];
    region = json['region'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['contact'] = this.contact;
    data['region'] = this.region;
    return data;
  }
}
