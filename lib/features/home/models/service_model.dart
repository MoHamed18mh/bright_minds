import 'package:bright_minds/core/utils/app_strings.dart';
import 'package:flutter/material.dart';

class ServiceModel {
  final String subTitle;
  final IconData iconData;

  ServiceModel({required this.subTitle, required this.iconData});
}

Map<String, ServiceModel> servicesList = {
  AppStrings.skilledInstructors: ServiceModel(
    subTitle: AppStrings.dimaElitr,
    iconData: Icons.school,
  ),
  AppStrings.onlineClasses: ServiceModel(
    subTitle: AppStrings.dimaElitr,
    iconData: Icons.language_rounded,
  ),
  AppStrings.homeProjects: ServiceModel(
    subTitle: AppStrings.dimaElitr,
    iconData: Icons.home_rounded,
  ),
  AppStrings.bookLibrary: ServiceModel(
    subTitle: AppStrings.dimaElitr,
    iconData: Icons.menu_book_outlined,
  ),
};

List<String> skills = [
  AppStrings.skilledInstructors,
  AppStrings.onlineClasses,
  AppStrings.internationalCerificate,
];
