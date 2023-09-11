
class Contact{
  final int id;

  final String firstName;

  final String lastName;

  final String phoneNumber;

  Contact({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber
  });

  String get getFullName {
    return '$firstName $lastName';
  }

  factory Contact.fromMap(Map<String, dynamic> e) {
    return Contact(
      id: e["id"], 
      firstName: e["firstName"], 
      lastName: e["lastName"], 
      phoneNumber: e["phoneNumber"]
    );
  }

}