import 'package:bright_minds/core/functions/calc_padding.dart';
import 'package:bright_minds/core/functions/navigation.dart';
import 'package:bright_minds/core/routes/route_keys.dart';
import 'package:bright_minds/core/utils/app_assets.dart';
import 'package:bright_minds/core/utils/app_colors.dart';
import 'package:bright_minds/core/widgets/app_name.dart';
import 'package:bright_minds/features/home/models/navigation_model.dart';
import 'package:bright_minds/features/home/models/service_model.dart';
import 'package:bright_minds/features/home/presentation/widgets/navigation_tile.dart';
import 'package:bright_minds/features/home/presentation/widgets/services_item.dart';
import 'package:bright_minds/features/home/presentation/widgets/skills.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = calcPadding(context);

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(left: padding, right: padding, top: 4),
          child: CustomScrollView(
            physics: const ClampingScrollPhysics(),
            slivers: [
              /// app bar
              SliverAppBar(
                leading: Image.asset(Assets.assetsImagesLogo),
                titleSpacing: 6,
                title: const AppName(alignment: Alignment.centerLeft),
                actions: [
                  /// profile button
                  IconButton(
                    onPressed: () => navigate(context, RouteKeys.profile),
                    icon: Icon(
                      Icons.person,
                      size: 45,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
                floating: true,
                backgroundColor: Colors.white,
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 20)),

              /// navigate screens
              SliverList.builder(
                itemCount: navigationList.length,
                itemBuilder: (context, index) {
                  String title = navigationList.keys.elementAt(index);
                  NavigationModel actionData = navigationList[title]!;

                  return NavigationTile(title: title, actionData: actionData);
                },
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 80)),

              /// services section
              SliverGrid.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 400,
                  mainAxisExtent: 290,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemCount: servicesList.length,
                itemBuilder: (context, index) {
                  String title = servicesList.keys.elementAt(index);
                  ServiceModel service = servicesList[title]!;

                  return ServicesItem(title: title, service: service);
                },
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 80)),

              /// skills section
              SliverGrid(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 400,
                  mainAxisExtent: 250,
                  crossAxisSpacing: 20,
                  childAspectRatio: .75,
                ),
                delegate: SliverChildListDelegate(
                  [
                    Image.asset(
                      Assets.assetsImagesAbout,
                      height: 250,
                      fit: BoxFit.cover,
                    ),
                    const Skills(),
                  ],
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 80)),
            ],
          ),
        ),
      ),
    );
  }
}
