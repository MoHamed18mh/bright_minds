import 'package:bright_minds/core/functions/calc_padding.dart';
import 'package:bright_minds/core/functions/navigation.dart';
import 'package:bright_minds/core/functions/show_toast.dart';
import 'package:bright_minds/core/routes/route_keys.dart';
import 'package:bright_minds/core/utils/app_colors.dart';
import 'package:bright_minds/core/utils/app_strings.dart';
import 'package:bright_minds/core/widgets/back_button.dart';
import 'package:bright_minds/core/widgets/material_button.dart';
import 'package:bright_minds/core/widgets/text_field.dart';
import 'package:bright_minds/features/auth/cubit/auth_cubit.dart';
import 'package:bright_minds/features/auth/cubit/auth_state.dart';
import 'package:bright_minds/features/auth/presentation/widgets/title_overview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = calcPadding(context);
    final cubit = context.read<AuthCubit>();

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is ForgotSuccess) {
          showToast(msg: AppStrings.pleaseCheckEmail);
          navigateReplacement(context, RouteKeys.login);
        } else if (state is ForgotFailure) {
          showToast(msg: state.error);
        }
      },
      child: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: padding),
            child: CustomScrollView(
              slivers: [
                const SliverToBoxAdapter(child: BackButtonW()),
                const SliverToBoxAdapter(child: SizedBox(height: 26)),
                const SliverToBoxAdapter(
                  child: TitleOverView(
                    text1: AppStrings.enterEmail,
                    text2: AppStrings.willSendMessage,
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 30)),

                /// email field
                SliverToBoxAdapter(
                  child: Form(
                    key: cubit.forgotKey,
                    child: TextFieldW(
                      text: AppStrings.email,
                      prefixIcon: const Icon(Icons.email_outlined),
                      controller: cubit.emailForgotController,
                    ),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 50)),

                /// send email button
                SliverToBoxAdapter(
                  child: BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      if (state is ForgotLoading) {
                        return Center(
                          child: CircularProgressIndicator(
                              color: AppColors.primaryColor),
                        );
                      }
                      return MaterialButtonW(
                        onPressed: () {
                          if (cubit.forgotKey.currentState!.validate()) {
                            cubit.forgotPassword();
                          }
                        },
                        text: AppStrings.sendEmail,
                      );
                    },
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
