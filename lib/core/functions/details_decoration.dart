import 'package:bright_minds/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

EdgeInsets detailsPadding(double padding) =>
    EdgeInsets.symmetric(horizontal: padding / 1.4);

EdgeInsets detailsMargin(double padding) {
  return EdgeInsets.only(
    left: padding / 1.8,
    right: padding / 1.8,
    bottom: padding / 1.5,
  );
}

BoxDecoration detailsDecoration() {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(20),
    border: Border(
      left: BorderSide(color: AppColors.primaryColor, width: 3),
      right: BorderSide(color: AppColors.primaryColor, width: 3),
      bottom: BorderSide(color: AppColors.primaryColor, width: 8),
    ),
  );
}
