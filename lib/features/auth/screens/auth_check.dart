import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:piethostel/features/auth/screens/login_screen.dart';
import 'package:piethostel/features/home/screens/home_screen.dart';
import 'package:piethostel/providers/user_provider.dart';
import 'package:provider/provider.dart';

class AuthCheck extends StatelessWidget {
  const AuthCheck({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Something went wrong!'));
        } else if (snapshot.hasData) {
          // User is logged in, so fetch their data
          final user = snapshot.data!;
          Provider.of<UserProvider>(context, listen: false).setUser(user.uid);

          return const HomeScreen(); // Show the home screen
        } else {
          return const LoginScreen(); // Show the login screen
        }
      },
    );
  }
}
