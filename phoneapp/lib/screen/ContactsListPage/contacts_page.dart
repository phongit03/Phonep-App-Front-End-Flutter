
import 'package:flutter/material.dart';
import 'package:phoneapp/models/stateModels/ContactsModel.dart';

import 'package:phoneapp/screen/dial_page/add_contact_page.dart';
import 'package:provider/provider.dart';
import '../../models/contact_model.dart';
import '../../service/contacts_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ContactsPage extends StatefulWidget {
  final String? value, number;

  const ContactsPage({
    this.value,
    this.number,
    super.key
  });

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {

  TextEditingController searchContactController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(30)
              )
        ),      
        title:  Visibility(
          visible: widget.number == null,
          replacement: Center(
            child: Text(
              AppLocalizations.of(context)!.contacts,
              style: const TextStyle(
              color: Colors.black,
              fontSize: 35,
              ),
            ),
          ),
          child: Text(
            AppLocalizations.of(context)!.list,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 35,
            ),
          ),
        ),
      
        backgroundColor: Colors.white,       
      ),
      body: Column(
            children: [
              Consumer<ContactsModel>(
                builder: (_,contacts, child) => TextField(
                  controller: searchContactController,
                  onChanged: (value) {
                    setState(() {
                      contacts.searchResults = contacts.searchContactsByValue(value);
                    });
                  },
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: AppLocalizations.of(context)!.search,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)
                    ),
                  ),
                ),
              ),

        
              Consumer<ContactsModel>(
                builder: (context, contacts, child) => FutureBuilder<List<Contact>?>(
                  future: searchContactController.text.isEmpty? contacts.futureContacts : contacts.searchResults,
                  builder: (_,snapshot) {
                        if(snapshot.hasData) {
                          final optionalLength =  snapshot.data!.length;
                          var list = snapshot.data!;
                          return Flexible(
                            child: RefreshIndicator(
                              onRefresh: () {
                                return contacts.futureContacts;
                              },
                              child: ListView.builder(
                                shrinkWrap: true,
                                padding: const EdgeInsets.all(8),
                                itemCount: optionalLength,
                                itemBuilder: (_,  index) {
                                  final contact = list[index];
                                  return TextButton(
                                    onPressed: () => navigateToEditPage(contact, widget.number),
                                    child: Card(
                                      child: ListTile(
                                        title: Text(contact.getFullName),
                                        subtitle: widget.number == null? Text(contact.phoneNumber) : const Text(""),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        }
                        else if(snapshot.hasError) {
                          return Text('${snapshot.error}');
                        }
                        else{
                          return const Center(child: CircularProgressIndicator(),);
                        }
                  },
                ),
              )
            ],
        ),
    );
  }

  Future<List<Contact>> fetchContacts() async {
    return await ContactsService.fetchAllContacts();
  }

  Future<void> navigateToEditPage(Contact contact, String? number) async {
    final route = MaterialPageRoute(

      builder: (context) => AddContactPage(contact: contact, phoneNumber: number),

    );

    await Navigator.push(context, route);

  }

}