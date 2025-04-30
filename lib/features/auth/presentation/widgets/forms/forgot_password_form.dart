import 'package:bright_minds/core/functions/navigation.dart';
import 'package:bright_minds/core/functions/show_toast.dart';
import 'package:bright_minds/core/routes/route_keys.dart';
import 'package:bright_minds/core/utils/app_colors.dart';
import 'package:bright_minds/core/utils/app_strings.dart';
import 'package:bright_minds/core/widgets/material_button.dart';
import 'package:bright_minds/features/auth/cubit/auth_cubit.dart';
import 'package:bright_minds/features/auth/cubit/auth_state.dart';
import 'package:bright_minds/features/auth/presentation/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordForm extends StatelessWidget {
  const ForgotPasswordForm({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is ForgotSuccess) {
          showToast(msg: AppStrings.pleaseCheckEmail);
          navigateReplacement(context, RouteKeys.login);
        } else if (state is ForgotFailure) {
          showToast(msg: state.error);
        }
      },
      child: Form(
        key: cubit.forgotKey,
        child: Column(
          children: [
            ///  forgot password email field
            TextFieldW(
              text: AppStrings.email,
              prefixIcon: const Icon(Icons.email_outlined),
              controller: cubit.emailForgotController,
            ),
            const SizedBox(height: 50),

            ///  button send verify email for reset password
            BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                if (state is ForgotLoading) {
                  return CircularProgressIndicator(
                      color: AppColors.primaryColor);
                }
                return MaterialButtonW(
                  onPressed: () {
                    if (cubit.forgotKey.currentState!.validate()) {
                      cubit.forgotPassword();
                    }
                  },
                  text: AppStrings.sendEmail,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
