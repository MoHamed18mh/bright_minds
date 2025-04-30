import 'package:bright_minds/core/utils/app_colors.dart';
import 'package:bright_minds/core/utils/app_text_style.dart';
import 'package:bright_minds/features/home/models/service_model.dart';
import 'package:flutter/material.dart';

class Skills extends StatelessWidget {
  const Skills({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 50),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: List.generate(
            skills.length,
            (int index) => Row(
              children: [
                Icon(
                  Icons.arrow_forward,
                  color: AppColors.primaryColor,
                ),
                Text(
                  skills[index],
                  style: AppTextStyle.nunitoSansBlack.copyWith(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
