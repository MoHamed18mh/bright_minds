import 'package:bright_minds/core/utils/app_assets.dart';
import 'package:bright_minds/core/utils/app_strings.dart';

class BoardingModel {
  final String imagePath;
  final String title;
  final String subTitle;

  BoardingModel(
      {required this.imagePath, required this.title, required this.subTitle});
}

List<BoardingModel> boardingData = [
  BoardingModel(
    imagePath: Assets.assetsImagesBoarding1,
    title: AppStrings.wellcomToBright,
    subTitle: AppStrings.boardingSub1,
  ),
  BoardingModel(
    imagePath: Assets.assetsImagesBoarding2,
    title: AppStrings.learnFromBeast,
    subTitle: AppStrings.boardingSub2,
  ),
];
