import 'package:flutter/material.dart';

class ServiceModel {
  final String subTitle;
  final IconData iconData;

  ServiceModel({required this.subTitle, required this.iconData});
}

Map<String, ServiceModel> servicesList = {
  'Skilled Instructors': ServiceModel(
    subTitle:
        'Diam elitr kasd sed at elitr sed ipsum justo dolor sed clita amet diam',
    iconData: Icons.school,
  ),
  'Online Classes': ServiceModel(
    subTitle:
        'Diam elitr kasd sed at elitr sed ipsum justo dolor sed clita amet diam',
    iconData: Icons.language_rounded,
  ),
  'Home Projects': ServiceModel(
    subTitle:
        'Diam elitr kasd sed at elitr sed ipsum justo dolor sed clita amet diam',
    iconData: Icons.home_rounded,
  ),
  'Book Library': ServiceModel(
    subTitle:
        'Diam elitr kasd sed at elitr sed ipsum justo dolor sed clita amet diam',
    iconData: Icons.menu_book_outlined,
  ),
};

List<String> skills = [
  'Skilled Instructors',
  'Online Classes',
  'International Certificate',
];
