import 'package:bright_minds/core/utils/app_colors.dart';
import 'package:bright_minds/core/utils/app_text_style.dart';
import 'package:flutter/material.dart';

class Buttons extends StatelessWidget {
  const Buttons(
      {super.key,
      required this.onPressed,
      required this.text,
      required this.iconData});
  final Function() onPressed;
  final String text;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: AppColors.primaryColor,
      height: 45,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: BorderSide.none,
      ),
      child: Row(
        children: [
          Icon(
            iconData,
            color: Colors.white,
          ),
          Text(
            text,
            style: AppTextStyle.nunitoSansWhite,
          ),
        ],
      ),
    );
  }
}
