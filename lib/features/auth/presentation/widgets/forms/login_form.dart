import 'package:bright_minds/core/utils/app_strings.dart';
import 'package:bright_minds/features/auth/cubit/auth_cubit.dart';
import 'package:bright_minds/core/widgets/password_field.dart';
import 'package:bright_minds/core/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<AuthCubit>();

    return Form(
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
        ],
      ),
    );
  }
}
