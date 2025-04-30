import 'package:bright_minds/core/utils/app_colors.dart';
import 'package:bright_minds/core/utils/app_text_style.dart';
import 'package:bright_minds/features/home/models/service_model.dart';
import 'package:flutter/material.dart';

class ServicesItem extends StatelessWidget {
  const ServicesItem({super.key, required this.title, required this.service});
  final String title;
  final ServiceModel service;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primaryHighLight,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            service.iconData,
            size: 50,
            color: AppColors.primaryColor,
          ),
          const SizedBox(height: 20),
          Text(
            title,
            style: AppTextStyle.nunitoSansBlack.copyWith(fontSize: 22),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Text(
            service.subTitle,
            softWrap: true,
            textAlign: TextAlign.center,
            style: AppTextStyle.nunitoSansGrey.copyWith(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
