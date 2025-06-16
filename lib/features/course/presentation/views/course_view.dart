import 'package:bright_minds/core/functions/calc_padding.dart';
import 'package:bright_minds/core/functions/show_toast.dart';
import 'package:bright_minds/core/utils/app_colors.dart';
import 'package:bright_minds/core/utils/app_strings.dart';
import 'package:bright_minds/core/utils/app_text_style.dart';
import 'package:bright_minds/core/widgets/back_button.dart';
import 'package:bright_minds/core/widgets/screen_overview.dart';
import 'package:bright_minds/features/course/cubit/course_cubit.dart';
import 'package:bright_minds/features/course/cubit/course_state.dart';
import 'package:bright_minds/features/course/models/course_model.dart';
import 'package:bright_minds/features/course/presentation/views/course_search_delegate.dart';
import 'package:bright_minds/features/course/presentation/widgets/course_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseView extends StatefulWidget {
  const CourseView({super.key});

  @override
  State<CourseView> createState() => _CourseViewState();
}

class _CourseViewState extends State<CourseView> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 100) {
        context.read<CourseCubit>().loadMoreCourses();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final padding = calcPadding(context);

    return BlocListener<CourseCubit, CourseState>(
      listener: (context, state) {
        if (state is CourseFailure) {
          showToast(msg: state.error);
        }
      },
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: padding),
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.white,
                leading: const BackButtonW(),
      
                /// search
                actions: [
                  BlocBuilder<CourseCubit, CourseState>(
                    builder: (context, state) {
                      return IconButton(
                        onPressed: () {
                          List<CourseItem> itemsList =
                              (state is CourseSuccess) ? state.items : [];
                          showSearch(
                            context: context,
                            delegate: CourseSearchDelegate(
                              list: itemsList,
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.search,
                          color: AppColors.primaryColor,
                        ),
                      );
                    },
                  ),
                ],
                floating: true,
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 20)),
      
              /// screen title
              const SliverToBoxAdapter(
                child: ScreenOverview(
                  title: AppStrings.courses,
                  subTitle: AppStrings.popularCourses,
                ),
              ),
      
              /// courses
              BlocBuilder<CourseCubit, CourseState>(
                builder: (context, state) {
                  // loading state
                  if (state is CourseLoading) {
                    return SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                          child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      )),
                    );
                  }
      
                  List itemsList = [];
      
                  if (state is CourseSuccess) {
                    itemsList = state.items;
                  } else if (state is CourseFailure) {
                    itemsList = state.previousItems;
                  }
      
                  if (itemsList.isEmpty) {
                    return SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: Text(
                          AppStrings.noInstructors,
                          style: AppTextStyle.nunitoSansBlack,
                        ),
                      ),
                    );
                  }
      
                  return SliverGrid.builder(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 400,
                      mainAxisExtent: 110,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    itemCount: itemsList.length,
                    itemBuilder: (context, index) => CourseTile(
                      course: itemsList[index],
                    ),
                  );
                },
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 15)),
      
              /// Loading indicator
              BlocBuilder<CourseCubit, CourseState>(
                builder: (context, state) {
                  if (state is CourseSuccess && state.isLoadingMore) {
                    return SliverToBoxAdapter(
                      child: Center(
                          child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      )),
                    );
                  }
                  return const SliverToBoxAdapter(child: SizedBox.shrink());
                },
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 15)),
            ],
          ),
        ),
      ),
    );
  }
}
