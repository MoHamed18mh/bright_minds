import 'package:bright_minds/core/functions/calc_padding.dart';
import 'package:bright_minds/core/functions/navigation.dart';
import 'package:bright_minds/core/functions/show_toast.dart';
import 'package:bright_minds/core/routes/route_keys.dart';
import 'package:bright_minds/core/utils/app_colors.dart';
import 'package:bright_minds/core/utils/app_strings.dart';
import 'package:bright_minds/core/widgets/app_name.dart';
import 'package:bright_minds/core/widgets/material_button.dart';
import 'package:bright_minds/features/auth/cubit/auth_cubit.dart';
import 'package:bright_minds/features/auth/cubit/auth_state.dart';
import 'package:bright_minds/features/auth/presentation/widgets/forms/login_form.dart';
import 'package:bright_minds/features/auth/presentation/widgets/text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = calcPadding(context);
    final cubit = context.read<AuthCubit>();

    return SafeArea(
      child: Scaffold(
        body: BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              showToast(msg: AppStrings.wellcom);
              navigateReplacement(context, RouteKeys.home);
            } else if (state is LoginFailure) {
              showToast(msg: state.error);
            } else if (state is ConfirmSuccess) {
              showToast(msg: AppStrings.loginNow);
            } else if (state is ConfirmLoading) {
              showToast(msg: AppStrings.checkingInProgress);
            } else if (state is ConfirmFailure) {
              showToast(msg: state.error);
            }
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: padding),
            child: CustomScrollView(
              slivers: [
                const SliverToBoxAdapter(child: SizedBox(height: 40)),
                const SliverToBoxAdapter(child: AppName()),
                const SliverToBoxAdapter(child: SizedBox(height: 60)),

                /// login fields
                const SliverToBoxAdapter(child: LoginForm()),

                /// forgot pass button
                SliverToBoxAdapter(
                  child: TextButtonW(
                    alignment: Alignment.centerRight,
                    text: AppStrings.forgotPassword,
                    onPressed: () =>
                        navigate(context, RouteKeys.forgotPassword),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 100)),

                /// login button
                SliverToBoxAdapter(
                  child: BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      if (state is LoginLoading) {
                        return Center(
                          child: CircularProgressIndicator(
                              color: AppColors.primaryColor),
                        );
                      } else {
                        return MaterialButtonW(
                          text: AppStrings.login,
                          onPressed: () {
                            if (cubit.loginKey.currentState!.validate()) {
                              cubit.login();
                            }
                          },
                        );
                      }
                    },
                  ),
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
