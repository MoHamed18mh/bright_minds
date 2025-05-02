import 'package:bright_minds/core/utils/app_text_style.dart';
import 'package:bright_minds/core/widgets/back_button.dart';
import 'package:bright_minds/core/widgets/container_shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CourseImage extends StatelessWidget {
  const CourseImage(
      {super.key,
      required this.pictureUrl,
      required this.courseName,
      required this.instructorName});
  final String pictureUrl;
  final String courseName;
  final String instructorName;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: CachedNetworkImage(
            imageUrl: pictureUrl,
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
            memCacheHeight: 230,
            placeholder: (context, url) => const ContainerShimmer(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
        Container(
          width: double.infinity,
          height: 200,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Colors.black,
                Colors.black.withAlpha(70),
                Colors.black.withAlpha(50),
                Colors.black.withAlpha(30),
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                courseName,
                style: AppTextStyle.notoSerifWhite.copyWith(fontSize: 22),
              ),
              Text(
                instructorName,
                style: AppTextStyle.nunitoSansWhite.copyWith(fontSize: 16),
              ),
            ],
          ),
        ),
        const Positioned(
          top: 20,
          child: BackButtonW(),
        )
      ],
    );
  }
}
