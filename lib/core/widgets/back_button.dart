import 'package:bright_minds/core/functions/navigation.dart';
import 'package:bright_minds/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class BackButtonW extends StatelessWidget {
  const BackButtonW({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: IconButton(
        onPressed: () => navigatePop(context),
        icon: Icon(
          Icons.arrow_back_ios_new_rounded,
          size: 27,
          color: AppColors.primaryColor,
        ),
      ),
    );
  }
}
