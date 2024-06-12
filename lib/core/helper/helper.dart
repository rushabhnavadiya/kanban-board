import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:take_home_challenge_innoscripta/core/utils/constant/app_constants.dart';
import 'package:take_home_challenge_innoscripta/core/utils/constant/network_constant.dart';
import 'package:take_home_challenge_innoscripta/core/utils/injections.dart';
import 'package:take_home_challenge_innoscripta/shared/data/data_sources/app_shared_prefs.dart';

class Helper {


  /// Get vertical space
  static double getVerticalSpace() {
    return 10.h;
  }

  /// Get horizontal space
  static double getHorizontalSpace() {
    return 10.w;
  }

  /// Get Dio Header
  static Map<String, dynamic> getHeaders() {
    return {
      "Authorization": "Bearer $apiToken"
    }..removeWhere((key, value) => value == null);
  }

  static bool isDarkTheme() {
    return sl<AppSharedPrefs>().getIsDarkTheme();
  }
}