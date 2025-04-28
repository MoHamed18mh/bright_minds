
import 'package:bright_minds/core/utils/app_assets.dart';

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
    title: 'Welcome To Bright Minds',
    subTitle:
        'Discover a World of knowledge at your fingertips with \'Bright Minds\' comprehensive learning platform',
  ),
  BoardingModel(
    imagePath: Assets.assetsImagesBoarding2,
    title: 'Learn From The Best',
    subTitle:
        'Access high-quality courses from top educators and industry experts, anytime, anywhere',
  ),
];
