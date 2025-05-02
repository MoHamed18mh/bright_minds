import 'package:bright_minds/core/functions/calc_padding.dart';
import 'package:bright_minds/features/course/models/course_model.dart';
import 'package:bright_minds/features/course/presentation/widgets/course_tile.dart';
import 'package:flutter/material.dart';

class SearchCourseDisplay extends StatelessWidget {
  const SearchCourseDisplay({super.key, required this.list});
  final List<CourseItem> list;

  @override
  Widget build(BuildContext context) {
    final padding = calcPadding(context);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: padding / 1.4),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 400,
          mainAxisExtent: 110,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemCount: list.length,
        itemBuilder: (context, index) => CourseTile(course: list[index]),
      ),
    );
  }
}
