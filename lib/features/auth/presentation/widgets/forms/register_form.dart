import 'package:bright_minds/core/utils/app_strings.dart';
import 'package:bright_minds/features/auth/cubit/auth_cubit.dart';
import 'package:bright_minds/core/widgets/password_field.dart';
import 'package:bright_minds/core/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();

    return Form(
      key: cubit.registerKey,
      child: Column(
        children: [
          /// first name
          TextFieldW(
            text: AppStrings.firstName,
            prefixIcon: const Icon(Icons.person_outline),
            controller: cubit.firstNameRegController,
          ),
          const SizedBox(height: 10),

          /// last name
          TextFieldW(
            text: AppStrings.lastName,
            prefixIcon: const Icon(Icons.person_outline),
            controller: cubit.lastNameRegController,
          ),
          const SizedBox(height: 10),

          /// email
          TextFieldW(
            text: AppStrings.email,
            prefixIcon: const Icon(Icons.email_outlined),
            controller: cubit.emailRegController,
          ),
          const SizedBox(height: 10),

          /// phone number
          TextFieldW(
            text: AppStrings.phoneNumber,
            prefixIcon: const Icon(Icons.phone_outlined),
            controller: cubit.mobileRegController,
          ),
          const SizedBox(height: 10),

          /// password
          PassWordFieldW(
            text: AppStrings.password,
            controller: cubit.passRegController,
          ),
          const SizedBox(height: 10),

          /// confirm password
          PassWordFieldW(
            text: AppStrings.confirmPassword,
            controller: cubit.confirmRegController,
          ),
        ],
      ),
    );
  }
}
