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
import 'package:bright_minds/features/auth/presentation/widgets/forms/register_form.dart';
import 'package:bright_minds/features/auth/presentation/widgets/text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = calcPadding(context);
    final cubit = context.read<AuthCubit>();

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          showToast(msg: AppStrings.pleaseCheckEmail);
          navigateReplacement(context, RouteKeys.login);
        } else if (state is RegisterFailure) {
          showToast(msg: state.error);
        }
      },
      child: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: padding),
            child: CustomScrollView(
              slivers: [
                const SliverToBoxAdapter(child: SizedBox(height: 20)),
                const SliverToBoxAdapter(child: AppName()),
                const SliverToBoxAdapter(child: SizedBox(height: 30)),

                /// register fields
                const SliverToBoxAdapter(child: RegisterForm()),
                const SliverToBoxAdapter(child: SizedBox(height: 80)),

                /// register button
                SliverToBoxAdapter(
                  child: BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      if (state is RegisterLoading) {
                        return Center(
                          child: CircularProgressIndicator(
                              color: AppColors.primaryColor),
                        );
                      } else {
                        return MaterialButtonW(
                          text: AppStrings.register,
                          onPressed: () {
                            if (cubit.registerKey.currentState!.validate()) {
                              cubit.register();
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
                    text: AppStrings.alreadyHaveAccount,
                    onPressed: () =>
                        navigateReplacement(context, RouteKeys.login),
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
