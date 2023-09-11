import 'package:flutter/cupertino.dart';

import '../../service/contacts_service.dart';
import '../contact_model.dart';
//    --This class handle the state of the dial page
class DialModel extends ChangeNotifier {
  String number = "";

  List<Contact> foundContacts = [];

  void sendData(String value) {
    number += value;
    notifyListeners();
  }

  void deleteNumber() {
    if(number.isNotEmpty) {
      number = number.substring(0, number.length - 1);
    }
    notifyListeners();
  }

  Future<void> getContactsByPhoneNumber(String number) async{
    foundContacts = await ContactsService.getContactByPhoneNumber(number);
    notifyListeners();
  }



}
