import 'package:bright_minds/core/utils/app_colors.dart';
import 'package:bright_minds/core/utils/app_text_style.dart';
import 'package:bright_minds/core/widgets/back_button.dart';
import 'package:bright_minds/features/course/models/course_model.dart';
import 'package:bright_minds/features/course/presentation/widgets/search_course_display.dart';
import 'package:flutter/material.dart';

class CourseSearchDelegate extends SearchDelegate {
  final List<CourseItem> list;

  CourseSearchDelegate({required this.list});

  @override
  TextStyle? get searchFieldStyle => AppTextStyle.nunitoSansBlack;

  @override
  InputDecorationTheme get searchFieldDecorationTheme => InputDecorationTheme(
        hintStyle: AppTextStyle.nunitoSansGrey.copyWith(fontSize: 18),
        contentPadding: const EdgeInsets.symmetric(vertical: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Colors.grey, 
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: AppColors.primaryColor,
          ),
        ),
      );

  @override
  List<Widget>? buildActions(BuildContext context) {
    return null;
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return const BackButtonW();
  }

  @override
  Widget buildResults(BuildContext context) {
    List<CourseItem> fillterdList = list
        .where((e) => e.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return SearchCourseDisplay(list: fillterdList);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<CourseItem> fillterdList = list
        .where((e) => e.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return SearchCourseDisplay(list: fillterdList);
  }
}
