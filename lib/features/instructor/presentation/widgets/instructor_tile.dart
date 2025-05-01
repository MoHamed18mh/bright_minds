import 'package:bright_minds/core/functions/navigation.dart';
import 'package:bright_minds/core/routes/route_keys.dart';
import 'package:bright_minds/core/utils/app_colors.dart';
import 'package:bright_minds/core/utils/app_text_style.dart';
import 'package:bright_minds/core/widgets/container_shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:bright_minds/features/instructor/models/instructor_model.dart';
import 'package:flutter/material.dart';

class InstructorTile extends StatelessWidget {
  const InstructorTile({super.key, required this.instructor});
  final InstructorItems instructor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => navigate(
        context,
        RouteKeys.instructorDetails,
        extra: instructor,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primaryHighLight,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(width: 1, color: AppColors.primaryColor),
        ),
        child: Row(
          children: [
            /// instructon image
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: CachedNetworkImage(
                imageUrl: instructor.imageCover,
                height: 110,
                width: 100,
                memCacheHeight: 110,
                fit: BoxFit.cover,
                placeholder: (context, url) => const ContainerShimmer(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            const SizedBox(width: 20),

            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /// instructor name
                  Text(
                    instructor.displayName,
                    style: AppTextStyle.nunitoSansBlack.copyWith(fontSize: 22),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  const SizedBox(height: 6),

                  /// instructor job
                  Text(
                    instructor.jobTitle,
                    style: AppTextStyle.nunitoSansGrey,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
