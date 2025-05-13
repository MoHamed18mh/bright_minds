import 'package:bright_minds/core/functions/navigation.dart';
import 'package:bright_minds/core/routes/route_keys.dart';
import 'package:bright_minds/core/utils/app_colors.dart';
import 'package:bright_minds/core/utils/app_text_style.dart';
import 'package:bright_minds/core/widgets/container_shimmer.dart';
import 'package:bright_minds/features/course/models/course_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class UserCourseTile extends StatelessWidget {
  const UserCourseTile({super.key, required this.course});

  final CourseItem course;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navigate(
          context,
          RouteKeys.userCourse,
          extra: course,
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primaryHighLight,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(width: 1, color: AppColors.primaryColor),
        ),
        child: Row(
          children: [
            /// course image
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: CachedNetworkImage(
                imageUrl: course.pictureUrl,
                height: 110,
                width: 100,
                memCacheHeight: 300,
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
                  /// course name
                  Text(
                    course.name,
                    style: AppTextStyle.nunitoSansBlack.copyWith(fontSize: 22),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),

                  /// instructor name
                  Text(
                    course.instructorName,
                    style: AppTextStyle.nunitoSansGrey,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  const SizedBox(height: 5),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
