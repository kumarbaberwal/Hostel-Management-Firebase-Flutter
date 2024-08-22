import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Future<void> createIssue(
  BuildContext context,
  uid,
  String userName,
  String firstName,
  String lastName,
  String roomNo,
  String blockNo,
  String emailAddress,
  String phoneNumber,
  String issueType,
  String issueDescription,
  String issueStatus,
  Timestamp createdAt,
) async {
  final scaffoldMessenger = ScaffoldMessenger.of(context);
  try {
    // Add a new document to the 'issues' collection with an auto-generated ID
    await FirebaseFirestore.instance.collection('issues').add({
      'uid': uid, // Store the user ID if needed for later identification
      'userName': userName,
      'firstName': firstName,
      'lastName': lastName,
      'roomNo': roomNo,
      'blockNo': blockNo,
      'emailAddress': emailAddress,
      'phoneNumber': phoneNumber,
      'issueType': issueType,
      'issueDescription': issueDescription,
      'issueStatus': issueStatus,
      'datetime': createdAt,
    });
  } catch (e) {
    // Show an error message if the creation of the issue fails
    scaffoldMessenger.showSnackBar(
      SnackBar(
        content: Text("Error saving issue data: $e"),
      ),
    );
  }
}
