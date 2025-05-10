import 'package:bright_minds/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

abstract class AppTextStyle {
  static final notoSerifPrimary = TextStyle(
    fontFamily: 'NotoSerif',
    fontSize: 30,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryColor,
  );
  static const notoSerifWhite = TextStyle(
    fontFamily: 'NotoSerif',
    fontSize: 18,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );
  static final nunitoSansBlack = const TextStyle(
    fontFamily: 'NunitoSans',
    fontSize: 18,
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );
  static final nunitoSansWhite = const TextStyle(
    fontFamily: 'NunitoSans',
    fontSize: 18,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );
  static final nunitoSansGrey = TextStyle(
    fontFamily: 'NunitoSans',
    fontSize: 13,
    color: Colors.grey[700],
  );
  static final nunitoSansRed = const TextStyle(
    fontFamily: 'NunitoSans',
    fontSize: 18,
    color: Colors.red,
  );
  
}
