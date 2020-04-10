import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:moh_connect/models/contact.dart';
import 'package:moh_connect/models/symptom_model.dart';

Future<Stream<Contact>> getContacts() async {
  final String url = 'http://15.188.180.73:8080/YCSR/webapi/requests/contacts';

  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', Uri.parse(url)));

  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .expand((data) => (data as List))
      .map((data) => Contact.fromJson(data));
}

Future<Stream<Symptoms>> getSymptoms() async {
  final String url = 'http://15.188.180.73:8080/YCSR/webapi/requests/symptoms';

  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', Uri.parse(url)));

  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .expand((data) => (data as List))
      .map((data) => Symptoms.fromJson(data));
}
