import 'package:bright_minds/core/routes/router.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Bright Minds',
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
