import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final Color? buttonColor;
  final VoidCallback onTap;
  final double? size;
  const CustomButton(
      {super.key,
      required this.buttonText,
      this.buttonColor,
      required this.onTap,
      this.size});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.maxFinite,
        height: 50.h,
        decoration: BoxDecoration(
            color: Colors.green.shade700,
            borderRadius: BorderRadius.circular(14.r)),
        child: Center(
          child: Text(
            buttonText,
            style: TextStyle(
                color: buttonColor ?? Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: size ?? 16),
          ),
        ),
      ),
    );
  }
}
