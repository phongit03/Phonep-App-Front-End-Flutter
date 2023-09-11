import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phoneapp/service/contacts_service.dart';

import '../contact_model.dart';

class ContactsModel extends ChangeNotifier {

  late Future<List<Contact>> futureContacts = fetchContacts();

  late Future<List<Contact>> searchResults = searchContactsByValue("");

  Future<List<Contact>> fetchContacts() async {

    return await ContactsService.fetchAllContacts();

  }

  Future<List<Contact>> searchContactsByValue(String value) async {

    final results = await ContactsService.getContactsBySearchValue(value);

    return results;

  }



}