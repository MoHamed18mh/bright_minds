import 'package:bright_minds/core/functions/navigation.dart';
import 'package:bright_minds/core/utils/app_text_style.dart';
import 'package:bright_minds/features/home/models/navigation_model.dart';
import 'package:flutter/material.dart';

class NavigationTile extends StatelessWidget {
  const NavigationTile(
      {super.key, required this.title, required this.actionData});
  final String title;
  final NavigationModel actionData;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => navigate(context, actionData.route),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
        alignment: Alignment.center,
        width: double.infinity,
        height: 86,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          image: DecorationImage(
            image: AssetImage(actionData.imagePath),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withAlpha(130), BlendMode.srcOver),
          ),
        ),
        child: Text(
          title,
          style: AppTextStyle.notoSerifWhite.copyWith(fontSize: 35),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
