import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:piethostel/features/auth/functions/staff_database_functions.dart';
import 'package:piethostel/providers/user_provider.dart';
import 'package:provider/provider.dart';

Future<void> createStaff(
  BuildContext context,
  String emailAddress,
  String password,
  String userName,
  String firstName,
  String lastName,
  String phone,
  String department,
  String status,
  String userRole,
  DateTime dateTime,
) async {
  final scaffoldMessenger = ScaffoldMessenger.of(context);
  final navigator = Navigator.of(context);
  final firebaseAuth = FirebaseAuth.instance;
  final userProvider = Provider.of<UserProvider>(context, listen: false);

  // Step 1: Save current admin credentials
  User? currentUser = firebaseAuth.currentUser;
  String? adminEmail = currentUser?.email;
  DocumentSnapshot adminDoc = await FirebaseFirestore.instance
      .collection('users')
      .doc(currentUser?.uid)
      .get();
  String adminPassword = adminDoc[
      "Password"]; // Replace with the actual admin password or retrieve securely.

  try {
    // Step 2: Create the staff user
    UserCredential userCredential =
        await firebaseAuth.createUserWithEmailAndPassword(
      email: emailAddress,
      password: password,
    );

    // Get the UID of the registered user
    String uid = userCredential.user!.uid;

    // Save the user data to Firestore
    await saveStaff(
      uid,
      emailAddress,
      password,
      userName,
      firstName,
      lastName,
      phone,
      department,
      status,
      userRole,
      dateTime,
    );

    // Step 3: Log the admin back in
    await firebaseAuth.signOut(); // Sign out the newly created staff
    await firebaseAuth.signInWithEmailAndPassword(
      email: adminEmail!,
      password: adminPassword,
    );

    // Set the uid back to the admin's UID
    userProvider.setUid(currentUser!.uid);

    // Show success message
    scaffoldMessenger.showSnackBar(
      const SnackBar(
        content: Text("Staff Added Successfully"),
      ),
    );

    // Navigate back to the home screen
    navigator.pop(); // Or replace with navigation to the admin home screen
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      scaffoldMessenger.showSnackBar(
        const SnackBar(
          content: Text("The password provided is too weak."),
        ),
      );
    } else if (e.code == 'email-already-in-use') {
      scaffoldMessenger.showSnackBar(
        const SnackBar(
          content: Text("The account already exists for that email."),
        ),
      );
    }
  } catch (e) {
    scaffoldMessenger.showSnackBar(
      const SnackBar(
        content: Text("Registration Failed"),
      ),
    );
  }
}
