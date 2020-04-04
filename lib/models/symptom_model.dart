class Symptoms {
  String type;
  String id;
  String description;

  Symptoms({this.type, this.id, this.description});

  Symptoms.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    id = json['id'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['id'] = this.id;
    data['description'] = this.description;
    return data;
  }
}
