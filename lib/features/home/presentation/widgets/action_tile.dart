import 'package:bright_minds/core/functions/navigation.dart';
import 'package:bright_minds/core/utils/app_text_style.dart';
import 'package:bright_minds/features/home/models/actions_model.dart';
import 'package:flutter/material.dart';

class ActionTile extends StatelessWidget {
  const ActionTile({super.key, required this.title, required this.actionData});
  final String title;
  final ActionModel actionData;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => navigate(context, actionData.route),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 6),
        alignment: Alignment.center,
        width: double.infinity,
        height: 90,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          image: DecorationImage(
            image: AssetImage(actionData.imagePath),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withAlpha(125), BlendMode.srcOver),
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
