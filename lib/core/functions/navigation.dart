import 'package:go_router/go_router.dart';

void navigate(context, String path, {Object? extra}) {
  GoRouter.of(context).push(path, extra: extra);
}

void navigateReplacement(context, String path, {Object? extra}) {
  GoRouter.of(context).pushReplacement(path, extra: extra);
}

void navigatePop(context) {
  GoRouter.of(context).pop();
}

void navigateAndRemoveUntil(context, String path, {Object? extra}) {
  GoRouter.of(context).go(path, extra: extra);
}
