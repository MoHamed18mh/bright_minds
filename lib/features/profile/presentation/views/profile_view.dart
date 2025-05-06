import 'package:bright_minds/core/functions/calc_padding.dart';
import 'package:bright_minds/core/functions/details_decoration.dart';
import 'package:bright_minds/core/functions/navigation.dart';
import 'package:bright_minds/core/functions/show_toast.dart';
import 'package:bright_minds/core/routes/route_keys.dart';
import 'package:bright_minds/core/utils/app_colors.dart';
import 'package:bright_minds/core/utils/app_text_style.dart';
import 'package:bright_minds/core/widgets/back_button.dart';
import 'package:bright_minds/features/profile/cubit/profile_cubit.dart';
import 'package:bright_minds/features/profile/cubit/profile_state.dart';
import 'package:bright_minds/features/profile/presentation/widgets/delete_logout_buttons.dart';
import 'package:bright_minds/features/profile/presentation/widgets/edit_button.dart';
import 'package:bright_minds/features/profile/presentation/widgets/user_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = calcPadding(context);

    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: detailsMargin(padding),
          padding: detailsPadding(padding),
          decoration: detailsDecoration(),
          child: CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(child: BackButtonW()),
              const SliverToBoxAdapter(child: SizedBox(height: 12)),

              /// main details
              SliverToBoxAdapter(
                child: BlocConsumer<ProfileCubit, ProfileState>(
                  listener: (context, state) {
                    if (state is LogOutSuccess) {
                      navigateAndRemoveUntil(context, RouteKeys.login);
                    } else if (state is LogOutFailure) {
                      showToast(msg: state.error);
                    } else if (state is DeleteSuccess) {
                      navigateAndRemoveUntil(context, RouteKeys.register);
                    } else if (state is DeleteFailure) {
                      showToast(msg: state.error);
                    }
                  },
                  builder: (context, state) {
                    if (state is UserSuccess) {
                      final user = state.user.data;

                      return Column(
                        children: [
                          /// user image
                          UserImage(imageCover: user.imageCover),
                          const SizedBox(height: 40),

                          /// user name
                          Text(
                            user.displayName,
                            style: AppTextStyle.nunitoSansBlack
                                .copyWith(fontSize: 22),
                          ),
                          const SizedBox(height: 10),

                          /// user email
                          Text(
                            user.email,
                            style: AppTextStyle.nunitoSansBlack
                                .copyWith(fontSize: 14),
                          ),
                          const SizedBox(height: 7),

                          /// user phone
                          Text(
                            user.mobile,
                            style: AppTextStyle.nunitoSansBlack
                                .copyWith(fontSize: 14),
                          ),
                          const SizedBox(height: 25),

                          /// edit button
                          EditButton(user: user),
                          const SizedBox(height: 45),

                          const DeleteAndLogOutButtons(),
                        ],
                      );
                    } else if (state is UserFailure) {
                      return Text(
                        state.error,
                        style: AppTextStyle.notoSerifPrimary
                            .copyWith(fontSize: 18),
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ),
                    );
                  },
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 30)),
            ],
          ),
        ),
      ),
    );
  }
}






