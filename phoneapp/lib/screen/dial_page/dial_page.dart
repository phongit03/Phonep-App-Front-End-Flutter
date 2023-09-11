import 'package:flutter/material.dart';


import 'package:phoneapp/models/stateModels/DialModel.dart';

import 'package:phoneapp/screen/ContactsListPage/contacts_page.dart';

import 'package:phoneapp/screen/dial_page/add_contact_page.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:phoneapp/screen/dial_page/call_screen.dart';

import 'package:provider/provider.dart';

import '../../models/contact_model.dart';


class DialPage extends StatefulWidget {
  const DialPage({super.key});

  @override
  State<DialPage> createState() => _DialPageState();
}

class _DialPageState extends State<DialPage> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Consumer<DialModel>(
        builder: (_,dial,child) {
          String number = dial.number;
          List<Contact> foundContacts = dial.foundContacts;
          return Padding(
            padding: const EdgeInsets.only(
              bottom: 30,
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(number,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 35,
                          ),

                        ),

                        if(number.isNotEmpty)
                          Visibility(
                            visible: foundContacts.isEmpty,
                            replacement: displayNames(foundContacts),
                            child: PopupMenuButton (
                              offset: const Offset(-80, 25),
                              shape:  const RoundedRectangleBorder(borderRadius:BorderRadius.all(Radius.circular(10)),),
                              itemBuilder: (context) {
                                return
                                  [
                                    PopupMenuItem(
                                        value: "new",
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(AppLocalizations.of(context)!.createNewContact),
                                            const Icon(Icons.account_circle_sharp)
                                          ],
                                        )
                                    ),


                                    PopupMenuItem(
                                      value: "exist",
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(AppLocalizations.of(context)!.addExistingContact),
                                          const Icon(Icons.add_box_rounded)
                                        ],
                                      ),
                                    ),
                                  ];
                              },
                              onSelected: (value) => {
                                navigateToSlide(value, number)
                              },
                              child: Text(
                                AppLocalizations.of(context)!.addContact,
                                style: const TextStyle(
                                  color: Colors.blueAccent,
                                ),
                              ),
                            ),
                          ),

                      ],
                    ),
                  ),


                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      numberBtn("1", dial),
                      numberBtn("2", dial),
                      numberBtn("3", dial),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      numberBtn("4", dial),
                      numberBtn("5", dial),
                      numberBtn("6", dial),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      numberBtn("7", dial),
                      numberBtn("8", dial),
                      numberBtn("9", dial),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      numberBtn("*", dial),
                      numberBtn("0", dial),
                      numberBtn("#", dial),
                    ],
                  ),

                  Visibility(
                    visible: number.isNotEmpty,
                    replacement: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all(const CircleBorder()),
                                backgroundColor: MaterialStateColor.resolveWith((states) => Colors.green),
                                padding: MaterialStateProperty.all(const EdgeInsets.all(20))
                            ),
                            child: const Icon(
                              Icons.phone,
                              size: 35,
                            ),
                          ),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 8,
                              left: 60
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              callFunction(number,foundContacts);
                            },
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all(const CircleBorder()),
                                backgroundColor: MaterialStateColor.resolveWith((states) => Colors.green),
                                padding: MaterialStateProperty.all(const EdgeInsets.all(20))
                            ),
                            child: const Icon(
                              Icons.phone,
                              size: 35,
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(
                              top: 8,
                              right: 10
                          ),
                          child: IconButton(
                            icon: const Icon(
                              Icons.backspace,
                              color: Color.fromARGB(255, 146, 144, 144),
                            ),
                            onPressed: () {
                              deleteNumber(dial);

                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ]
            ),
          );
        }
      ),
    );

  }

  Widget numberBtn(String btntxt, DialModel dial) {

    return Padding(
      padding: const EdgeInsets.all(5.0),

      child: ElevatedButton(

        onPressed: () {
          dial.foundContacts.clear();
          sendData(dial, btntxt);
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateColor.resolveWith((states) => const Color.fromARGB(255, 158, 157, 157)),

          shape: MaterialStateProperty.all(const CircleBorder()),

          padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
        ),

        child: Text(
          btntxt,
          style: const TextStyle(
            fontSize: 35,
            color: Colors.black,
          ),
        ),

      ),
    );
  }

  void navigateToSlide(String value, String number) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30)
        )
      ),
      isDismissible: true,
      isScrollControlled: true,
      showDragHandle: true,
      context: context,
      useRootNavigator: true,
      builder: (context) => buildSheet(value, number),
    );
  }

  Widget buildSheet(String value, String number) => DraggableScrollableSheet(
    initialChildSize: 1,
    minChildSize: 0.5,
    maxChildSize: 1,
    builder: (_, controller) => value == "new" ? AddContactPage(phoneNumber: number) : ContactsPage(value: value, number: number,)
  );

  Future<void> callFunction(String number, List<Contact> foundContacts)async {
     final route = MaterialPageRoute(
       builder: (context) => CallingScreen(contacts: foundContacts,),
     );
     
     await Navigator.push(context, route);
  }

//  --Handle phoneNumber state--
  void sendData(DialModel dial, String btntxt)  {
    dial.sendData(btntxt);
    dial.getContactsByPhoneNumber(dial.number);
  }

  void deleteNumber(DialModel dial) {
    dial.deleteNumber();
    dial.foundContacts.clear();
    dial.getContactsByPhoneNumber(dial.number);
  }

//  --Handle found contacts state--

  Text displayNames(List<Contact> foundContacts) {

    for(Contact contact in foundContacts) {
      return Text(contact.getFullName);
    }
    return const Text("Error");
  }
}







