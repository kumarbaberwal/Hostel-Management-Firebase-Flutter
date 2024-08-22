import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Future<void> deleteStaff(BuildContext context, String staffId) async {
  final scaffoldMessenger = ScaffoldMessenger.of(context);
  try {
    // Save the current admin user's email and password (you'll need to manage the password securely)
    User? currentUser = FirebaseAuth.instance.currentUser;
    DocumentSnapshot adminDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser?.uid)
        .get();
    String? adminEmail = currentUser?.email;
    String adminPassword = adminDoc[
        "Password"]; // You should securely manage and retrieve the password.

    // Retrieve the staff user's email and password from Firestore
    DocumentSnapshot staffDoc =
        await FirebaseFirestore.instance.collection('users').doc(staffId).get();
    String userEmail = staffDoc['Email'];
    String userPassword =
        staffDoc['Password']; // Assuming 'Password' field exists

    // Sign in as the staff user
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: userEmail,
      password: userPassword,
    );

    // Delete the staff user from Firebase Authentication
    User? user = userCredential.user;
    if (user != null) {
      await user.delete();
    }

    // Re-authenticate the admin user to maintain their session
    if (adminEmail != null) {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: adminEmail,
        password: adminPassword,
      );

      await FirebaseFirestore.instance
          .collection('users')
          .doc(staffId)
          .update({'status': 'Deleted'});
      scaffoldMessenger.showSnackBar(
        const SnackBar(content: Text("Staff deleted successfully")),
      );
    }
  } catch (e) {
    scaffoldMessenger.showSnackBar(
      SnackBar(content: Text("Failed to delete Staff: $e")),
    );
  }
}
