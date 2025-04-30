import 'package:bright_minds/core/functions/calc_padding.dart';
import 'package:bright_minds/core/functions/navigation.dart';
import 'package:bright_minds/core/functions/show_toast.dart';
import 'package:bright_minds/core/routes/route_keys.dart';
import 'package:bright_minds/core/utils/app_strings.dart';
import 'package:bright_minds/core/widgets/app_name.dart';
import 'package:bright_minds/features/auth/cubit/auth_cubit.dart';
import 'package:bright_minds/features/auth/cubit/auth_state.dart';
import 'package:bright_minds/features/auth/presentation/widgets/forms/login_form.dart';
import 'package:bright_minds/features/auth/presentation/widgets/text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key, this.prefillEmail});

  final String? prefillEmail;

  @override
  Widget build(BuildContext context) {
    final padding = calcPadding(context);

    return SafeArea(
      child: Scaffold(
        body: BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is ConfirmFailure) {
              showToast(msg: state.error);
            } else if (state is ConfirmSuccess) {
              showToast(msg: AppStrings.loginNow);
            } else if (state is ConfirmLoading) {
              showToast(msg: AppStrings.checkingInProgress);
            }
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: padding),
            child: CustomScrollView(
              slivers: [
                const SliverToBoxAdapter(child: SizedBox(height: 40)),
                const SliverToBoxAdapter(child: AppName()),
                const SliverToBoxAdapter(child: SizedBox(height: 60)),
                SliverToBoxAdapter(
                  child: LoginForm(prefillEmail: prefillEmail),
                ),
                SliverToBoxAdapter(
                  child: TextButtonW(
                    alignment: Alignment.center,
                    text: AppStrings.dontHaveAccount,
                    onPressed: () =>
                        navigateReplacement(context, RouteKeys.register),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
