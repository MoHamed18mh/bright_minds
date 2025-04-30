import 'package:bright_minds/core/functions/calc_padding.dart';
import 'package:bright_minds/core/functions/navigation.dart';
import 'package:bright_minds/core/routes/route_keys.dart';
import 'package:bright_minds/core/utils/app_strings.dart';
import 'package:bright_minds/core/widgets/app_name.dart';
import 'package:bright_minds/features/auth/presentation/widgets/forms/register_form.dart';
import 'package:bright_minds/features/auth/presentation/widgets/text_button.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = calcPadding(context);

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: padding),
          child: CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(child: SizedBox(height: 20)),
              const SliverToBoxAdapter(child: AppName()),
              const SliverToBoxAdapter(child: SizedBox(height: 30)),
              const SliverToBoxAdapter(child: RegisterForm()),
              SliverToBoxAdapter(
                child: TextButtonW(
                  alignment: Alignment.center,
                  text: AppStrings.alreadyHaveAccount,
                  onPressed: () =>
                      navigateReplacement(context, RouteKeys.login),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
