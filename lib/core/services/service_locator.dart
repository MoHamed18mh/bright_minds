
import 'package:bright_minds/core/api/dio_consumer.dart';
import 'package:bright_minds/core/database/cache_helper.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

void setupServiceLocator() {
  // Register CacheHelper as a single component
  getIt.registerSingleton<CacheHelper>(CacheHelper());

  // Register Dio as a single component
  getIt.registerSingleton<Dio>(Dio());

  // Register DioConsumer as a single component
  getIt.registerSingleton<DioConsumer>(DioConsumer(dio: getIt<Dio>()));
}
