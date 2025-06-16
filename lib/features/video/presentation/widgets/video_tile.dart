import 'package:bright_minds/core/api/end_point.dart';
import 'package:bright_minds/core/functions/navigation.dart';
import 'package:bright_minds/core/routes/route_keys.dart';
import 'package:bright_minds/core/utils/app_colors.dart';
import 'package:bright_minds/core/utils/app_text_style.dart';
import 'package:bright_minds/core/widgets/container_shimmer.dart';
import 'package:bright_minds/features/video/models/video_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class VideoTile extends StatelessWidget {
  const VideoTile({super.key, required this.video});

  final VideoData video;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navigate(context, RouteKeys.videoPlay, extra: {
          ApiKey.videoUrl: video.videoStreamUrl,
          ApiKey.id: video.id,
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primaryHighLight,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(width: 1, color: AppColors.primaryColor),
        ),
        child: Row(
          children: [
            // video image cover
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: CachedNetworkImage(
                imageUrl: video.coverUrl,
                height: 110,
                width: 100,
                fit: BoxFit.cover,
                memCacheHeight: 300,
                placeholder: (context, url) => const ContainerShimmer(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            const SizedBox(width: 8),

            // video info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // video title
                  Text(
                    video.name,
                    style: AppTextStyle.nunitoSansBlack,
                  ),

                  // video description
                  Text(
                    video.description,
                    style: AppTextStyle.nunitoSansGrey,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  const SizedBox(height: 10),

                  // video time
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black12.withAlpha(130),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '${video.duration} min',
                      style:
                          AppTextStyle.nunitoSansWhite.copyWith(fontSize: 12),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
