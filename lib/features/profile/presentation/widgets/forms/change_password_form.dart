import 'package:bright_minds/core/utils/app_strings.dart';
import 'package:bright_minds/core/widgets/password_field.dart';
import 'package:bright_minds/features/profile/cubit/profile_cubit.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePasswordForm extends StatelessWidget {
  const ChangePasswordForm({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<ProfileCubit>();

    return Form(
      key: cubit.changePassKey,
      child: Column(
        children: [
          PassWordFieldW(
            text: AppStrings.oldPassword,
            controller: cubit.oldPassController,
          ),
          const SizedBox(height: 8),

          /// new password
          PassWordFieldW(
            text: AppStrings.newPassword,
            controller: cubit.newPassController,
          ),
          const SizedBox(height: 8),

          /// confirm password
          PassWordFieldW(
            text: AppStrings.confirmPassword,
            controller: cubit.confirmPassController,
          ),
        ],
      ),
    );
  }
}
