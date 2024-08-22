import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piethostel/common/custom_text_field.dart';
import 'package:piethostel/common/spacing.dart';
import 'package:piethostel/features/auth/widgets/custom_button.dart';
import 'package:piethostel/features/student/functions/create_issue_database.dart';
import 'package:piethostel/providers/user_provider.dart';
import 'package:provider/provider.dart';

class CreateIssueScreen extends StatefulWidget {
  const CreateIssueScreen({super.key});

  @override
  State<CreateIssueScreen> createState() => _CreateIssueScreenState();
}

class _CreateIssueScreenState extends State<CreateIssueScreen> {
  final TextEditingController studentComment = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // Added form key
  String? selectedIssue;
  List<String> issues = [
    "Bathroom",
    "Bedroom",
    "Water",
    "Furniture",
    "Kitchen",
  ];

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
          "Create Issue",
          style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
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
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      heightSpacer(15),
                      const Text(
                        "Room Number",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
                      ),
                      heightSpacer(15),
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
                            userData['roomNo'],
                            style: TextStyle(fontSize: 17.sp),
                          ),
                        ),
                      ),
                      heightSpacer(15),
                      const Text(
                        "Block Number",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
                      ),
                      heightSpacer(15),
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
                            userData['blockNo'],
                            style: TextStyle(fontSize: 17.sp),
                          ),
                        ),
                      ),
                      heightSpacer(15),
                      const Text(
                        "Your Email Id",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
                      ),
                      heightSpacer(15),
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
                      heightSpacer(15),
                      const Text(
                        "Phone Number",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
                      ),
                      heightSpacer(15),
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
                            userData['phoneNumber'],
                            style: TextStyle(fontSize: 17.sp),
                          ),
                        ),
                      ),
                      heightSpacer(15),
                      const Text(
                        "Issue you are facing?",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
                      ),
                      heightSpacer(15),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        width: double.maxFinite,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                            side: BorderSide(
                                width: 1, color: Colors.green.shade800),
                          ),
                        ),
                        child: DropdownButton(
                          underline: const SizedBox(),
                          isExpanded: true,
                          value: selectedIssue,
                          items: issues.map(
                            (String issue) {
                              return DropdownMenuItem(
                                  value: issue, child: Text(issue));
                            },
                          ).toList(),
                          onChanged: (String? value) {
                            setState(() {
                              selectedIssue = value;
                            });
                          },
                        ),
                      ),
                      heightSpacer(15),
                      const Text(
                        "Comment",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
                      ),
                      heightSpacer(15),
                      CustomTextField(
                        controller: studentComment,
                        inputKeyBoardType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Comment is required";
                          }
                          return null;
                        },
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide:
                                const BorderSide(color: Color(0xffd1d8ff))),
                      ),
                      heightSpacer(40),
                      CustomButton(
                        buttonText: "Submit",
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            if (selectedIssue == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Please select an issue"),
                                ),
                              );
                              return;
                            }
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text("Confirmation"),
                                  content: const Text(
                                      "Are you sure you want to submit this issue?"),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text("Cancel"),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        createIssue(
                                          context,
                                          uid,
                                          userData['userName'],
                                          userData['firstName'],
                                          userData['lastName'],
                                          userData['roomNo'],
                                          userData['blockNo'],
                                          userData['Email'], // Corrected typo
                                          userData['phoneNumber'],
                                          selectedIssue!,
                                          studentComment.text.trim(),
                                          "Pending",
                                          Timestamp.now(),
                                        );
                                        // Clear form fields after submission
                                        setState(() {
                                          selectedIssue = null;
                                        });
                                        studentComment.clear();
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                                "Issue submitted successfully"),
                                          ),
                                        );
                                      },
                                      child: const Text("Submit"),
                                    ),
                                  ],
                                );
                              },
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Please complete all fields"),
                              ),
                            );
                          }
                        },
                      ),
                      heightSpacer(10),
                    ],
                  ),
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
    studentComment.dispose();
    super.dispose();
  }
}
