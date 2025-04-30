import 'package:bright_minds/core/database/cache_helper.dart';
import 'package:bright_minds/core/database/cache_key.dart';
import 'package:bright_minds/core/routes/router.dart';
import 'package:bright_minds/core/services/service_locator.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeApp();

  final isBoardingVisited =
      await getIt<CacheHelper>().getData(key: CacheKey.isBoardingVisited) ??
          false;

  final isLoggedin =
      await getIt<CacheHelper>().containsKey(key: CacheKey.userId);

  runApp(MainApp(
    isBoardingVisited: isBoardingVisited,
    isLoggedin: isLoggedin,
  ));
}

class MainApp extends StatelessWidget {
  const MainApp(
      {super.key, required this.isBoardingVisited, required this.isLoggedin});

  final bool isBoardingVisited;
  final bool isLoggedin;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Bright Minds',
      debugShowCheckedModeBanner: false,
      routerConfig: router(isBoardingVisited, isLoggedin),
    );
  }
}

Future<void> initializeApp() async {
  setupServiceLocator();
  await getIt<CacheHelper>().init();
}
