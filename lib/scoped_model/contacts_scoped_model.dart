import 'dart:convert';

import 'package:moh_connect/models/contact.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

class ContactsScopedModel extends Model {
  bool _isLoading = false;
  bool get isLoading {
    return _isLoading;
  }

  List<Contact> contacts = [];

  void fetchRegionalContacts() async {
    _isLoading = true;
    notifyListeners();
    try {
      http.Response response = await http
          .get('http://15.188.180.73:8080/YCSR/webapi/requests/contacts');
      if (response.statusCode == 200 || response.statusCode == 201) {
        final List<Contact> fetchedRegionalContacts = [];
        List<dynamic> responseData = jsonDecode(response.body);
        responseData?.forEach((dynamic contactData) {
          final Contact contact = Contact(
              contact: contactData['contact'], region: contactData['region']);
          fetchedRegionalContacts.add(contact);
        });
        contacts = fetchedRegionalContacts;
        print(response.body);
      } else {
        throw Exception('Failed to load regional contacts');
      }
      _isLoading = false;
      notifyListeners();
    } catch (error) {
      _isLoading = false;
      notifyListeners();
    }
  }
}
