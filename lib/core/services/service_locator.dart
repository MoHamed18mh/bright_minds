import 'package:bright_minds/core/api/dio_consumer.dart';
import 'package:bright_minds/core/database/cache_helper.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

void setupServiceLocator() {
  // CacheHelper
  getIt.registerLazySingleton<CacheHelper>(() => CacheHelper());

  // Dio
  getIt.registerLazySingleton<Dio>(() => Dio());

  // DioConsumer
  getIt
      .registerLazySingleton<DioConsumer>(() => DioConsumer(dio: getIt<Dio>()));
}
