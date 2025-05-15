import 'package:bright_minds/core/utils/app_strings.dart';
import 'package:bright_minds/features/profile/cubit/profile_cubit.dart';
import 'package:bright_minds/features/profile/cubit/profile_state.dart';
import 'package:bright_minds/features/profile/presentation/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteAndLogOutButtons extends StatelessWidget {
  const DeleteAndLogOutButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProfileCubit>();

    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Buttons(
              onPressed: () => cubit.logOut(),
              text: AppStrings.logOut,
              iconData: (state is LogOutLoading)
                  ? Icons.autorenew
                  : Icons.logout_outlined,
            ),
            const SizedBox(width: 15),
            Buttons(
              onPressed: () => cubit.deleteAccount(),
              text: AppStrings.delete,
              iconData: (state is DeleteLoading)
                  ? Icons.autorenew
                  : Icons.delete_outline,
            ),
          ],
        );
      },
    );
  }
}