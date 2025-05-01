import 'package:bright_minds/core/utils/app_colors.dart';
import 'package:bright_minds/core/utils/app_text_style.dart';
import 'package:bright_minds/core/widgets/back_button.dart';
import 'package:bright_minds/features/instructor/presentation/widgets/search_display.dart';
import 'package:flutter/material.dart';

class InstructorSearchView extends SearchDelegate {
  final List list;

  InstructorSearchView({required this.list});

  @override
  TextStyle? get searchFieldStyle => AppTextStyle.nunitoSansBlack;

  @override
  InputDecorationTheme get searchFieldDecorationTheme => InputDecorationTheme(
        hintStyle: AppTextStyle.nunitoSansGrey.copyWith(fontSize: 18),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8), // حواف دائرية
          borderSide: const BorderSide(
            color: Colors.grey, // لون الإطار
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: AppColors.primaryColor, // لون الإطار عند التركيز
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
    List fillterdList = list
        .where((e) => e.displayName.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return SearchDisplay(list: fillterdList);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List fillterdList = list
        .where((e) => e.displayName.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return SearchDisplay(list: fillterdList);
  }
}
