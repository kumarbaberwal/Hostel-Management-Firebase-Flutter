import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piethostel/common/custom_text_field.dart';
import 'package:piethostel/common/spacing.dart';
import 'package:piethostel/features/admin/functions/create_staff_functions.dart';
import 'package:piethostel/features/auth/widgets/custom_button.dart';
import 'package:piethostel/providers/user_provider.dart';
import 'package:provider/provider.dart';

class CreateStaffScreen extends StatefulWidget {
  const CreateStaffScreen({super.key});

  @override
  State<CreateStaffScreen> createState() => _CreateStaffScreenState();
}

class _CreateStaffScreenState extends State<CreateStaffScreen> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController department = TextEditingController();

  final gmailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@gmail\.com$');

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
          "Create Staff",
          style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream:
            FirebaseFirestore.instance.collection("users").doc(uid).snapshots(),
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
            return userData['role'] == "admin"
                ? SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.w, vertical: 10.h),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Username",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 16),
                            ),
                            CustomTextField(
                              controller: username,
                              inputKeyBoardType: TextInputType.name,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  borderSide:
                                      const BorderSide(color: Colors.grey)),
                              inputHint: "Enter your Username",
                              validator: (value) {
                                if (value!.trim().isEmpty) {
                                  return "Username is required";
                                } else {
                                  return null;
                                }
                              },
                            ),
                            heightSpacer(15),
                            const Text(
                              "First Name",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 16),
                            ),
                            CustomTextField(
                              controller: firstName,
                              inputKeyBoardType: TextInputType.name,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  borderSide:
                                      const BorderSide(color: Colors.grey)),
                              inputHint: "Enter your First Name",
                              validator: (value) {
                                if (value!.trim().isEmpty) {
                                  return "First Name is required";
                                } else {
                                  return null;
                                }
                              },
                            ),
                            heightSpacer(15),
                            const Text(
                              "Last Name",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 16),
                            ),
                            CustomTextField(
                              controller: lastName,
                              inputKeyBoardType: TextInputType.name,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  borderSide:
                                      const BorderSide(color: Colors.grey)),
                              inputHint: "Enter your Last Name",
                              validator: (value) {
                                if (value!.trim().isEmpty) {
                                  return "Last Name is required";
                                } else {
                                  return null;
                                }
                              },
                            ),
                            heightSpacer(15),
                            const Text(
                              "Phone Number",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 16),
                            ),
                            CustomTextField(
                              controller: phoneNumber,
                              inputKeyBoardType: TextInputType.phone,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  borderSide:
                                      const BorderSide(color: Colors.grey)),
                              inputHint: "Enter your phone number",
                              validator: (value) {
                                if (value!.trim().isEmpty) {
                                  return "Phone Number is required";
                                } else if (value.trim().length < 10) {
                                  return "Phone Number must be 10 digits";
                                } else if (value.trim().length > 10) {
                                  return "Phone Number must be 10 digits";
                                } else {
                                  return null;
                                }
                              },
                            ),
                            heightSpacer(15),
                            const Text(
                              "Email",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 16),
                            ),
                            CustomTextField(
                              controller: email,
                              inputKeyBoardType: TextInputType.emailAddress,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  borderSide:
                                      const BorderSide(color: Colors.grey)),
                              inputHint: "Enter your Email",
                              validator: (value) {
                                if (value!.trim().isEmpty) {
                                  return "Email is required";
                                } else if (!gmailRegex.hasMatch(value.trim())) {
                                  return "Invalid Email Address";
                                } else {
                                  return null;
                                }
                              },
                            ),
                            heightSpacer(15),
                            const Text(
                              "Department",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 16),
                            ),
                            CustomTextField(
                              controller: department,
                              inputKeyBoardType: TextInputType.text,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  borderSide:
                                      const BorderSide(color: Colors.grey)),
                              inputHint: "Enter your Department",
                              validator: (value) {
                                if (value!.trim().isEmpty) {
                                  return "Department is required";
                                } else {
                                  return null;
                                }
                              },
                            ),
                            heightSpacer(15),
                            const Text(
                              "Password",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 16),
                            ),
                            CustomTextField(
                              controller: password,
                              inputKeyBoardType: TextInputType.visiblePassword,
                              obscureText: true,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  borderSide:
                                      const BorderSide(color: Colors.grey)),
                              inputHint: "Enter your password",
                              validator: (value) {
                                if (value!.trim().isEmpty) {
                                  return "Password is required";
                                } else {
                                  return null;
                                }
                              },
                            ),
                            heightSpacer(40),
                            CustomButton(
                                buttonText: "Create Staff",
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    createStaff(
                                      context,
                                      email.text.trim(),
                                      password.text.trim(),
                                      username.text.trim(),
                                      firstName.text.trim(),
                                      lastName.text.trim(),
                                      phoneNumber.text.trim(),
                                      department.text.trim(),
                                      "Active",
                                      "staff",
                                      DateTime.now(),
                                    );
                                  }
                                }),
                          ],
                        ),
                      ),
                    ),
                  )
                : const Center(
                    child:
                        Text("You don't have a permission to view this page"),
                  );
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    username.dispose();
    firstName.dispose();
    lastName.dispose();
    phoneNumber.dispose();
    department.dispose();
    super.dispose();
  }
}
