import 'package:bright_minds/core/utils/app_text_style.dart';
import 'package:flutter/material.dart';

class TextButtonW extends StatelessWidget {
  const TextButtonW({super.key, required this.alignment, this.onPressed, required this.text});

  final String text;
  final Alignment alignment;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: AppTextStyle.nunitoSans16LightBlackBold.copyWith(
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}
