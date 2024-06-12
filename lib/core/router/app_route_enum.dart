enum AppRouteEnum {
  dashboard,
}

extension AppRouteExtension on AppRouteEnum {
  String get name {
    switch (this) {
      case AppRouteEnum.dashboard:
        return "/dashboard";

      default:
        return "/dashboard";
    }
  }
}