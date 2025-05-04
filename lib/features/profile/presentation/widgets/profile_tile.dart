import 'package:bright_minds/core/utils/app_colors.dart';
import 'package:bright_minds/core/utils/app_text_style.dart';
import 'package:flutter/material.dart';

class ProfileTile extends StatelessWidget {
  const ProfileTile(
      {super.key, required this.iconData, required this.itemTitle, this.onTap});

  final IconData iconData;
  final String itemTitle;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(top: 12),
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  iconData,
                  color: AppColors.primaryColor,
                  size: 31,
                ),
                const SizedBox(width: 18),
                Text(itemTitle, style: AppTextStyle.nunitoSansBlack),
                const Spacer(),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black45,
                  size: 20,
                )
              ],
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
