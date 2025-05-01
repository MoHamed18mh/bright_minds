import 'package:bright_minds/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class LeftDecorLines extends StatelessWidget {
  const LeftDecorLines({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          height: 3,
          width: 50,
          color: AppColors.primaryColor,
        ),
        const SizedBox(height: 5),
        Container(
          height: 3,
          width: 70,
          color: AppColors.primaryColor,
        ),
      ],
    );
  }
}

class RighDecorLines extends StatelessWidget {
  const RighDecorLines({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          height: 3,
          width: 50,
          color: AppColors.primaryColor,
        ),
        const SizedBox(height: 5),
        Container(
          height: 3,
          width: 70,
          color: AppColors.primaryColor,
        ),
      ],
    );
  }
}
