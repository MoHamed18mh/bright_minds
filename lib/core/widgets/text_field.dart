import 'package:bright_minds/core/functions/validate_fields.dart';
import 'package:bright_minds/core/utils/app_colors.dart';
import 'package:bright_minds/core/utils/app_text_style.dart';
import 'package:flutter/material.dart';

class TextFieldW extends StatelessWidget {
  const TextFieldW({
    super.key,
    required this.text,
    this.prefixIcon,
    this.controller,
    this.onChanged,
  });

  final String text;
  final Icon? prefixIcon;
  final TextEditingController? controller;
  final Function(String value)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: AppTextStyle.nunitoSansBlack.copyWith(fontSize: 16),
      controller: controller,
      validator: validatFields,
      cursorColor: Colors.black,
      decoration: inputDecoration(),
      onChanged: onChanged,
    );
  }

  InputDecoration inputDecoration() {
    return InputDecoration(
      prefixIcon: prefixIcon,
      prefixIconColor: AppColors.primaryColor,
      label: Text(
        text,
        style: AppTextStyle.nunitoSansGrey,
      ),
      suffixIconColor: AppColors.primaryColor,
      border: outLineInputBorder(),
      enabledBorder: outLineInputBorder(),
      focusedBorder: outLineInputBorder(),
      errorBorder: outLineInputBorder(),
    );
  }

  OutlineInputBorder outLineInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
    );
  }
}
