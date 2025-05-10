import 'package:bright_minds/core/functions/navigation.dart';
import 'package:bright_minds/core/utils/app_colors.dart';
import 'package:bright_minds/core/utils/app_strings.dart';
import 'package:bright_minds/core/utils/app_text_style.dart';
import 'package:bright_minds/core/widgets/text_field.dart';
import 'package:bright_minds/features/cart/cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void showFeedbackDialog(BuildContext context, int courseId) {
  String comment = '';
  double rate = 1;

  showDialog(
    context: context,
    builder: (ctx) => StatefulBuilder(
      builder: (ctx, setState) {
        return AlertDialog(
          title: Text(
            AppStrings.addCommint,
            style: AppTextStyle.nunitoSansBlack,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// commint field
              TextFieldW(
                text: AppStrings.commint,
                onChanged: (value) => comment = value,
              ),
              const SizedBox(height: 20),

              /// Tape for evaluation
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppStrings.evaluation,
                    style: AppTextStyle.nunitoSansBlack.copyWith(fontSize: 16),
                  ),
                  Text(rate.toStringAsFixed(1)),
                ],
              ),
              Slider(
                value: rate,
                min: 1,
                max: 5,
                divisions: 38,
                label: rate.toStringAsFixed(1),
                onChanged: (value) => setState(() => rate = value),
                thumbColor: AppColors.primaryColor,
                activeColor: AppColors.primaryColor,
              ),
            ],
          ),
          actions: [
            /// cancele button
            TextButton(
              onPressed: () => navigatePop(context),
              child: Text(
                AppStrings.cancel,
                style: AppTextStyle.nunitoSansRed.copyWith(fontSize: 15),
              ),
            ),

            /// submmit button
            ElevatedButton(
              onPressed: () {
                context
                    .read<CartCubit>()
                    .submitFeedBack(courseId, comment.trim(), rate);
              },
              child: Text(
                AppStrings.submmit,
                style: AppTextStyle.notoSerifPrimary.copyWith(fontSize: 15),
              ),
            ),
          ],
        );
      },
    ),
  );
}
