import 'package:bright_minds/core/database/cache_helper.dart';
import 'package:bright_minds/core/database/cache_key.dart';
import 'package:bright_minds/features/onboarding/models/onboarding_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  final CacheHelper _cacheHelper;
  
  OnboardingCubit(this._cacheHelper) : super(OnboardingInitial());

  final PageController pageController = PageController(initialPage: 0);
  int currentIndex = 0;

  // change the index of the pageView
  void updateCurrentIndex(int index) {
    currentIndex = index;
  }

  /// go the next page in boarding
  void nextView() {
    if (currentIndex == boardingData.length - 1) {
      navigateToLogin();
    } else {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  /// affter finish boarding save value that isBoardingVisited and go to LoginView screen
  void navigateToLogin() {
    _cacheHelper.saveData(key: CacheKey.isBoardingVisited, value: true);
    emit(OnBoardingCompleted());
  }

  @override
  Future<void> close() {
    pageController.dispose();
    return super.close();
  }
}
