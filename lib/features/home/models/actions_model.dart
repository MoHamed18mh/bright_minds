import 'package:bright_minds/core/routes/route_keys.dart';
import 'package:bright_minds/core/utils/app_assets.dart';

class ActionModel {
  final String imagePath;
  final String route;

  ActionModel({required this.imagePath, required this.route});
}

Map<String, ActionModel> actionsList = {
  'Courses': ActionModel(
    imagePath: Assets.assetsImagesCourse,
    route: RouteKeys.course,
  ),
  'Instructors': ActionModel(
    imagePath: Assets.assetsImagesTeam,
    route: RouteKeys.instructor,
  ),
  'Contact': ActionModel(
    imagePath: Assets.assetsImagesContactus,
    route: RouteKeys.contact,
  ),
};
