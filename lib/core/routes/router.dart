import 'package:bright_minds/core/api/end_point.dart';
import 'package:bright_minds/core/database/cache_helper.dart';
import 'package:bright_minds/core/functions/redirect.dart';
import 'package:bright_minds/core/routes/create_cubit.dart';
import 'package:bright_minds/core/routes/route_keys.dart';
import 'package:bright_minds/core/services/service_locator.dart';
import 'package:bright_minds/features/auth/presentation/views/forgot_password_view.dart';
import 'package:bright_minds/features/auth/presentation/views/login_view.dart';
import 'package:bright_minds/features/auth/presentation/views/register_view.dart';
import 'package:bright_minds/features/auth/presentation/views/reset_password_view.dart';
import 'package:bright_minds/features/cart/model/user_course_model.dart';
import 'package:bright_minds/features/cart/presentation/views/bag_view.dart';
import 'package:bright_minds/features/cart/presentation/views/user_course_details_view.dart';
import 'package:bright_minds/features/course/models/course_model.dart';
import 'package:bright_minds/features/course/presentation/views/course_details_view.dart';
import 'package:bright_minds/features/course/presentation/views/course_view.dart';
import 'package:bright_minds/features/video/cubit/video_cubit.dart';
import 'package:bright_minds/features/video/presentation/views/video_play_view.dart';
import 'package:bright_minds/features/course/presentation/views/video_view.dart';
import 'package:bright_minds/features/home/presentation/views/home_view.dart';
import 'package:bright_minds/features/instructor/models/instructor_model.dart';
import 'package:bright_minds/features/instructor/presentation/views/instructor_details_view.dart';
import 'package:bright_minds/features/instructor/presentation/views/instructor_view.dart';
import 'package:bright_minds/features/onboarding/cubit/onboarding_cubit.dart';
import 'package:bright_minds/features/onboarding/presentation/views/onboarding_view.dart';
import 'package:bright_minds/features/profile/models/user_model.dart';
import 'package:bright_minds/features/cart/presentation/views/cart_view.dart';
import 'package:bright_minds/features/profile/presentation/views/edit_profile_view.dart';
import 'package:bright_minds/features/profile/presentation/views/profile_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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
        /// OnBoarding screen
        GoRoute(
          path: RouteKeys.onBoarding,
          builder: (context, state) => BlocProvider(
            create: (_) => OnboardingCubit(getIt<CacheHelper>()),
            child: const OnboardingView(),
          ),
        ),

        /// Login screen
        GoRoute(
          path: RouteKeys.login,
          builder: (context, state) {
            final email = state.uri.queryParameters[ApiKey.email];
            final token = state.uri.queryParameters[ApiKey.token];

            return BlocProvider(
              create: (_) {
                final cubit = createAuth();

                if (email != null && token != null) {
                  cubit.confirmEmail(email, token);
                  cubit.prefillEmail(email);
                }
                return cubit;
              },
              child: const LoginView(),
            );
          },
        ),

        /// Register screen
        GoRoute(
          path: RouteKeys.register,
          builder: (context, state) => BlocProvider(
            create: (_) => createAuth(),
            child: const RegisterView(),
          ),
        ),

        /// Forgot Password screen
        GoRoute(
          path: RouteKeys.forgotPassword,
          builder: (context, state) => BlocProvider(
            create: (_) => createAuth(),
            child: const ForgotPasswordView(),
          ),
        ),

        /// reset Password screen
        GoRoute(
          path: RouteKeys.resetPassword,
          builder: (context, state) {
            final email = state.uri.queryParameters[ApiKey.email];
            final token = state.uri.queryParameters[ApiKey.token];

            return BlocProvider(
              create: (_) => createAuth(),
              child: ResetPasswordView(
                email: email!,
                token: token!,
              ),
            );
          },
        ),

        /// home screen
        GoRoute(
          path: RouteKeys.home,
          builder: (context, state) => const HomeView(),
        ),

        /// course screen
        GoRoute(
          path: RouteKeys.course,
          builder: (context, state) => BlocProvider(
            create: (_) => createCourse()..getCourses(),
            child: const CourseView(),
          ),
        ),

        /// course details screen
        GoRoute(
          path: RouteKeys.courseDetails,
          builder: (context, state) {
            final course = state.extra as CourseItem;

            return BlocProvider(
              create: (_) => createCourse()..getSections(courseId: course.id),
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
              create: (_) => createCourse()..getVideos(sectionId: sectionId),
              child: VideoView(sectionName: sectionName),
            );
          },
        ),

        /// play video screen
        GoRoute(
          path: RouteKeys.videoPlay,
          builder: (context, state) => BlocProvider(
            create: (_) => VideoCubit(state.extra as String),
            child: const VideoPlayView(),
          ),
        ),

        /// instructor
        GoRoute(
          path: RouteKeys.instructor,
          builder: (context, state) => BlocProvider(
            create: (_) => createInst()..getInstructors(),
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
            create: (_) => createProf()..getUser(),
            child: const ProfileView(),
          ),
        ),

        /// edit profile screen
        GoRoute(
          path: RouteKeys.editProfile,
          builder: (context, state) {
            final user = state.extra as UserData;

            return BlocProvider(
              create: (_) => createProf()..prefillFields(user),
              child: const EditProfileView(),
            );
          },
        ),

        /// Bag screen
        GoRoute(
          path: RouteKeys.bag,
          builder: (context, state) => BlocProvider(
            create: (_) => createCart()..getUserCourses(),
            child: const BagView(),
          ),
        ),

        /// user course details screen
        GoRoute(
          path: RouteKeys.userCourseDetails,
          builder: (context, state) {
            final course = state.extra as UserCourseItem;
            return BlocProvider(
              create: (context) =>
                  createCourse()..getSections(courseId: course.id),
              child: UserCourseDetailsView(course: course),
            );
          },
        ),

        /// cart screen
        GoRoute(
          path: RouteKeys.cart,
          builder: (context, state) => BlocProvider(
            create: (_) => createCart()..getCart(),
            child: const CartView(),
          ),
        ),

        ///
      ],
    );
