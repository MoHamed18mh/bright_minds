import 'package:bright_minds/core/functions/navigation.dart';
import 'package:bright_minds/core/routes/route_keys.dart';
import 'package:bright_minds/core/utils/app_strings.dart';
import 'package:bright_minds/core/widgets/material_button.dart';
import 'package:bright_minds/features/onboarding/cubit/onboarding_cubit.dart';
import 'package:bright_minds/features/onboarding/cubit/onboarding_state.dart';
import 'package:bright_minds/features/onboarding/models/onboarding_model.dart';
import 'package:bright_minds/core/widgets/app_name.dart';
import 'package:bright_minds/features/onboarding/presentation/widgets/boarding_item.dart';
import 'package:bright_minds/features/onboarding/presentation/widgets/skip_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<OnboardingCubit>();

    return BlocListener<OnboardingCubit, OnboardingState>(
      listener: (context, state) {
        if (state is OnBoardingCompleted) {
          navigateReplacement(context, RouteKeys.login);
        }
      },
      child: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CustomScrollView(
              slivers: [
                /// skip button
                SliverToBoxAdapter(
                  child: SkipButton(onpressed: () => cubit.navigateToLogin()),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 16)),
                const SliverToBoxAdapter(child: AppName()),
                const SliverToBoxAdapter(child: SizedBox(height: 30)),

                /// boarding body
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 400,
                    child: PageView.builder(
                      controller: cubit.pageController,
                      physics: const BouncingScrollPhysics(),
                      onPageChanged: (index) => cubit.updateCurrentIndex(index),
                      itemCount: boardingData.length,
                      itemBuilder: (context, index) {
                        return BoardingItem(index: index);
                      },
                    ),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 16)),

                /// next view button
                SliverToBoxAdapter(
                  child: MaterialButtonW(
                    text: AppStrings.next,
                    onPressed: () => cubit.nextView(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
