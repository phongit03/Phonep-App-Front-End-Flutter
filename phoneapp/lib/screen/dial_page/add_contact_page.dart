import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phoneapp/screen/home.dart';

import 'package:phoneapp/service/contacts_service.dart';

import '../../models/contact_model.dart';

class AddContactPage extends StatefulWidget {
  final Contact? contact;

  final String? phoneNumber;

  const AddContactPage({super.key, this.phoneNumber, this.contact});

  @override
  State<AddContactPage> createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {

  TextEditingController firstNameController = TextEditingController();
  
  TextEditingController lastNameController = TextEditingController();
  
  TextEditingController phoneNumberController = TextEditingController();

  bool isEdit = false;
  
  @override
  void initState() {
    
    final number = widget.phoneNumber;
    
    final contact = widget.contact;
    
    if(number != null && contact == null) {
      phoneNumberController.text = number;
    }
    
    else if(contact != null) {
      firstNameController.text = contact.firstName;
    
      lastNameController.text = contact.lastName;
    
      if(number != null) {
        phoneNumberController.text = number;
      }
      else {
        phoneNumberController.text = contact.phoneNumber;
      }
      
      isEdit = true;
    }
   
    super.initState();
    
  }
  @override
  Widget build(BuildContext context) {

    return 
      
         Scaffold(
           body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancel", 
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.blue
                    ),
                ),
                ),
                
                if(widget.contact == null) const Text(
                  "Add new contact",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15
                  ),
                ),
      
                TextButton(
                onPressed:  isEdit ? () => editContact(context) :() => saveContact(context), 
                child: isEdit ? 
                const Text("Update", 
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.blue
                    ),
                  )
                : const Text("Done", 
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.blue
                    ),
                  ),
                ),
                
              ],
            ),
              TextField(
              controller: firstNameController,
              decoration: const InputDecoration(
                hintText: "First name",
                filled: true,
                fillColor: Colors.white
              ),
              ),
      
              TextField(
              controller: lastNameController,
              decoration: const InputDecoration(
                hintText: "Last name",
                filled: true,
                fillColor: Colors.white
              ),
      
              ),
      
              TextField(
              controller: phoneNumberController,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white
                ),
              ),
      
              if(widget.contact != null) TextButton(
                onPressed: () => deleteThisContact(context,widget.contact!.id.toString()),
                style: ButtonStyle(
                  backgroundColor: MaterialStateColor.resolveWith((states) => Colors.white),
                ), 
                child: const Text(
                  "Delete this contact",
                  style: TextStyle(
                     fontSize: 15, 
                     color: Colors.red,
                  ),
                ),
              )
            ],
           ),
         );
      
   
   
  
  }

  Future<void> saveContact(BuildContext context) async {
    final firstName = firstNameController.text;
    
    final lastName = lastNameController.text;
    
    final phoneNumber = phoneNumberController.text;
    
    final body = {
      "firstName": firstName,

      "lastName": lastName,

      "phoneNumber": phoneNumber
    };

    await ContactsService.addNewContact(body);

    if(mounted) {
       Navigator.of(context).pop();
    }
  
  }
  
  Future<void> editContact(BuildContext context) async {
    final contact = widget.contact;

    if(contact == null) {
      return;
    }

    final id = contact.id.toString();

    final firstName = firstNameController.text;

    final lastName = lastNameController.text;

    final phoneNumber = phoneNumberController.text;

    final body = {
      "firstName": firstName,

      "lastName": lastName,

      "phoneNumber": phoneNumber
    };

    final isUpdated = await ContactsService.editContact(id, body);

    if(isUpdated) {
      print("Update contact successfully!");
    }
    else {
      print("Updated Failed!");
    }
    if(mounted) {
       Navigator.of(context).pop();
    }
  }
  
  Future<void> deleteThisContact( BuildContext context, String id) async {
    final isDeleted = await ContactsService.deleteContactById(id);
    
     if(isDeleted) {
      print("Delete contact successfully!");
    }
    else {
      print("Delete Failed!");
    }

    if(mounted) {
       Navigator.of(context).pop();
    }
  }
  
  Future<String> asignNewNumber(int id, String number) async{
    return await ContactsService.editPhoneNumber(id, number);

  }
}