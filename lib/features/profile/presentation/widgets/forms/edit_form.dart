import 'package:bright_minds/core/utils/app_strings.dart';
import 'package:bright_minds/core/widgets/text_field.dart';
import 'package:bright_minds/features/profile/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditForm extends StatelessWidget {
  const EditForm({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProfileCubit>();

    return Form(
      key: cubit.editKey,
      child: Column(
        children: [
          /// first name field
          TextFieldW(
            text: AppStrings.firstName,
            controller: cubit.firstNameEditController,
          ),
          const SizedBox(height: 8),

          /// last name field
          TextFieldW(
            text: AppStrings.lastName,
            controller: cubit.lastNameEditController,
          ),
          const SizedBox(height: 8),

          /// mobile field
          TextFieldW(
            text: AppStrings.phoneNumber,
            controller: cubit.phoneEditEditController,
          ),
        ],
      ),
    );
  }
}
