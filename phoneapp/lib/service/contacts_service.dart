import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/contact_model.dart';

class ContactsService {
// Get all contacts  
  static Future<List<Contact>> fetchAllContacts() async {
    final url = 'http://${Host().ipv4}:8080/api/v1/contacts';

    final uri = Uri.parse(url);
    
    final response = await http.get(uri);

      final json = jsonDecode(response.body) as List;
    
      final contactsFromJson = json.map((e)  {
        return Contact.fromMap(e);
      }); 

      final results = contactsFromJson.toList();

      return results;

  }

//  Get all contacts by Name
  static Future<List<Contact>> getContactsBySearchValue(String value) async {

      final url = 'http://${Host().ipv4}:8080/api/v1/contacts/searchValue=$value';

      final uri = Uri.parse(url);

      final response = await http.get(uri);

      final json = jsonDecode(response.body) as List;

      final contactsFromJson = json.map((e)  {
        return Contact.fromMap(e);
      });

      final results = contactsFromJson.toList();


    return results;
  }

  //  Get all contacts by phoneNumber
  static Future<List<Contact>> getContactByPhoneNumber(String number) async {
    final url = 'http://${Host().ipv4}:8080/api/v1/contacts/phoneNumber=$number';

    final uri = Uri.parse(url);

    final response = await http.get(uri);

    final json = jsonDecode(response.body) as List;

    final contactsFromJson = json.map((e)  {
      return Contact.fromMap(e);
    });

    final results = contactsFromJson.toList();


    return results;

  }

  
// Create new contact
  static Future<bool> addNewContact(Map<String, String> body) async {
    final url = 'http://${Host().ipv4}:8080/api/v1/contacts';

    final uri = Uri.parse(url);
    
    final response = await http.post(
      uri,
      
      body: jsonEncode(body),

      headers: {'Content-Type': 'application/json'},
    );

    
    return response.statusCode == 201;
  }
// Edit contact
  static Future<bool> editContact(String id, Map<String, String> body) async {
    final url = 'http://${Host().ipv4}:8080/api/v1/contacts/$id';

    final uri = Uri.parse(url);

    final response = await http.put(
      uri,

      body: jsonEncode(body),
      
      headers: {'Content-Type': 'application/json'},
    );

    return response.statusCode == 200;

  }

   static Future<String> editPhoneNumber(int id, newNumber) async {
    final url = 'http://${Host().ipv4}:8080/api/v1/contacts/$id/phoneNumber=$newNumber';

    final uri = Uri.parse(url);

    final response = await http.put(
      uri,
      
      headers: {'Content-Type': 'application/json'},
    );

    Contact newContact = jsonDecode(response.body);

    return newContact.phoneNumber;

  }
// Delete contact by id
  static Future<bool> deleteContactById(String id) async {
    final url = 'http://${Host().ipv4}:8080/api/v1/contacts/$id';

    final uri = Uri.parse(url);

    final response = await http.delete(uri);
    
    return response.statusCode == 200;
  }


}

class Host {
  String ipv4 = "192.168.1.15";
  String local = "localhost";
}


