import 'package:bright_minds/core/utils/app_strings.dart';
import 'package:bright_minds/core/widgets/back_button.dart';
import 'package:bright_minds/features/auth/presentation/widgets/title_overview.dart';
import 'package:bright_minds/features/auth/presentation/widgets/forms/forgot_password_form.dart';
import 'package:flutter/material.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: BackButtonW()),
              SliverToBoxAdapter(child: SizedBox(height: 26)),
              SliverToBoxAdapter(
                child: TitleOverView(
                  text1: AppStrings.enterEmail,
                  text2: AppStrings.willSendMessage,
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 30)),
              SliverToBoxAdapter(child: ForgotPasswordForm()),
            ],
          ),
        ),
      ),
    );
  }
}
