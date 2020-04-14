import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:moh_connect/models/report_issue.dart';
import 'package:http/http.dart' as http;

class ReportPage extends StatefulWidget {
  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  final _reportFormKey = GlobalKey<FormState>();
  final _reportScaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _descriptionController,
      _locationController,
      _symptomsController;
  Position _currentPosition;
  String _currentLocation;
  Future<ReportIssue> report;

  final Geolocator geolocator = Geolocator()
    ..forceAndroidLocationManager = true;

  void _getUserLocation() async {
    try {
      geolocator
        // ..checkGeolocationPermissionStatus(
        //     locationPermission: GeolocationPermission.locationWhenInUse)
        ..getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
            .then((Position position) {
          setState(() {
            _currentPosition = position;
          });
          //_getLocationFromLatLng();
        });
    } catch (e) {
      Exception(e.toString());
    }
  }

  // void _getLocationFromLatLng() async {
  //   try {
  //     List<Placemark> p = await geolocator.placemarkFromCoordinates(
  //         _currentPosition.latitude, _currentPosition.longitude);
  //     Placemark place = p[0];
  //     setState(() {
  //       _currentLocation =
  //           "${place.subThoroughfare},${place.thoroughfare}, ${place.locality}, ${place.administrativeArea}";
  //     });
  //   } catch (e) {
  //     Exception(e.toString());
  //   }
  // }

  @override
  void initState() {
    super.initState();
    _getUserLocation();
    //_getLocationFromLatLng();
    _descriptionController = TextEditingController(text: '');
    _locationController = TextEditingController(text: '');
    _symptomsController = TextEditingController(text: '');
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _locationController.dispose();
    _symptomsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      key: _reportScaffoldKey,
      appBar: PlatformAppBar(
        title: PlatformText('Report Your Issue'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Column(
          children: <Widget>[
            Text(
              'Please use this form to report any issues or symptoms',
              style: CupertinoTheme.of(context).textTheme.textStyle,
              textAlign: TextAlign.justify,
            ),
            SizedBox(
              height: 25.0,
            ),
            Form(
              key: _reportFormKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _locationController,
                    //initialValue: _currentLocation,
                    decoration: InputDecoration(
                      labelText: 'Location',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  // Visibility(
                  //   child: Text(_currentLocation),
                  //   visible: false,
                  // ),
                  SizedBox(
                    height: 25.0,
                  ),
                  TextFormField(
                    controller: _descriptionController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.text,
                    validator: (descValue) {
                      if (descValue.isEmpty) {
                        return 'Please provide a description';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  TextFormField(
                    controller: _symptomsController,
                    maxLines: 2,
                    decoration: InputDecoration(
                      labelText: 'Symptoms',
                      hintText: 'Please enter your symptoms',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.text,
                    validator: (symptomsValue) {
                      if (symptomsValue.isEmpty) {
                        return 'Please provide your symptoms';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  PlatformButton(
                    child: PlatformText('Submit'),
                    android: (_) => MaterialRaisedButtonData(),
                    ios: (_) => CupertinoButtonData(),
                    onPressed: () async {
                      if (_reportFormKey.currentState.validate()) {
                        report = sendReport(
                            '+256788040993',
                            _descriptionController.text,
                            _currentPosition.latitude.toString(),
                            _currentPosition.longitude.toString(),
                            _currentLocation,
                            [_symptomsController.text].toList());
                      } else {
                        print('Form  is not valid');
                      }
                      _reportScaffoldKey.currentState.showSnackBar(SnackBar(
                        content: Text(
                            'Thank you for your report. We shall contact you ASAP'),
                        backgroundColor: Colors.green,
                      ));
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      iosContentPadding: true,
    );
  }

  Future<ReportIssue> sendReport(String phoneNumber, String description,
      String lat, String lon, String location, List<String> symptoms) async {
    final reportUrl = 'http://15.188.180.73:8080/YCSR/webapi/requests/issue';
    final http.Response response = await http.post(reportUrl,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, dynamic>{
          "phoneNumber": phoneNumber,
          "description": description,
          "lat": lat,
          "lon": lon,
          "location": location,
          "symptoms": symptoms,
        }));

    if (response.statusCode == 200) {
      return ReportIssue.fromJson(json.decode(response.body));
      //_reportFormKey.currentState.reset();
    } else {
      throw Exception('Failed to send your report');
    }
  }
}
