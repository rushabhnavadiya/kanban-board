import 'package:get_it/get_it.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:take_home_challenge_innoscripta/core/network/dio_network.dart';
import 'package:take_home_challenge_innoscripta/core/utils/log/app_logger.dart';
import 'package:take_home_challenge_innoscripta/features/tasks/tasks_injections.dart';
import 'package:take_home_challenge_innoscripta/shared/app_injections.dart';


final sl = GetIt.instance;

Future<void> initInjections() async {
  await initSharedPrefsInjections();
  await initAppInjections();
  await initDioInjections();
  await initTasksInjections();
}

initSharedPrefsInjections() async {
  sl.registerSingletonAsync<SharedPreferences>(() async {
    return await SharedPreferences.getInstance();
  });
  await sl.isReady<SharedPreferences>();
}

Future<void> initDioInjections() async {
  initRootLogger();
  DioNetwork.initDio();
}