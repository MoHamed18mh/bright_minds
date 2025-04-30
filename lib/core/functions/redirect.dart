import 'package:bright_minds/core/api/end_point.dart';
import 'package:bright_minds/core/routes/deep_links.dart';
import 'package:bright_minds/core/routes/route_keys.dart';
import 'package:go_router/go_router.dart';

String? redirect(GoRouterState state) {
  final uri = state.uri;
  final email = uri.queryParameters[ApiKey.email];
  final token = uri.queryParameters[ApiKey.token];

  /// redirect login
  if (uri.path == DeepPath.verify) {
    if (email != null && token != null) {
      final encodedToken = Uri.encodeComponent(token);

      return '${RouteKeys.login}?token=$encodedToken&email=$email';
    }
  }

  /// redirect reset password
  if (uri.path == DeepPath.resetPassword) {
    if (email != null && token != null) {
      final encodedToken = Uri.encodeComponent(token);

      return '${RouteKeys.resetPassword}?token=$encodedToken&email=$email';
    }
  }
  return null;
}
