import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:take_home_challenge_innoscripta/core/styles/app_colors.dart';
import 'package:take_home_challenge_innoscripta/core/styles/app_text_style.dart';
import 'package:take_home_challenge_innoscripta/core/utils/constant/task_utils.dart';
import 'package:take_home_challenge_innoscripta/features/tasks/domain/models/comment_model.dart'; // Add intl package for date formatting

class CommentItem extends StatelessWidget {
  final CommentModel comment;

  const CommentItem({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h,horizontal: 4.w),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 3,
              offset: Offset(1, 1),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical:8.h, horizontal: 12.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Anonymous User",
                    style: AppTextStyle.mediumBlack.copyWith(color: TaskUtils.getRandomColor(1),
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    DateFormat('MMM d, yyyy, hh:mm a').format(DateTime.parse(comment.postedAt!)),
                    style: AppTextStyle.smallBlack.copyWith(color: AppColors.taskDescription),
                  ),
                ],
              ),
              SizedBox(height: 4.h),
              Text(
                comment.content ?? "-",
                style: AppTextStyle.largeBlack.copyWith(color: AppColors.taskDescription),
              ),
            ],
          ),
        ),
      ),
    );
  }
}