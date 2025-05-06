import 'package:bright_minds/core/functions/navigation.dart';
import 'package:bright_minds/core/routes/route_keys.dart';
import 'package:bright_minds/core/utils/app_colors.dart';
import 'package:bright_minds/features/profile/models/user_model.dart';
import 'package:flutter/material.dart';

class EditButton extends StatelessWidget {
  const EditButton({super.key, required this.user});

  final UserData user;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: MaterialButton(
        onPressed: () => navigate(
          context,
          RouteKeys.editProfile,
          extra: user,
        ),
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(16),
        color: AppColors.primaryColor,
        child: const Icon(
          Icons.edit,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }
}
