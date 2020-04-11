import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:moh_connect/models/symptom_model.dart';
import 'package:moh_connect/services/contacts_repo.dart';
import 'package:moh_connect/utils/moh_drawer.dart';

class SymptomsPage extends StatefulWidget {
  @override
  _SymptomsPageState createState() => _SymptomsPageState();
}

class _SymptomsPageState extends State<SymptomsPage> {
  Future<Symptoms> futureSymptoms;
  List<Symptoms> returnedSymptoms = [];
  var isLoading = false;

  fetchSymptoms() async {
    setState(() {
      isLoading = true;
    });

    final response = await http
        .get('http://15.188.180.73:8080/YCSR/webapi/requests/contacts')
        .catchError((error) => throw (error));

    if (response.statusCode == 200) {
      returnedSymptoms = (json.decode(response.body) as List)
          .map((data) => Symptoms.fromJson(data))
          .toList();
      setState(() {
        isLoading = false;
      });
      //return Contact.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load symptoms');
    }
  }

  void listenForSymptoms() async {
    final Stream<Symptoms> stream = await getSymptoms();
    stream.listen((Symptoms symptoms) {
      setState(() {
        returnedSymptoms.add(symptoms);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    listenForSymptoms();
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: PlatformText('Symptoms'),
      ),
      body: Material(
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          itemCount: returnedSymptoms.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: Text(index.toString()),
              title: Text(returnedSymptoms[index].description),
            );
          },
        ),
      ),
      android: (_) => MaterialScaffoldData(
        drawer: MoHConnectDrawer(),
      ),
    );
  }
}
