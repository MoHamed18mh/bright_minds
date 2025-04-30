import 'package:bright_minds/core/functions/validate_fields.dart';
import 'package:bright_minds/core/utils/app_colors.dart';
import 'package:bright_minds/core/utils/app_text_style.dart';
import 'package:bright_minds/features/auth/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PassWordFieldW extends StatelessWidget {
  const PassWordFieldW({super.key, this.controller, required this.text});

  final TextEditingController? controller;
  final String text;

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<AuthCubit>();

    return TextFormField(
      style: AppTextStyle.nunitoSansBlack.copyWith(fontSize: 16),
      controller: controller,
      validator: validatFields,
      obscureText: cubit.obscurePasswordValue,
      cursorColor: AppColors.lightBlack,
      decoration: inputDecoration(cubit),
    );
  }

  InputDecoration inputDecoration(AuthCubit cubit) {
    return InputDecoration(
      prefixIcon: const Icon(Icons.lock_open_outlined),
      prefixIconColor: AppColors.primaryColor,
      label: Text(
        text,
        style: AppTextStyle.nunitoSansGrey,
      ),
      suffixIcon: suffixIcon(cubit),
      suffixIconColor: AppColors.primaryColor,
      border: outLineInputBorder(),
      enabledBorder: outLineInputBorder(),
      focusedBorder: outLineInputBorder(),
      errorBorder: outLineInputBorder(),
    );
  }

  IconButton suffixIcon(final cubit) {
    return IconButton(
      onPressed: () => cubit.changeObscurePasswordValue(),
      icon: cubit.obscurePasswordValue
          ? const Icon(Icons.visibility_outlined)
          : const Icon(Icons.visibility_off_outlined),
    );
  }

  OutlineInputBorder outLineInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
    );
  }
}
