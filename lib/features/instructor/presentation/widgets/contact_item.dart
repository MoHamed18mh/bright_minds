import 'package:bright_minds/core/utils/app_colors.dart';
import 'package:bright_minds/core/utils/app_text_style.dart';
import 'package:flutter/material.dart';

class ContactItem extends StatelessWidget {
  const ContactItem({
    super.key,
    required this.text,
    required this.iconData,
  });

  final String text;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          iconData,
          color: AppColors.primaryColor,
        ),
        const SizedBox(width: 8),
        SelectableText(
          text,
          style: AppTextStyle.nunitoSansBlack.copyWith(fontSize: 16),
        ),
      ],
    );
  }
}
