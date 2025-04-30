import 'package:bright_minds/core/functions/navigation.dart';
import 'package:bright_minds/core/functions/show_toast.dart';
import 'package:bright_minds/core/routes/route_keys.dart';
import 'package:bright_minds/core/utils/app_colors.dart';
import 'package:bright_minds/core/utils/app_strings.dart';
import 'package:bright_minds/core/widgets/material_button.dart';
import 'package:bright_minds/features/auth/cubit/auth_cubit.dart';
import 'package:bright_minds/features/auth/cubit/auth_state.dart';
import 'package:bright_minds/features/auth/presentation/widgets/password_field.dart';
import 'package:bright_minds/features/auth/presentation/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          showToast(msg: AppStrings.pleaseCheckEmail);
          navigateReplacement(context, RouteKeys.login);
        } else if (state is RegisterFailure) {
          showToast(msg: state.error);
        }
      },
      child: Form(
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
            const SizedBox(height: 30),

            /// register button
            BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                if (state is RegisterLoading) {
                  return CircularProgressIndicator(
                      color: AppColors.primaryColor);
                } else {
                  return MaterialButtonW(
                    text: AppStrings.register,
                    onPressed: () {
                      if (cubit.registerKey.currentState!.validate()) {
                        cubit.register();
                      }
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
