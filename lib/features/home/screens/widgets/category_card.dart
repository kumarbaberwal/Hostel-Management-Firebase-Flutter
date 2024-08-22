import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piethostel/common/spacing.dart';

class CategoryCard extends StatelessWidget {
  final String category;
  final String image;
  final VoidCallback onTap;
  const CategoryCard(
      {super.key,
      required this.category,
      required this.image,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(30),
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          shadows: [
            BoxShadow(
                color: Colors.green.shade200,
                blurRadius: 4,
                offset: const Offset(1, 4),
                spreadRadius: 0),
          ],
        ),
        child: Column(
          children: [
            SizedBox(
              height: 70.h,
              width: 70.w,
              child: Image.asset(image),
            ),
            heightSpacer(10),
            Text(
              category,
              style: TextStyle(
                color: Colors.black,
                fontSize: 15.sp,
              ),
              textAlign: TextAlign.center,
            ),
            heightSpacer(10),
          ],
        ),
      ),
    );
  }
}
