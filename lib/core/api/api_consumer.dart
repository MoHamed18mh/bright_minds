// prepare parent class of api
abstract class ApiConsumer {
  Future<dynamic> get(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  });
  Future<dynamic> post(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
  });
  Future<dynamic> put(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
  });
  Future<dynamic> delete(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
  });
}
