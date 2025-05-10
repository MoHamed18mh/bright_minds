import 'package:bright_minds/core/utils/app_text_style.dart';
import 'package:bright_minds/core/widgets/back_button.dart';
import 'package:bright_minds/core/widgets/container_shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CourseImage extends StatelessWidget {
  const CourseImage({
    super.key,
    required this.pictureUrl,
    required this.courseName,
    required this.instructorName,
    this.rate,
  });
  final String pictureUrl;
  final String courseName;
  final String instructorName;
  final String? rate;

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
            memCacheHeight: 300,
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
        ),
        (rate != null)
            ? Positioned(
                right: 30,
                bottom: 20,
                child: Row(
                  children: [
                    Text(
                      rate!,
                      style: AppTextStyle.notoSerifWhite,
                    ),
                    const SizedBox(width: 6),
                    const Icon(
                      Icons.star,
                      color: Colors.yellow,
                    )
                  ],
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
