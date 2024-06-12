import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:take_home_challenge_innoscripta/core/styles/app_text_style.dart';


import 'app_colors.dart';

/// Light theme
final ThemeData appTheme = ThemeData(
  dialogBackgroundColor: AppColors.lightGray,
  cardColor: AppColors.primaryColor,
  appBarTheme: AppBarTheme(
    // shadowColor: AppColors.lightGray,
    color: AppColors.white,
    elevation: 2,
    toolbarTextStyle: TextTheme(
      titleLarge: GoogleFonts.lato(textStyle: AppTextStyle.xxxLargeBlack),
    ).bodyLarge,
    titleTextStyle: TextTheme(
      titleLarge: GoogleFonts.lato(textStyle: AppTextStyle.xxxLargeBlack),
    ).titleLarge,
    systemOverlayStyle: SystemUiOverlayStyle.light,
  ),
  // fontFamily: "Segoe UI",
  scaffoldBackgroundColor: AppColors.white,
  iconTheme: const IconThemeData(color: AppColors.black, size: 25),
  textTheme: TextTheme(
    headlineLarge: GoogleFonts.lato(textStyle: AppTextStyle.xxxLargeBlack),
    headlineMedium: GoogleFonts.lato(textStyle: AppTextStyle.xLargeBlack),
    titleMedium: GoogleFonts.lato(textStyle: AppTextStyle.xSmallBlack),
    titleSmall: GoogleFonts.lato(textStyle: AppTextStyle.smallBlack),
    bodyLarge: GoogleFonts.lato(textStyle: AppTextStyle.largeBlack),
    bodyMedium: GoogleFonts.lato(textStyle: AppTextStyle.mediumBlack),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primaryColor,
      padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 12.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.sp),
      ),
    ),
  ),
  colorScheme: ColorScheme.fromSwatch().copyWith(secondary: AppColors.primaryColor),
  inputDecorationTheme: InputDecorationTheme(
      fillColor: AppColors.transparent,
      contentPadding: EdgeInsets.symmetric(
        horizontal: 10.sp,
      ),
      suffixIconColor: AppColors.black,
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.sp),
          borderSide: const BorderSide(color: AppColors.white, width: 1)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.sp),
          borderSide: const BorderSide(color: AppColors.white, width: 1)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.sp),
          borderSide: const BorderSide(color: AppColors.white, width: 1)),
      errorMaxLines: 2),
);

/// Dark theme
final ThemeData darkAppTheme = ThemeData(
  dialogBackgroundColor: AppColors.primaryColor,

  cardColor: AppColors.orange.withOpacity(0.5),
  appBarTheme: AppBarTheme(
    shadowColor: AppColors.white,
    color: AppColors.darkGray,
    elevation: 0,
    toolbarTextStyle: TextTheme(
      titleLarge: GoogleFonts.lato(textStyle: AppTextStyle.xxxLargeWhite),
    ).bodyLarge,
    titleTextStyle: TextTheme(
      titleLarge: GoogleFonts.lato(textStyle: AppTextStyle.xxxLargeWhite),
    ).titleLarge,
    systemOverlayStyle: SystemUiOverlayStyle.light,
  ),
  // fontFamily: "Georgia",
  scaffoldBackgroundColor: AppColors.primaryColor,
  iconTheme: const IconThemeData(color: AppColors.white, size: 25),
  textTheme: TextTheme(
    headlineLarge: GoogleFonts.lato(textStyle: AppTextStyle.xxxLargeWhite),
    headlineMedium: GoogleFonts.lato(textStyle: AppTextStyle.xLargeWhite),
    titleMedium: GoogleFonts.lato(textStyle: AppTextStyle.xSmallWhite),
    titleSmall: GoogleFonts.lato(textStyle: AppTextStyle.smallWhite),
    bodyLarge: GoogleFonts.lato(textStyle: AppTextStyle.largeWhite),
    bodyMedium: GoogleFonts.lato(textStyle: AppTextStyle.mediumWhite),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primaryColor,
      padding: EdgeInsets.symmetric(
        horizontal: 50.w,
        vertical: 12.h,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  ),
  colorScheme: ColorScheme.fromSwatch().copyWith(secondary: AppColors.primaryColor),
  inputDecorationTheme: InputDecorationTheme(
    contentPadding: EdgeInsets.symmetric(
      horizontal: 10.w,
    ),
    filled: true,
    suffixIconColor: AppColors.white,
    fillColor: AppColors.transparent,
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.sp),
        borderSide: const BorderSide(color: AppColors.lightGray, width: 1)),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.sp),
        borderSide: const BorderSide(color: AppColors.lightGray, width: 1)),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.sp),
        borderSide: const BorderSide(color: AppColors.lightGray, width: 1)),
    errorMaxLines: 2,
  ),
);