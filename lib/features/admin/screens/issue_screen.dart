import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piethostel/common/constants.dart';
import 'package:piethostel/common/spacing.dart';
import 'package:piethostel/features/admin/functions/resolve_issue.dart';
import 'package:piethostel/providers/user_provider.dart';
import 'package:provider/provider.dart';

class IssueCard extends StatelessWidget {
  final Map<String, dynamic> issueData;
  final bool isStudent; // Flag to check if the user is a student

  const IssueCard(
      {super.key, required this.issueData, required this.isStudent});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              heightSpacer(20),
              Container(
                decoration: ShapeDecoration(
                  gradient: LinearGradient(
                    begin: const Alignment(0, -1),
                    end: const Alignment(0, 1),
                    colors: [
                      const Color(0xff2e8b57).withOpacity(0.5),
                      const Color(0x002e8857),
                    ],
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.r),
                      topRight: Radius.circular(30.r),
                      bottomLeft: Radius.circular(30.r),
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Column(
                      children: [
                        heightSpacer(20),
                        Image.asset(
                          AppConstants.person,
                          height: 70.h,
                          width: 70.h,
                        ),
                        heightSpacer(10),
                        Text(
                          "${issueData['firstName']} ${issueData['lastName']}",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    widthSpacer(20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          heightSpacer(10),
                          Text(
                            "Username: ${issueData['userName']}",
                            style: TextStyle(
                              fontSize: 14.sp,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          heightSpacer(10),
                          Text(
                            "Room Number: ${issueData['roomNo']}",
                            style: TextStyle(
                              fontSize: 14.sp,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          heightSpacer(10),
                          Text(
                            "Email: ${issueData['emailAddress']}",
                            style: TextStyle(
                              fontSize: 14.sp,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          heightSpacer(10),
                          Text(
                            "Phone Number: ${issueData['phoneNumber']}",
                            style: TextStyle(
                              fontSize: 14.sp,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          heightSpacer(10),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.maxFinite,
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  children: [
                    Container(
                      width: double.maxFinite,
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Issue: ",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16.sp,
                                  color: Colors.black,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  issueData['issueType'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16.sp,
                                    color: Colors.black,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          heightSpacer(12),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Student Comment: ",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16.sp,
                                  color: Colors.black,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  "'${issueData['issueDescription']}'",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16.sp,
                                    color: Colors.black,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          heightSpacer(12),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Status: ",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16.sp,
                                  color: Colors.black,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  issueData['issueStatus'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16.sp,
                                    color: issueData['issueStatus'] == "Pending"
                                        ? Colors.blue
                                        : issueData['issueStatus'] == "Deleted"
                                            ? Colors.red
                                            : Colors.green,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          heightSpacer(20),
                          if (issueData['issueStatus'] == "Pending")
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: isStudent
                                      ? () {
                                          deleteIssue(
                                            context,
                                            issueData['issueId'],
                                          );
                                        }
                                      : () {
                                          resolveIssue(
                                            context,
                                            issueData['issueId'],
                                          );
                                        },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 8),
                                    width: 140.w,
                                    decoration: BoxDecoration(
                                      color: isStudent
                                          ? Colors.red.shade400
                                          : Colors.blue.shade400,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Center(
                                      child: Text(
                                        isStudent ? "Delete" : "Resolve",
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class IssueScreen extends StatefulWidget {
  const IssueScreen({super.key});

  @override
  State<IssueScreen> createState() => _IssueScreenState();
}

class _IssueScreenState extends State<IssueScreen> {
  @override
  Widget build(BuildContext context) {
    String? uid = Provider.of<UserProvider>(context).uid;
    return StreamBuilder<DocumentSnapshot>(
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
            bool isStudent = userData['role'] == "student";
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
                  isStudent ? "Your Issues" : "Student Issues",
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              body: StreamBuilder<QuerySnapshot>(
                  stream: isStudent
                      ? FirebaseFirestore.instance
                          .collection("issues")
                          .where("uid", isEqualTo: uid)
                          .snapshots()
                      : FirebaseFirestore.instance
                          .collection("issues")
                          .where("issueStatus", isEqualTo: "Pending")
                          .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return const Center(
                        child: Text("Error loading issues"),
                      );
                    } else if (!snapshot.hasData ||
                        snapshot.data!.docs.isEmpty) {
                      return const Center(
                        child: Text("No issues found"),
                      );
                    } else {
                      var issues = snapshot.data!.docs;
                      return ListView.builder(
                        padding: const EdgeInsets.all(10),
                        itemCount: issues.length,
                        itemBuilder: (context, index) {
                          var issueData =
                              issues[index].data() as Map<String, dynamic>;
                          issueData['issueId'] =
                              issues[index].id; // Add the document ID
                          return IssueCard(
                            issueData: issueData,
                            isStudent: isStudent,
                          );
                        },
                      );
                    }
                  }),
            );
          }
        });
  }
}
