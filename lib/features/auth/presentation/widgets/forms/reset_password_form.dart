import 'package:bright_minds/core/utils/app_strings.dart';
import 'package:bright_minds/features/auth/cubit/auth_cubit.dart';
import 'package:bright_minds/core/widgets/password_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordForm extends StatelessWidget {
  const ResetPasswordForm(
      {super.key, required this.email, required this.token});
  final String email;
  final String token;

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<AuthCubit>();

    return Form(
      key: cubit.resetKey,
      child: Column(
        children: [
          ///  reset password field
          PassWordFieldW(
            text: AppStrings.password,
            controller: cubit.passResetController,
          ),
          const SizedBox(height: 10),

          ///  reset confirm password field
          PassWordFieldW(
            text: AppStrings.confirmPassword,
            controller: cubit.confirmResetController,
          ),
        ],
      ),
    );
  }
}
