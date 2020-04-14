// To parse this JSON data, do
//
//     final countryData = countryDataFromJson(jsonString);

import 'dart:convert';

List<CountryData> countryDataFromJson(String str) => List<CountryData>.from(
    json.decode(str).map((x) => CountryData.fromJson(x)));

String countryDataToJson(List<CountryData> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CountryData {
  String country;
  int confirmed;
  int deaths;
  int recovered;
  int active;
  DateTime date;

  CountryData({
    this.country,
    this.confirmed,
    this.deaths,
    this.recovered,
    this.active,
    this.date,
  });

  factory CountryData.fromJson(Map<String, dynamic> json) => CountryData(
        country: json["Country"],
        confirmed: json["Confirmed"],
        deaths: json["Deaths"],
        recovered: json["Recovered"],
        active: json["Active"],
        date: DateTime.parse(json["Date"]),
      );

  Map<String, dynamic> toJson() => {
        "Country": country,
        "Confirmed": confirmed,
        "Deaths": deaths,
        "Recovered": recovered,
        "Active": active,
        "Date": date.toIso8601String(),
      };
}
