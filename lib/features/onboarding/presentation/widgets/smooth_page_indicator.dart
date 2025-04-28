import 'package:bright_minds/core/utils/app_colors.dart';
import 'package:bright_minds/features/onboarding/cubit/onboarding_cubit.dart';
import 'package:bright_minds/features/onboarding/models/onboarding_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SmoothPageIndicatorW extends StatelessWidget {
  const SmoothPageIndicatorW({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OnboardingCubit>();
    
    return SmoothPageIndicator(
      controller: cubit.pageController,
      count: boardingData.length,
      effect: ExpandingDotsEffect(
        dotHeight: 8,
        dotWidth: 10,
        activeDotColor: AppColors.primaryColor,
      ),
    );
  }
}
