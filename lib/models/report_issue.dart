class ReportIssue {
  String phoneNumber;
  String description;
  String lat;
  String lon;
  String location;
  List<String> symptoms;

  ReportIssue(
      {this.phoneNumber,
      this.description,
      this.lat,
      this.lon,
      this.location,
      this.symptoms});

  ReportIssue.fromJson(Map<String, dynamic> json) {
    phoneNumber = json['phoneNumber'];
    description = json['description'];
    lat = json['lat'];
    lon = json['lon'];
    location = json['location'];
    symptoms = json['symptoms'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phoneNumber'] = this.phoneNumber;
    data['description'] = this.description;
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    data['location'] = this.location;
    data['symptoms'] = this.symptoms;
    return data;
  }
}
