import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:piethostel/features/auth/functions/database_functions.dart';
import 'package:piethostel/features/auth/screens/login_screen.dart';
import 'package:piethostel/features/home/screens/home_screen.dart';
import 'package:piethostel/providers/user_provider.dart';
import 'package:provider/provider.dart';

Future<void> login(
    BuildContext context, String emailAddress, String password) async {
  final scaffoldMessenger = ScaffoldMessenger.of(context);
  final navigator = Navigator.of(context);
  final userProvider = Provider.of<UserProvider>(context, listen: false);
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: emailAddress, password: password);

    String uid = userCredential.user!.uid;

    // Set the uid in the provider
    userProvider.setUid(uid);

    // Check if the login was successful
    if (userCredential.user != null) {
      // Navigate to the home screen
      navigator.pushReplacement(
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    } else {
      // Handle login failure
      scaffoldMessenger.showSnackBar(
        const SnackBar(content: Text('Login failed')),
      );
    }
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      scaffoldMessenger.showSnackBar(
        const SnackBar(
          content: Text("No user found for that email."),
        ),
      );
      log('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      scaffoldMessenger.showSnackBar(
        const SnackBar(
          content: Text("Wrong password provided."),
        ),
      );
      log('Wrong password provided for that user.');
    }
  }
}

Future<void> registerUser(
  BuildContext context,
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
  final scaffoldMessenger = ScaffoldMessenger.of(context);
  final navigator = Navigator.of(context);
  final userProvider = Provider.of<UserProvider>(context, listen: false);
  try {
    UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailAddress,
      password: password,
    );

    // Get the UID of the registered user
    String uid = userCredential.user!.uid;

    // Set the uid in the provider
    userProvider.setUid(uid);

    // Save the user data to Firestore
    await saveUser(
      uid,
      emailAddress,
      password,
      userName,
      firstName,
      lastName,
      phone,
      blockNo,
      roomNo,
      userRole,
      dateTime,
    );

    // Show success message
    scaffoldMessenger.showSnackBar(
      const SnackBar(
        content: Text("Registration Successful"),
      ),
    );

    // Navigate to the LoginScreen
    navigator.pushAndRemoveUntil(
      CupertinoPageRoute(
        builder: (context) => const LoginScreen(),
      ),
      (route) => false,
    );
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      scaffoldMessenger.showSnackBar(
        const SnackBar(
          content: Text("The password provided is too weak."),
        ),
      );
      log('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      scaffoldMessenger.showSnackBar(
        const SnackBar(
          content: Text("The account already exists for that email."),
        ),
      );
      log('The account already exists for that email.');
    }
  } catch (e) {
    scaffoldMessenger.showSnackBar(
      const SnackBar(
        content: Text("Registration Failed"),
      ),
    );
    log(e.toString());
  }
}
