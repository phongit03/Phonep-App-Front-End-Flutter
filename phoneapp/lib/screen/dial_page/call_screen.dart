
import 'package:flutter/material.dart';
import 'package:phoneapp/models/contact_model.dart';

class CallingScreen extends StatefulWidget {
  final List<Contact> contacts;
  const CallingScreen({
        super.key,
        required this.contacts
      }
      );

  @override
  State<CallingScreen> createState() => _CallingScreenState();
}

class _CallingScreenState extends State<CallingScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.8),
      ),
      child: const Center(
        child: Text(
          "Calling...",
          style: TextStyle(
            color: Colors.white
          ),
        ),
      ),
    );


  }
}
