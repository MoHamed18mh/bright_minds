import 'package:bright_minds/core/functions/calc_padding.dart';
import 'package:bright_minds/core/functions/show_toast.dart';
import 'package:bright_minds/core/utils/app_colors.dart';
import 'package:bright_minds/core/utils/app_strings.dart';
import 'package:bright_minds/core/widgets/back_button.dart';
import 'package:bright_minds/core/widgets/container_shimmer.dart';
import 'package:bright_minds/core/widgets/part_title.dart';
import 'package:bright_minds/features/instructor/cubit/instructor_cubit.dart';
import 'package:bright_minds/features/instructor/cubit/instructor_state.dart';
import 'package:bright_minds/features/instructor/presentation/views/instructor_search_view.dart';
import 'package:bright_minds/features/instructor/presentation/widgets/instructor_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InstructorView extends StatelessWidget {
  const InstructorView({super.key});

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
                            showSearch(
                              context: context,
                              delegate: InstructorSearchView(
                                list: (state is InstructorSuccess)
                                    ? state.instructor.data.items
                                    : [],
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
                  child: PartTitle(
                    title: AppStrings.instructors,
                    subTitle: AppStrings.expertInstructors,
                  ),
                ),

                /// instructors
                BlocBuilder<InstructorCubit, InstructorState>(
                  builder: (context, state) {
                    return SliverGrid.builder(
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 400,
                        mainAxisExtent: 110,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                      ),
                      itemCount: (state is InstructorSuccess)
                          ? state.instructor.data.items.length
                          : 3,
                      itemBuilder: (context, index) {
                        if (state is InstructorSuccess) {
                          return InstructorTile(
                              instructor: state.instructor.data.items[index]);
                        }
                        return const ContainerShimmer();
                      },
                    );
                  },
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 30)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
