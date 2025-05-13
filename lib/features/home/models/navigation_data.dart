import 'package:bright_minds/core/routes/route_keys.dart';
import 'package:bright_minds/core/utils/app_assets.dart';
import 'package:bright_minds/core/utils/app_strings.dart';

class NavigationData {
  final String imagePath;
  final String route;

  NavigationData({required this.imagePath, required this.route});
}

Map<String, NavigationData> navigationList = {
  AppStrings.courses: NavigationData(
    imagePath: Assets.assetsImagesCourse,
    route: RouteKeys.course,
  ),
  AppStrings.instructors: NavigationData(
    imagePath: Assets.assetsImagesTeam,
    route: RouteKeys.instructor,
  ),
  AppStrings.myBag: NavigationData(
    imagePath: Assets.assetsImagesMycourses,
    route: RouteKeys.bag,
  ),
};
