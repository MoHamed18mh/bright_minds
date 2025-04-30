import 'package:bright_minds/core/utils/app_strings.dart';
import 'package:bright_minds/core/utils/app_text_style.dart';
import 'package:flutter/material.dart';

class SkipButton extends StatelessWidget {
  const SkipButton({super.key, required this.onpressed});
  final Function() onpressed;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: onpressed,
        child: Text(
          AppStrings.skip,
          style: AppTextStyle.nunitoSansBlack,
        ),
      ),
    );
  }
}
