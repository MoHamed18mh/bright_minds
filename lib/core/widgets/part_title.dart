import 'package:bright_minds/core/utils/app_text_style.dart';
import 'package:bright_minds/core/widgets/decoration_lines.dart';
import 'package:flutter/material.dart';

class PartTitle extends StatelessWidget {
  const PartTitle({
    super.key,
    required this.title,
    required this.subTitle,
  });

  final String title, subTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const LeftDecorLines(),
            const SizedBox(width: 5),
            Text(
              title,
              style: AppTextStyle.notoSerifPrimary.copyWith(fontSize: 25),
            ),
            const SizedBox(width: 5),
            const RighDecorLines(),
          ],
        ),
        Text(
          subTitle,
          style: AppTextStyle.nunitoSansBlack.copyWith(fontSize: 22),
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}
