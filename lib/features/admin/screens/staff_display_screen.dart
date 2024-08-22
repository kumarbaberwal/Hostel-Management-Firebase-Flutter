import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piethostel/common/constants.dart';
import 'package:piethostel/common/spacing.dart';
import 'package:piethostel/features/admin/functions/delete_staff_functions.dart';
import 'package:piethostel/providers/user_provider.dart';
import 'package:provider/provider.dart';

class StaffDisplayScreen extends StatefulWidget {
  const StaffDisplayScreen({super.key});

  @override
  State<StaffDisplayScreen> createState() => _StaffDisplayScreenState();
}

class _StaffDisplayScreenState extends State<StaffDisplayScreen> {
  @override
  Widget build(BuildContext context) {
    String? uid = Provider.of<UserProvider>(context).uid;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green.shade800,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            CupertinoIcons.back,
            color: Colors.white,
          ),
        ),
        title: Text(
          "Staffs",
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
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text("Error loading data"),
            );
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(
              child: Text("User data not found"),
            );
          }

          var userData = snapshot.data!.data() as Map<String, dynamic>;

          return StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .where('role', isEqualTo: 'staff')
                .where('status', isEqualTo: 'Active')
                .snapshots(),
            builder: (context, staffSnapshot) {
              if (staffSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (staffSnapshot.hasError) {
                return const Center(
                  child: Text("Error loading staff data"),
                );
              }

              var staff = staffSnapshot.data!.docs;

              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    childAspectRatio:
                        userData['role'] == "admin" ? 2 / 1.3 : 2 / 1,
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 16.0,
                  ),
                  itemCount: staff.length,
                  itemBuilder: (context, index) {
                    var staffData = staff[index].data() as Map<String, dynamic>;
                    var staffId = staff[index].id;

                    return Container(
                      padding: const EdgeInsets.all(16),
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: Colors.green.shade800,
                            width: 2,
                          ),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                            bottomLeft: Radius.circular(30),
                          ),
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Column(
                                children: [
                                  Image.asset(
                                    AppConstants.person,
                                    width: 90.w,
                                    height: 90.h,
                                  ),
                                  heightSpacer(20),
                                  const Text(
                                    "Hostel Warden",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                              widthSpacer(10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Name: ${staffData['userName']}",
                                      style: TextStyle(fontSize: 14.sp),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    heightSpacer(8),
                                    Text(
                                      "Email: ${staffData['Email']}",
                                      style: TextStyle(fontSize: 14.sp),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    heightSpacer(8),
                                    Text(
                                      "Contact: ${staffData['phoneNumber']}",
                                      style: TextStyle(fontSize: 14.sp),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    heightSpacer(8),
                                    Text(
                                      "Department: ${staffData['department']}",
                                      style: TextStyle(fontSize: 14.sp),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          if (userData['role'] == "admin")
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text("Confirmation"),
                                        content: const Text(
                                            "Are you sure you want to delete this staff?"),
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
                                              // Add your delete logic here

                                              deleteStaff(context, staffId);
                                            },
                                            child: const Text("Delete"),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.red.shade300,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      "Delete",
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
