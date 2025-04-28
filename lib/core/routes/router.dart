import 'package:bright_minds/core/routes/route_keys.dart';
import 'package:bright_minds/features/on_boarding/presentation/on_boarding_view.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: RouteKeys.onBoarding,
  routes: [
    GoRoute(
      path: RouteKeys.onBoarding,
      builder: (context, state) => const OnBoardingView(),
    )
  ],
);
