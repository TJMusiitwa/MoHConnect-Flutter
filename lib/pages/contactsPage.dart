import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:moh_connect/models/contact.dart';
import 'package:moh_connect/scoped_model/contacts_scoped_model.dart';
import 'package:moh_connect/services/contacts_repo.dart';
import 'package:moh_connect/utils/moh_drawer.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class ContactsPage extends StatefulWidget {
  final ContactsScopedModel contactsScopedModel;

  const ContactsPage({Key key, this.contactsScopedModel}) : super(key: key);

  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  Future<Contact> futureContacts;
  List<Contact> returnedContacts = [];
  var isLoading = false;

  fetchContacts() async {
    setState(() {
      isLoading = true;
    });
    final response = await http
        .get('http://15.188.180.73:8080/YCSR/webapi/requests/contacts')
        .catchError((error) => throw (error));

    if (response.statusCode == 200) {
      returnedContacts = (json.decode(response.body) as List)
          .map((data) => Contact.fromJson(data))
          .toList();
      setState(() {
        isLoading = false;
      });
      //return Contact.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load contacts');
    }
  }

  void listenForContacts() async {
    final Stream<Contact> stream = await getContacts();
    stream.listen((Contact contact) {
      setState(() {
        returnedContacts.add(contact);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    listenForContacts();
    //futureContacts = fetchContacts();
    //widget.contactsScopedModel.fetchRegionalContacts();
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: PlatformText('Contacts'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        itemCount: returnedContacts.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: PlatformText(returnedContacts[index].region),
            subtitle: PlatformText(returnedContacts[index].contact),
            trailing: PlatformIconButton(
              androidIcon: Icon(Icons.call),
              iosIcon: Icon(CupertinoIcons.phone),
              onPressed: () {
                var phone = 'tel:' + returnedContacts[index].contact;
                launch(phone);
              },
            ),
          );
        },
      ),
      android: (_) => MaterialScaffoldData(
        drawer: MoHConnectDrawer(),
      ),
      ios: (_) => CupertinoPageScaffoldData(
        bottomTabBar: CupertinoTabBar(items: []),
      ),
    );
  }
}
