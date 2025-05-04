import 'package:bright_minds/core/api/end_point.dart';
import 'package:bright_minds/core/database/cache_helper.dart';
import 'package:bright_minds/core/database/cache_key.dart';
import 'package:bright_minds/core/services/service_locator.dart';
import 'package:dio/dio.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers[ApiKey.authorization] =
        'Bearer ${getIt<CacheHelper>().getData(key: CacheKey.token)}';
    super.onRequest(options, handler);
  }
}
