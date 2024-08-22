import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:piethostel/common/constants.dart';
import 'package:piethostel/common/custom_text_field.dart';
import 'package:piethostel/common/spacing.dart';
import 'package:piethostel/features/auth/screens/login_screen.dart';
import 'package:piethostel/features/auth/widgets/custom_button.dart';
import 'package:piethostel/providers/user_provider.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController userName = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String? uid = Provider.of<UserProvider>(context).uid;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green.shade800,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            CupertinoIcons.back,
            color: Colors.white,
          ),
        ),
        title: Text(
          "Profile",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24.sp,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            padding: const EdgeInsets.only(
              right: 20,
            ),
            onPressed: () async {
              final navigator = Navigator.of(context);
              final scaffoldMessenger = ScaffoldMessenger.of(context);
              await FirebaseAuth.instance.signOut();
              if (mounted) {
                scaffoldMessenger.showSnackBar(
                  const SnackBar(
                    content: Text("Logout Successful"),
                  ),
                );

                // Clear the navigation stack and navigate to LoginScreen
                navigator.pushAndRemoveUntil(
                  CupertinoPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                  (Route<dynamic> route) =>
                      false, // This removes all the previous routes
                );
              }
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream:
            FirebaseFirestore.instance.collection('users').doc(uid).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("Error loading data"),
            );
          } else if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(
              child: Text("User data not found"),
            );
          } else {
            var userData = snapshot.data!.data() as Map<String, dynamic>;
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: userData['role'] == "admin"
                    ? Column(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: SvgPicture.asset(
                              AppConstants.profile,
                              height: 180.h,
                              width: 180.w,
                            ),
                          ),
                          heightSpacer(10),
                          Text(
                            "You are an Admin",
                            style: TextStyle(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            AppConstants.profile,
                            height: 180.h,
                            width: 180.w,
                          ),
                          heightSpacer(10),
                          Text(
                            userData['userName'],
                            style: TextStyle(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          heightSpacer(30),
                          if (userData['role'] == "student")
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.all(12),
                                    width: double.maxFinite,
                                    decoration: ShapeDecoration(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(14),
                                        side: BorderSide(
                                            width: 1,
                                            color: Colors.green.shade800),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        "Room No - ${userData['roomNo']}",
                                        style: TextStyle(fontSize: 17.sp),
                                      ),
                                    ),
                                  ),
                                ),
                                widthSpacer(30),
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.all(12),
                                    width: double.maxFinite,
                                    decoration: ShapeDecoration(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(14),
                                        side: BorderSide(
                                            width: 1,
                                            color: Colors.green.shade800),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        "Block No - ${userData['blockNo']}",
                                        style: TextStyle(fontSize: 17.sp),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          if (userData['role'] == "student") heightSpacer(20),
                          Container(
                            padding: const EdgeInsets.all(12),
                            width: double.maxFinite,
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                                side: BorderSide(
                                    width: 1, color: Colors.green.shade800),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                userData['Email'],
                                style: TextStyle(fontSize: 17.sp),
                              ),
                            ),
                          ),
                          heightSpacer(20),
                          CustomTextField(
                            controller: userName,
                            inputKeyBoardType: TextInputType.name,
                            inputHint: userData['userName'],
                            prefixIcon: const Icon(Icons.person_2_outlined),
                          ),
                          heightSpacer(20),
                          CustomTextField(
                            controller: phoneNumber,
                            inputKeyBoardType: TextInputType.phone,
                            inputHint: userData['phoneNumber'],
                            prefixIcon: const Icon(Icons.phone),
                          ),
                          heightSpacer(20),
                          Row(
                            children: [
                              Expanded(
                                child: CustomTextField(
                                  controller: firstName,
                                  inputKeyBoardType: TextInputType.name,
                                  inputHint: userData['firstName'],
                                ),
                              ),
                              widthSpacer(20),
                              Expanded(
                                child: CustomTextField(
                                  controller: lastName,
                                  inputKeyBoardType: TextInputType.name,
                                  inputHint: userData['lastName'],
                                ),
                              ),
                            ],
                          ),
                          heightSpacer(30),
                          CustomButton(
                            buttonText: "Save",
                            onTap: () {
                              if (firstName.text.trim().isEmpty &&
                                  lastName.text.trim().isEmpty &&
                                  phoneNumber.text.trim().isEmpty &&
                                  userName.text.trim().isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content:
                                        Text("Please fill at least one field"),
                                  ),
                                );
                              } else {
                                updateUserData(userData);
                              }
                            },
                          )
                        ],
                      ),
              ),
            );
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    firstName.dispose();
    lastName.dispose();
    phoneNumber.dispose();
    userName.dispose();
    super.dispose();
  }

  void updateUserData(Map<String, dynamic> userData) async {
    String? uid = Provider.of<UserProvider>(context, listen: false).uid;

    final scaffoldMessenger = ScaffoldMessenger.of(context);

    // Check if text fields have new data; otherwise, use the old data
    final updatedData = {
      'userName': userName.text.isNotEmpty
          ? userName.text.trim()
          : userData['userName'],
      'firstName': firstName.text.isNotEmpty
          ? firstName.text.trim()
          : userData['firstName'],
      'lastName': lastName.text.isNotEmpty
          ? lastName.text.trim()
          : userData['lastName'],
      'phoneNumber': phoneNumber.text.isNotEmpty
          ? phoneNumber.text.trim()
          : userData['phoneNumber'],
    };

    try {
      // Update Firestore with the new or old data
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .update(updatedData);

      // Show a success message
      scaffoldMessenger.showSnackBar(
        const SnackBar(
          content: Text("Profile data has been updated"),
        ),
      );

      // Clear the text fields after saving the data
      userName.clear();
      phoneNumber.clear();
      firstName.clear();
      lastName.clear();
    } catch (e) {
      // Show an error message if the update fails
      scaffoldMessenger.showSnackBar(
        SnackBar(
          content: Text("Failed to update profile: $e"),
        ),
      );
    }
  }
}
