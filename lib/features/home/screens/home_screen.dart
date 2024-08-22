import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:piethostel/common/constants.dart';
import 'package:piethostel/common/spacing.dart';
import 'package:piethostel/features/admin/screens/create_staff_screen.dart';
import 'package:piethostel/features/admin/screens/issue_screen.dart';
import 'package:piethostel/features/admin/screens/room_change_request_screen.dart';
import 'package:piethostel/features/admin/screens/staff_display_screen.dart';
import 'package:piethostel/features/home/screens/widgets/category_card.dart';
import 'package:piethostel/features/student/screens/create_issue_screen.dart';
import 'package:piethostel/features/student/screens/hostel_fee_screen.dart';
import 'package:piethostel/features/student/screens/profile_screen.dart';
import 'package:piethostel/features/student/screens/room_availability_screen.dart';
import 'package:piethostel/providers/user_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    String? uid = Provider.of<UserProvider>(context).uid;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Dashboard",
          style: TextStyle(
              color: Colors.black,
              fontSize: 22.sp,
              fontWeight: FontWeight.w600),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 15.w),
            child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => const ProfileScreen(),
                    ),
                  );
                },
                child: SvgPicture.asset(AppConstants.profile)),
          )
        ],
      ),
      body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(uid)
              .snapshots(),
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
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                  child: Column(
                    children: [
                      heightSpacer(20),
                      if (userData['role'] == "student")
                        Container(
                          height: 140.h,
                          width: double.maxFinite,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: const RoundedRectangleBorder(
                              side: BorderSide(width: 2, color: Colors.green),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                                bottomLeft: Radius.circular(30),
                                bottomRight: Radius.circular(2),
                              ),
                            ),
                            shadows: [
                              BoxShadow(
                                color: Colors.green.shade300,
                                blurRadius: 8,
                                offset: const Offset(2, 4),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 200.w,
                                      child: Text(
                                        userData['userName'],
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black,
                                          fontSize: 24.sp,
                                        ),
                                      ),
                                    ),
                                    heightSpacer(15),
                                    Text(
                                      "Room No. : ${userData['roomNo']}",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15.sp,
                                      ),
                                    ),
                                    Text(
                                      "Block No. : ${userData['blockNo']}",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15.sp,
                                      ),
                                    ),
                                  ],
                                ),
                                widthSpacer(10),
                                Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                            builder: (context) =>
                                                const CreateIssueScreen(),
                                          ),
                                        );
                                      },
                                      child: SvgPicture.asset(
                                          AppConstants.createIssue),
                                    ),
                                    Text(
                                      "Create Issue",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      else if (userData['role'] == "staff")
                        Container(
                          height: 140.h,
                          width: double.maxFinite,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: const RoundedRectangleBorder(
                              side: BorderSide(width: 2, color: Colors.blue),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                                bottomLeft: Radius.circular(30),
                                bottomRight: Radius.circular(2),
                              ),
                            ),
                            shadows: [
                              BoxShadow(
                                color: Colors.blue.shade300,
                                blurRadius: 8,
                                offset: const Offset(2, 4),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 200.w,
                                      child: Text(
                                        userData['userName'],
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black,
                                          fontSize: 24.sp,
                                        ),
                                      ),
                                    ),
                                    heightSpacer(15),
                                    Text(
                                      "Department: ${userData['department']}",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15.sp,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      "Job Role: Staff",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15.sp,
                                      ),
                                    ),
                                  ],
                                ),
                                widthSpacer(10),
                                Column(
                                  children: [
                                    Icon(
                                      Icons.assignment_turned_in,
                                      color: Colors.blue,
                                      size: 50.sp,
                                    ),
                                    Text(
                                      "Your Tasks",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      else
                        Container(
                          height: 140.h,
                          width: double.maxFinite,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: const RoundedRectangleBorder(
                              side: BorderSide(width: 2, color: Colors.red),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                                bottomLeft: Radius.circular(30),
                                bottomRight: Radius.circular(2),
                              ),
                            ),
                            shadows: [
                              BoxShadow(
                                color: Colors.red.shade300,
                                blurRadius: 8,
                                offset: const Offset(2, 4),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 200.w,
                                      child: Text(
                                        userData['userName'],
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black,
                                          fontSize: 24.sp,
                                        ),
                                      ),
                                    ),
                                    heightSpacer(15),
                                    Text(
                                      "Role: Admin",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15.sp,
                                      ),
                                    ),
                                  ],
                                ),
                                widthSpacer(10),
                                Column(
                                  children: [
                                    Icon(
                                      Icons.admin_panel_settings,
                                      color: Colors.red,
                                      size: 50.sp,
                                    ),
                                    Text(
                                      "Admin Panel",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      heightSpacer(30),
                      Container(
                        width: double.maxFinite,
                        color: Colors.blue.shade50,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            heightSpacer(20),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                "Categories",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20.sp,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            heightSpacer(15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                CategoryCard(
                                  category: 'Room\nAvailability',
                                  image: AppConstants.roomAvailability,
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                        builder: (context) =>
                                            const RoomAvailabilityScreen(),
                                      ),
                                    );
                                  },
                                ),
                                CategoryCard(
                                  category: userData['role'] == "student"
                                      ? "Your\nIssues"
                                      : 'All\nIssues',
                                  image: AppConstants.allIssues,
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                        builder: (context) =>
                                            const IssueScreen(),
                                      ),
                                    );
                                  },
                                ),
                                CategoryCard(
                                  category: 'Staff\nMembers',
                                  image: AppConstants.staffMember,
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                        builder: (context) =>
                                            const StaffDisplayScreen(),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                            heightSpacer(20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                CategoryCard(
                                  category: 'Create\nStaff',
                                  image: AppConstants.createStaff,
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                        builder: (context) =>
                                            const CreateStaffScreen(),
                                      ),
                                    );
                                  },
                                ),
                                CategoryCard(
                                  category: 'Hostel\nFee',
                                  image: AppConstants.hostelFee,
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                        builder: (context) =>
                                            const HostelFeeScreen(),
                                      ),
                                    );
                                  },
                                ),
                                CategoryCard(
                                  category: 'Change\nRequests',
                                  image: AppConstants.roomChange,
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                        builder: (context) =>
                                            const RoomChangeRequestScreen(),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                            heightSpacer(20),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
          }),
    );
  }
}
