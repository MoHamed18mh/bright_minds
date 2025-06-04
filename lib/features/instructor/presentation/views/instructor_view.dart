import 'package:bright_minds/core/functions/calc_padding.dart';
import 'package:bright_minds/core/functions/show_toast.dart';
import 'package:bright_minds/core/utils/app_colors.dart';
import 'package:bright_minds/core/utils/app_strings.dart';
import 'package:bright_minds/core/utils/app_text_style.dart';
import 'package:bright_minds/core/widgets/back_button.dart';
import 'package:bright_minds/core/widgets/screen_overview.dart';
import 'package:bright_minds/features/instructor/cubit/instructor_cubit.dart';
import 'package:bright_minds/features/instructor/cubit/instructor_state.dart';
import 'package:bright_minds/features/instructor/models/instructor_model.dart';
import 'package:bright_minds/features/instructor/presentation/views/instructor_search_delegate.dart';
import 'package:bright_minds/features/instructor/presentation/widgets/instructor_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InstructorView extends StatefulWidget {
  const InstructorView({super.key});

  @override
  State<InstructorView> createState() => _InstructorViewState();
}

class _InstructorViewState extends State<InstructorView> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 100) {
        context.read<InstructorCubit>().loadMoreInstructors();
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

    return BlocListener<InstructorCubit, InstructorState>(
      listener: (context, state) {
        if (state is InstructorFailure) {
          showToast(msg: state.error);
        }
      },
      child: SafeArea(
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
                    BlocBuilder<InstructorCubit, InstructorState>(
                      builder: (context, state) {
                        return IconButton(
                          onPressed: () {
                            List<InstructorItem> itemsList =
                                (state is InstructorSuccess) ? state.items : [];

                            showSearch(
                              context: context,
                              delegate: InstructorSearchDelegate(
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
                    title: AppStrings.instructors,
                    subTitle: AppStrings.expertInstructors,
                  ),
                ),

                /// instructors
                BlocBuilder<InstructorCubit, InstructorState>(
                  builder: (context, state) {
                    // loading state
                    if (state is InstructorLoading) {
                      return SliverFillRemaining(
                        hasScrollBody: false,
                        child: Center(
                            child: CircularProgressIndicator(
                          color: AppColors.primaryColor,
                        )),
                      );
                    }

                    List itemsList = [];

                    if (state is InstructorSuccess) {
                      itemsList = state.items;
                    } else if (state is InstructorFailure) {
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
                      itemBuilder: (context, index) => InstructorTile(
                        instructor: itemsList[index],
                      ),
                    );
                  },
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 15)),

                /// Loading indicator
                BlocBuilder<InstructorCubit, InstructorState>(
                  builder: (context, state) {
                    if (state is InstructorSuccess && state.isLoadingMore) {
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
      ),
    );
  }
}
