import 'package:bright_minds/core/database/cache_helper.dart';
import 'package:bright_minds/core/database/cache_key.dart';
import 'package:bright_minds/core/routes/router.dart';
import 'package:bright_minds/core/services/service_locator.dart';
import 'package:dynamic_path_url_strategy/dynamic_path_url_strategy.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
  await initializeApp();

  /// open aplication settings
  final isBoardingVisited =
      await getIt<CacheHelper>().getData(key: CacheKey.isBoardingVisited) ??
          false;
  final isLoggedIn =
      await getIt<CacheHelper>().containsKey(key: CacheKey.userId);

  final appRouter = router(isBoardingVisited, isLoggedIn);

  runApp(MainApp(appRouter: appRouter));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key, required this.appRouter});

  final GoRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Bright Minds',
      locale: const Locale('en'),
      builder: (context, child) {
        return Directionality(textDirection: TextDirection.ltr, child: child!);
      },
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
    );
  }
}

Future<void> initializeApp() async {
  setupServiceLocator();
  await getIt<CacheHelper>().init();
}
