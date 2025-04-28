import 'package:bright_minds/core/database/cache_helper.dart';
import 'package:bright_minds/core/routes/route_keys.dart';
import 'package:bright_minds/core/services/service_locator.dart';
import 'package:bright_minds/features/auth/presentation/views/login_view.dart';
import 'package:bright_minds/features/onboarding/cubit/onboarding_cubit.dart';
import 'package:bright_minds/features/onboarding/presentation/views/onboarding_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

GoRouter router(bool isBoardingVisited) => GoRouter(
      initialLocation:
          isBoardingVisited ? RouteKeys.login : RouteKeys.onBoarding,
      routes: [
        /// OnBoarding route
        GoRoute(
          path: RouteKeys.onBoarding,
          builder: (context, state) => BlocProvider(
            create: (_) => OnboardingCubit(getIt<CacheHelper>()),
            child: const OnboardingView(),
          ),
        ),

        /// Login route
        GoRoute(
          path: RouteKeys.login,
          builder: (context, state) => const LoginView(),
        )
      ],
    );
