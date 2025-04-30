import 'package:bright_minds/core/functions/navigation.dart';
import 'package:bright_minds/core/functions/show_toast.dart';
import 'package:bright_minds/core/routes/route_keys.dart';
import 'package:bright_minds/core/utils/app_colors.dart';
import 'package:bright_minds/core/utils/app_strings.dart';
import 'package:bright_minds/core/widgets/material_button.dart';
import 'package:bright_minds/features/auth/cubit/auth_cubit.dart';
import 'package:bright_minds/features/auth/cubit/auth_state.dart';
import 'package:bright_minds/features/auth/presentation/widgets/password_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordForm extends StatelessWidget {
  const ResetPasswordForm(
      {super.key, required this.email, required this.token});
  final String email;
  final String token;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is ResetSuccess) {
          showToast(msg: AppStrings.loginNow);
          navigateReplacement(context, RouteKeys.login);
        } else if (state is ResetFailure) {
          showToast(msg: state.error);
        }
      },
      child: Form(
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
            const SizedBox(height: 50),

            ///  button for create new password
            BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                if (state is ResetLoading) {
                  return CircularProgressIndicator(
                      color: AppColors.primaryColor);
                }
                return MaterialButtonW(
                  onPressed: () {
                    if (cubit.resetKey.currentState!.validate()) {
                      cubit.resetPass(email, token);
                    }
                  },
                  text: AppStrings.createNewPassword,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
