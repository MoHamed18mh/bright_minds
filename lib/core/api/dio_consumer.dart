import 'package:bright_minds/core/api/api_consumer.dart';
import 'package:bright_minds/core/api/api_interceptor.dart';
import 'package:bright_minds/core/api/end_point.dart';
import 'package:bright_minds/core/api/errors/exception.dart';
import 'package:dio/dio.dart';

class DioConsumer extends ApiConsumer {
  final Dio dio;

  DioConsumer({required this.dio}) {
    dio.options.baseUrl = EndPoint.baseUrl;
    dio.interceptors.add(LogInterceptor(
      request: true,
      requestBody: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: true,
    ));
    dio.interceptors.add(ApiInterceptor());
  }

  @override
  Future get(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.get(
        url,
        data: data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      handleException(e);
    }
  }

  @override
  Future delete(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
  }) async {
    try {
      final response = await dio.delete(
        url,
        data: isFormData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      handleException(e);
    }
  }

  @override
  Future post(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
  }) async {
    try {
      final response = await dio.post(
        url,
        data: isFormData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      handleException(e);
    }
  }

  @override
  Future put(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
  }) async {
    try {
      final response = await dio.put(
        url,
        data: isFormData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      handleException(e);
    }
  }
}
