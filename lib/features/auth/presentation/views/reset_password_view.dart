import 'package:bright_minds/core/functions/calc_padding.dart';
import 'package:bright_minds/core/utils/app_strings.dart';
import 'package:bright_minds/features/auth/presentation/widgets/forms/reset_password_form.dart';
import 'package:bright_minds/features/auth/presentation/widgets/title_overview.dart';
import 'package:flutter/material.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView(
      {super.key, required this.email, required this.token});
  final String email;
  final String token;

  @override
  Widget build(BuildContext context) {
    final padding = calcPadding(context);

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: padding),
          child: CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(child: SizedBox(height: 40)),
              const SliverToBoxAdapter(
                child: TitleOverView(
                  text1: AppStrings.newPassword,
                  text2: AppStrings.yourNewPassword,
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 50)),
              SliverToBoxAdapter(
                  child: ResetPasswordForm(
                email: email,
                token: token,
              )),
            ],
          ),
        ),
      ),
    );
  }
}
