import 'package:bright_minds/core/utils/app_text_style.dart';
import 'package:flutter/material.dart';

class TitleOverView extends StatelessWidget {
  const TitleOverView({super.key, required this.text1, required this.text2});
  final String text1;
  final String text2;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          text1,
          style: AppTextStyle.nunitoSans26LightBlackBold,
        ),
        const SizedBox(height: 8),
        Text(
          text2,
          style: AppTextStyle.nunitoSans13Grey700,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
