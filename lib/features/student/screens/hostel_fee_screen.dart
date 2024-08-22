import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:piethostel/common/constants.dart';
import 'package:piethostel/common/spacing.dart';

class HostelFeeScreen extends StatelessWidget {
  const HostelFeeScreen({super.key});

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
          "Hostel Fee",
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              heightSpacer(20),
              SvgPicture.asset(
                AppConstants.hostel,
              ),
              heightSpacer(40),
              Container(
                width: double.maxFinite,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.green.shade700,
                      width: 4,
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      heightSpacer(20),
                      Text(
                        "Hostel Details",
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      heightSpacer(20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Block No : ",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                ),
                              ),
                              Text(
                                "B",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Room No : ",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                ),
                              ),
                              Text(
                                "202",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      heightSpacer(20),
                      Text(
                        "Payment Details",
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      heightSpacer(20),
                      const PaymentDetails(
                        type: "Maintainance Charge : ",
                        amount: "\$3000",
                      ),
                      heightSpacer(20),
                      const PaymentDetails(
                        type: "Parking Charge : ",
                        amount: "\$3000",
                      ),
                      heightSpacer(20),
                      const PaymentDetails(
                        type: "Room Water Charge : ",
                        amount: "\$3000",
                      ),
                      heightSpacer(20),
                      const PaymentDetails(
                        type: "Room Charge : ",
                        amount: "\$5000",
                      ),
                      heightSpacer(20),
                      const Divider(
                        color: Colors.black,
                      ),
                      heightSpacer(20),
                      const PaymentDetails(
                        type: "Total Amount : ",
                        amount: "\$14000",
                      ),
                      heightSpacer(20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PaymentDetails extends StatelessWidget {
  final String type;
  final String amount;
  const PaymentDetails({
    super.key,
    required this.type,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          type,
          style: TextStyle(
            fontSize: 16.sp,
          ),
        ),
        Text(
          amount,
          style: TextStyle(
            fontSize: 16.sp,
          ),
        ),
      ],
    );
  }
}
