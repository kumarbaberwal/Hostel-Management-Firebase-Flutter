import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> saveUser(
  String uid,
  String emailAddress,
  String password,
  String userName,
  String firstName,
  String lastName,
  String phone,
  String blockNo,
  String roomNo,
  String userRole,
  DateTime dateTime,
) async {
  try {
    await FirebaseFirestore.instance.collection('users').doc(uid).set(
      {
        "userName": userName,
        "firstName": firstName,
        "lastName": lastName,
        "Email": emailAddress,
        "Password": password,
        "phoneNumber": phone,
        "blockNo": blockNo,
        "roomNo": roomNo,
        "role": userRole,
        "datetime": dateTime,
      },
    );
  } catch (e) {
    log("Error saving user data: $e");
    throw Exception("Failed to save user data");
  }
}
