import 'package:bright_minds/core/routes/route_keys.dart';
import 'package:bright_minds/core/utils/app_assets.dart';
import 'package:bright_minds/core/utils/app_strings.dart';

class NavigationModel {
  final String imagePath;
  final String route;

  NavigationModel({required this.imagePath, required this.route});
}

Map<String, NavigationModel> navigationList = {
  AppStrings.courses: NavigationModel(
    imagePath: Assets.assetsImagesCourse,
    route: RouteKeys.course,
  ),
  AppStrings.instructors: NavigationModel(
    imagePath: Assets.assetsImagesTeam,
    route: RouteKeys.instructor,
  ),
  AppStrings.myBag: NavigationModel(
    imagePath: Assets.assetsImagesMycourses,
    route: RouteKeys.cart,
  ),
};
