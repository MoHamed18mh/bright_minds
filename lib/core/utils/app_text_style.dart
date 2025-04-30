import 'package:bright_minds/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

abstract class AppTextStyle {
  static final notoSerif20PrimaryBold = TextStyle(
    fontFamily: 'NotoSerif',
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryColor,
  );
  static final notoSerif25PrimaryBold = TextStyle(
    fontFamily: 'NotoSerif',
    fontSize: 25,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryColor,
  );
  static const notoSerif38WhiteBlod = TextStyle(
    fontFamily: 'NotoSerif',
    fontSize: 38,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );

  static const notoSerif25WhiteBlod = TextStyle(
    fontFamily: 'NotoSerif',
    fontSize: 25,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );
  static var notoSerif22LightBlackBold = TextStyle(
    fontFamily: 'NotoSerif',
    fontSize: 22,
    color: AppColors.lightBlack,
    fontWeight: FontWeight.bold,
  );
  static const nunitoSans15WhiteBlod = TextStyle(
    fontFamily: 'NunitoSans',
    fontSize: 15,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );
  static final nunitoSans18LightBlackBold = TextStyle(
    fontFamily: 'NunitoSans',
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.lightBlack,
  );
  static final nunitoSans22LightBlackBold = TextStyle(
    fontFamily: 'NunitoSans',
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: AppColors.lightBlack,
  );
  static final nunitoSans26LightBlackBold = TextStyle(
    fontFamily: 'NunitoSans',
    fontSize: 26,
    fontWeight: FontWeight.bold,
    color: AppColors.lightBlack,
  );

  static final nunitoSans14Grey800 = TextStyle(
    fontFamily: 'NunitoSans',
    fontSize: 14,
    color: Colors.grey[900],
  );

  //
  static final notoSerifPrimary = TextStyle(
    fontFamily: 'NotoSerif',
    fontSize: 30,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryColor,
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
  static const notoSerifWhite = TextStyle(
    fontFamily: 'NotoSerif',
    fontSize: 18,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );
}
