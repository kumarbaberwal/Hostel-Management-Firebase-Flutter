import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piethostel/common/constants.dart';
import 'package:piethostel/common/spacing.dart';
import 'package:piethostel/features/student/screens/change_room_screen.dart';

class RoomAvailabilityScreen extends StatefulWidget {
  const RoomAvailabilityScreen({super.key});

  @override
  State<RoomAvailabilityScreen> createState() => _RoomAvailabilityScreenState();
}

class RoomCard extends StatelessWidget {
  const RoomCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
          bottomLeft: Radius.circular(30),
        ),
        border: Border.all(
          color: Colors.green.shade800,
          width: 2,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Image.asset(
                AppConstants.bed,
                height: 70.h,
                width: 70.w,
              ),
              const Text(
                "Room No : 202",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          widthSpacer(15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Block",
                style: TextStyle(
                  fontSize: 16.sp,
                ),
              ),
              heightSpacer(5),
              Text(
                "Capacity",
                style: TextStyle(
                  fontSize: 16.sp,
                ),
              ),
              heightSpacer(5),
              Text(
                "Current Capacity",
                style: TextStyle(
                  fontSize: 16.sp,
                ),
              ),
              heightSpacer(5),
              Text(
                "Room Type",
                style: TextStyle(
                  fontSize: 16.sp,
                ),
              ),
              heightSpacer(5),
              Row(
                children: [
                  Text(
                    "Status",
                    style: TextStyle(
                      fontSize: 16.sp,
                    ),
                  ),
                  widthSpacer(10),
                  Container(
                    padding: const EdgeInsets.all(5),
                    height: 30.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.green.shade400,
                    ),
                    child: false
                        ? Text(
                            "Unavailable",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.white,
                            ),
                          )
                        : InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) =>
                                        const ChangeRoomScreen(),
                                  ));
                            },
                            child: Text(
                              "Available",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RoomAvailabilityScreenState extends State<RoomAvailabilityScreen> {
  @override
  Widget build(BuildContext context) {
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
          "Room Availability",
          style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          heightSpacer(20),
          ListView.builder(
            padding: EdgeInsets.all(10.h),
            itemCount: 2,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: const RoomCard(),
              );
            },
          ),
        ],
      ),
    );
  }
}
