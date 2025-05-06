import 'package:bright_minds/core/utils/app_text_style.dart';
import 'package:bright_minds/features/onboarding/models/onboarding_model.dart';
import 'package:bright_minds/features/onboarding/presentation/widgets/smooth_page_indicator.dart';
import 'package:flutter/material.dart';

class BoardingItem extends StatelessWidget {
  const BoardingItem({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          boardingData[index].imagePath,
          height: 240,
          fit: BoxFit.fill,
        ),
        const SmoothPageIndicatorW(),
        const SizedBox(height: 24),
        Text(
          boardingData[index].title,
          style: AppTextStyle.nunitoSansBlack.copyWith(fontSize: 22),
        ),
        Text(
          boardingData[index].subTitle,
          textAlign: TextAlign.center,
          style: AppTextStyle.nunitoSansGrey,
        ),
      ],
    );
  }
}
