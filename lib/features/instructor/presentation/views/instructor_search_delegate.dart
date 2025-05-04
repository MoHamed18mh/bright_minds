import 'package:bright_minds/core/utils/app_colors.dart';
import 'package:bright_minds/core/utils/app_text_style.dart';
import 'package:bright_minds/core/widgets/back_button.dart';
import 'package:bright_minds/features/instructor/models/instructor_model.dart';
import 'package:bright_minds/features/instructor/presentation/widgets/search_instructor_display.dart';
import 'package:flutter/material.dart';

class InstructorSearchDelegate extends SearchDelegate {
  final List<InstructorItem> list;

  InstructorSearchDelegate({required this.list});

  @override
  TextStyle? get searchFieldStyle => AppTextStyle.nunitoSansBlack;

  @override
  InputDecorationTheme get searchFieldDecorationTheme => InputDecorationTheme(
        contentPadding: const EdgeInsets.all(10),
        hintStyle: AppTextStyle.nunitoSansGrey.copyWith(fontSize: 18),
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
    List<InstructorItem> fillterdList = list
        .where((e) => e.displayName.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return SearchInstructorDisplay(list: fillterdList);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<InstructorItem> fillterdList = list
        .where((e) => e.displayName.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return SearchInstructorDisplay(list: fillterdList);
  }
}
