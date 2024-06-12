import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:take_home_challenge_innoscripta/core/styles/app_colors.dart';
import 'package:take_home_challenge_innoscripta/core/styles/app_text_style.dart';

class TaskClass extends StatelessWidget {
  const TaskClass({
    super.key,
    required this.title,
    required this.child,
    this.width = 368,
  });
  final String title;
  final Widget child;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(6),
      // height: 648,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: AppColors.boardBackground,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 8.w, bottom: 15.h),
            child: Text(
              title.toUpperCase(),
              textAlign: TextAlign.center,
              style: AppTextStyle.largeBlack.copyWith(color: AppColors.boardHeader),
            ),
          ),
          Expanded(child: child),
        ],
      ),
    );
  }
}