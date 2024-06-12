import 'package:take_home_challenge_innoscripta/core/utils/injections.dart';
import 'data/data_sources/app_shared_prefs.dart';

initAppInjections() {
  sl.registerFactory<AppSharedPrefs>(() => AppSharedPrefs(sl()));
}