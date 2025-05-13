import 'package:bright_minds/core/api/dio_consumer.dart';
import 'package:bright_minds/core/api/end_point.dart';
import 'package:bright_minds/core/database/cache_helper.dart';
import 'package:bright_minds/core/functions/redirect.dart';
import 'package:bright_minds/core/routes/route_keys.dart';
import 'package:bright_minds/core/services/service_locator.dart';
import 'package:bright_minds/features/auth/cubit/auth_cubit.dart';
import 'package:bright_minds/features/auth/presentation/views/forgot_password_view.dart';
import 'package:bright_minds/features/auth/presentation/views/login_view.dart';
import 'package:bright_minds/features/auth/presentation/views/register_view.dart';
import 'package:bright_minds/features/auth/presentation/views/reset_password_view.dart';
import 'package:bright_minds/features/cart/presentation/views/bag_view.dart';
import 'package:bright_minds/features/cart/cubit/cart_cubit.dart';
import 'package:bright_minds/features/cart/presentation/views/user_course_details_view.dart';
import 'package:bright_minds/features/course/cubit/course_cubit.dart';
import 'package:bright_minds/features/course/models/course_model.dart';
import 'package:bright_minds/features/course/presentation/views/course_details_view.dart';
import 'package:bright_minds/features/course/presentation/views/course_view.dart';
import 'package:bright_minds/features/course/presentation/views/video_view.dart';
import 'package:bright_minds/features/home/presentation/views/home_view.dart';
import 'package:bright_minds/features/instructor/cubit/instructor_cubit.dart';
import 'package:bright_minds/features/instructor/models/instructor_model.dart';
import 'package:bright_minds/features/instructor/presentation/views/instructor_details_view.dart';
import 'package:bright_minds/features/instructor/presentation/views/instructor_view.dart';
import 'package:bright_minds/features/onboarding/cubit/onboarding_cubit.dart';
import 'package:bright_minds/features/onboarding/presentation/views/onboarding_view.dart';
import 'package:bright_minds/features/profile/cubit/profile_cubit.dart';
import 'package:bright_minds/features/profile/models/user_model.dart';
import 'package:bright_minds/features/cart/presentation/views/cart_course_view.dart';
import 'package:bright_minds/features/cart/presentation/views/cart_view.dart';
import 'package:bright_minds/features/profile/presentation/views/edit_profile_view.dart';
import 'package:bright_minds/features/profile/presentation/views/profile_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final DioConsumer _dio = getIt<DioConsumer>();

GoRouter router(bool isBoardingVisited, bool isLoggedin) => GoRouter(
      initialLocation: isLoggedin
          ? RouteKeys.home
          : isBoardingVisited
              ? RouteKeys.login
              : RouteKeys.onBoarding,
      redirect: (context, state) {
        return redirect(state);
      },
      routes: [
        /// OnBoarding
        GoRoute(
          path: RouteKeys.onBoarding,
          builder: (context, state) => BlocProvider(
            create: (_) => OnboardingCubit(getIt<CacheHelper>()),
            child: const OnboardingView(),
          ),
        ),

        /// Login
        GoRoute(
          path: RouteKeys.login,
          builder: (context, state) {
            final email = state.uri.queryParameters[ApiKey.email];
            final token = state.uri.queryParameters[ApiKey.token];

            return BlocProvider(
              create: (_) {
                final cubit = AuthCubit(_dio);

                if (email != null && token != null) {
                  cubit.confirm(email, token);
                  cubit.prefillEmail(email);
                }
                return cubit;
              },
              child: const LoginView(),
            );
          },
        ),

        /// Register
        GoRoute(
          path: RouteKeys.register,
          builder: (context, state) => BlocProvider(
            create: (_) => AuthCubit(_dio),
            child: const RegisterView(),
          ),
        ),

        /// Forgot Password
        GoRoute(
          path: RouteKeys.forgotPassword,
          builder: (context, state) => BlocProvider(
            create: (_) => AuthCubit(_dio),
            child: const ForgotPasswordView(),
          ),
        ),

        /// reset Password
        GoRoute(
          path: RouteKeys.resetPassword,
          builder: (context, state) {
            final email = state.uri.queryParameters[ApiKey.email];
            final token = state.uri.queryParameters[ApiKey.token];

            return BlocProvider(
              create: (_) => AuthCubit(_dio),
              child: ResetPasswordView(
                email: email!,
                token: token!,
              ),
            );
          },
        ),

        /// home
        GoRoute(
          path: RouteKeys.home,
          builder: (context, state) => const HomeView(),
        ),

        /// course
        GoRoute(
          path: RouteKeys.course,
          builder: (context, state) => BlocProvider(
            create: (_) => CourseCubit(_dio)..getCourses(),
            child: const CourseView(),
          ),
        ),

        /// course details
        GoRoute(
          path: RouteKeys.courseDetails,
          builder: (context, state) {
            final course = state.extra as CourseItem;

            return BlocProvider(
              create: (_) => CourseCubit(_dio)..getSections(course.id),
              child: CourseDetailsView(
                course: course,
              ),
            );
          },
        ),

        /// video screen
        GoRoute(
          path: RouteKeys.video,
          builder: (context, state) {
            final extra = state.extra as Map<String, dynamic>;
            final int sectionId = extra[ApiKey.sectionId];
            final String sectionName = extra[ApiKey.sectionName];

            return BlocProvider(
              create: (_) => CourseCubit(_dio)..getVideos(sectionId),
              child: VideoView(sectionName: sectionName),
            );
          },
        ),

        /// instructor
        GoRoute(
          path: RouteKeys.instructor,
          builder: (context, state) => BlocProvider(
            create: (_) => InstructorCubit(_dio)..getInstructors(),
            child: const InstructorView(),
          ),
        ),

        /// instructor details
        GoRoute(
          path: RouteKeys.instructorDetails,
          builder: (context, state) => InstructorDetailsView(
            instructor: state.extra as InstructorItem,
          ),
        ),

        /// profile screen
        GoRoute(
          path: RouteKeys.profile,
          builder: (context, state) => BlocProvider(
            create: (_) => ProfileCubit(_dio)..getUser(),
            child: const ProfileView(),
          ),
        ),

        /// edit profile screen
        GoRoute(
          path: RouteKeys.editProfile,
          builder: (context, state) {
            final user = state.extra as UserData;

            return BlocProvider(
              create: (_) => ProfileCubit(_dio)..prefillFields(user),
              child: const EditProfileView(),
            );
          },
        ),

        /// Bag screen
        GoRoute(
          path: RouteKeys.bag,
          builder: (context, state) => BlocProvider(
            create: (_) => CartCubit(_dio)..getUserCourses(),
            child: const BagView(),
          ),
        ),

        /// cart screen
        GoRoute(
          path: RouteKeys.cart,
          builder: (context, state) => BlocProvider(
            create: (_) => CartCubit(_dio)..getCart(),
            child: const CartView(),
          ),
        ),

        /// cart course screen
        GoRoute(
          path: RouteKeys.cartCourse,
          builder: (context, state) => BlocProvider(
            create: (_) =>
                CartCubit(_dio)..getCartCourses(state.extra as String),
            child: const CartCourseView(),
          ),
        ),

        /// user course details screen
        GoRoute(
          path: RouteKeys.userCourse,
          builder: (context, state) => BlocProvider(
            create: (context) => CourseCubit(_dio),
            child: UserCourseDetailsView(course: state.extra as CourseItem),
          ),
        )

        ///
      ],
    );
