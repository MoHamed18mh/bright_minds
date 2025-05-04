import 'package:bright_minds/core/functions/calc_padding.dart';
import 'package:bright_minds/core/functions/details_decoration.dart';
import 'package:bright_minds/core/utils/app_colors.dart';
import 'package:bright_minds/core/utils/app_text_style.dart';
import 'package:bright_minds/core/widgets/back_button.dart';
import 'package:bright_minds/core/widgets/container_shimmer.dart';
import 'package:bright_minds/features/instructor/models/instructor_model.dart';
import 'package:bright_minds/features/instructor/presentation/widgets/contact_item.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class InstructorDetailsView extends StatelessWidget {
  const InstructorDetailsView({super.key, required this.instructor});

  final InstructorItem instructor;

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

              /// instructor image
              SliverToBoxAdapter(
                child: Center(
                  child: Container(
                    height: 160,
                    width: 160,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primaryColor,
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: instructor.imageCover,
                        fit: BoxFit.cover,
                        memCacheHeight: 300,
                        placeholder: (context, url) => const ContainerShimmer(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 8)),

              /// instructor name and job
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    SelectableText(
                      instructor.displayName,
                      style:
                          AppTextStyle.nunitoSansBlack.copyWith(fontSize: 22),
                    ),
                    Text(
                      instructor.jobTitle,
                      style:
                          AppTextStyle.nunitoSansBlack.copyWith(fontSize: 16),
                    ),
                  ],
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 30)),

              /// description
              SliverToBoxAdapter(
                child: Text(
                  instructor.qualifications,
                  style: AppTextStyle.nunitoSansGrey,
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 30)),

              /// contact
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    ContactItem(text: instructor.email, iconData: Icons.email),
                    const SizedBox(height: 20),
                    ContactItem(text: instructor.mobile, iconData: Icons.phone)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
