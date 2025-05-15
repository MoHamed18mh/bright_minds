import 'package:bright_minds/core/functions/calc_padding.dart';
import 'package:bright_minds/core/functions/navigation.dart';
import 'package:bright_minds/core/functions/show_toast.dart';
import 'package:bright_minds/core/routes/route_keys.dart';
import 'package:bright_minds/core/utils/app_colors.dart';
import 'package:bright_minds/core/utils/app_strings.dart';
import 'package:bright_minds/core/widgets/material_button.dart';
import 'package:bright_minds/features/auth/cubit/auth_cubit.dart';
import 'package:bright_minds/features/auth/cubit/auth_state.dart';
import 'package:bright_minds/features/auth/presentation/widgets/forms/reset_password_form.dart';
import 'package:bright_minds/features/auth/presentation/widgets/title_overview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView(
      {super.key, required this.email, required this.token});
  final String email;
  final String token;

  @override
  Widget build(BuildContext context) {
    final padding = calcPadding(context);
    final cubit = context.read<AuthCubit>();

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is ResetSuccess) {
          showToast(msg: state.success);
          navigateReplacement(context, RouteKeys.login);
        } else if (state is ResetFailure) {
          showToast(msg: state.error);
        }
      },
      child: SafeArea(
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

                /// reset password feilds
                SliverToBoxAdapter(
                    child: ResetPasswordForm(email: email, token: token)),
                const SliverToBoxAdapter(child: SizedBox(height: 50)),

                /// button create new password
                SliverToBoxAdapter(
                  child: BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      if (state is ResetLoading) {
                        return Center(
                          child: CircularProgressIndicator(
                              color: AppColors.primaryColor),
                        );
                      }
                      return MaterialButtonW(
                        onPressed: () {
                          cubit.resetPass(email, token);
                        },
                        text: AppStrings.createNewPassword,
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
