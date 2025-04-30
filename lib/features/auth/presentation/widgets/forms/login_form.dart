import 'package:bright_minds/core/functions/navigation.dart';
import 'package:bright_minds/core/functions/show_toast.dart';
import 'package:bright_minds/core/routes/route_keys.dart';
import 'package:bright_minds/core/utils/app_colors.dart';
import 'package:bright_minds/core/utils/app_strings.dart';
import 'package:bright_minds/core/widgets/material_button.dart';
import 'package:bright_minds/features/auth/cubit/auth_cubit.dart';
import 'package:bright_minds/features/auth/cubit/auth_state.dart';
import 'package:bright_minds/features/auth/presentation/widgets/text_button.dart';
import 'package:bright_minds/features/auth/presentation/widgets/password_field.dart';
import 'package:bright_minds/features/auth/presentation/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key, this.prefillEmail});

  final String? prefillEmail;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();

    if (prefillEmail != null) {
      cubit.emailLoginController.text = prefillEmail!;
    }

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          showToast(msg: AppStrings.wellcom);
          navigateReplacement(context, RouteKeys.home);
        } else if (state is LoginFailure) {
          showToast(msg: state.error);
        }
      },
      child: Form(
        key: cubit.loginKey,
        child: Column(
          children: [
            /// email field
            TextFieldW(
              text: AppStrings.email,
              prefixIcon: const Icon(Icons.email_outlined),
              controller: cubit.emailLoginController,
            ),
            const SizedBox(height: 16),

            /// password field
            PassWordFieldW(
              text: AppStrings.password,
              controller: cubit.passwordLoginController,
            ),

            /// forgot password button
            TextButtonW(
              alignment: Alignment.centerRight,
              text: AppStrings.forgotPassword,
              onPressed: () => navigate(context, RouteKeys.forgotPassword),
            ),
            const SizedBox(height: 100),

            /// login button
            BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                if (state is LoginLoading) {
                  return CircularProgressIndicator(
                      color: AppColors.primaryColor);
                } else {
                  return MaterialButtonW(
                    text: AppStrings.login,
                    onPressed: () {
                      if (cubit.loginKey.currentState!.validate()) {
                        cubit.login();
                      }
                    },
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
