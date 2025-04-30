import 'package:bright_minds/core/utils/app_strings.dart';
import 'package:bright_minds/core/utils/app_text_style.dart';
import 'package:flutter/material.dart';

class AppName extends StatelessWidget {
  const AppName({super.key, this.alignment});
  final Alignment? alignment;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: (alignment != null) ? alignment! : Alignment.center,
      child: Text(
        AppStrings.appName,
        style: AppTextStyle.notoSerifPrimary,
      ),
    );
  }
}
