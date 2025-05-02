import 'package:bright_minds/core/api/end_point.dart';
import 'package:bright_minds/core/functions/navigation.dart';
import 'package:bright_minds/core/routes/route_keys.dart';
import 'package:bright_minds/core/utils/app_colors.dart';
import 'package:bright_minds/core/utils/app_text_style.dart';
import 'package:flutter/material.dart';

class ChipW extends StatelessWidget {
  const ChipW({super.key, required this.sectionName, required this.sectionId});

  final String sectionName;
  final int sectionId;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => navigate(
        context,
        RouteKeys.video,
        extra: {ApiKey.sectionId: sectionId, ApiKey.sectionName: sectionName},
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Icon(
              Icons.play_arrow,
              size: 18,
              color: AppColors.primaryColor,
            ),
            const SizedBox(width: 3),
            Text(
              sectionName,
              style: AppTextStyle.nunitoSansGrey,
            ),
          ],
        ),
      ),
    );
  }
}
