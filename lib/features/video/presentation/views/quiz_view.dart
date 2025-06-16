import 'package:bright_minds/core/functions/calc_padding.dart';
import 'package:bright_minds/core/functions/navigation.dart';
import 'package:bright_minds/core/functions/show_toast.dart';
import 'package:bright_minds/core/routes/route_keys.dart';
import 'package:bright_minds/core/utils/app_colors.dart';
import 'package:bright_minds/core/utils/app_strings.dart';
import 'package:bright_minds/core/utils/app_text_style.dart';
import 'package:bright_minds/core/widgets/back_button.dart';
import 'package:bright_minds/core/widgets/material_button.dart';
import 'package:bright_minds/features/video/cubit/video_cubit.dart';
import 'package:bright_minds/features/video/cubit/video_state.dart';
import 'package:bright_minds/features/video/presentation/widgets/question_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuizView extends StatelessWidget {
  const QuizView({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = calcPadding(context);
    final cubit = context.read<VideoCubit>();

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: padding),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              leading: const BackButtonW(),
              titleSpacing: 4,
              title: Text(
                AppStrings.quiz,
                style: AppTextStyle.nunitoSansBlack,
              ),
              backgroundColor: Colors.white,
            ),

            /// questions
            BlocConsumer<VideoCubit, VideoState>(
              listener: (context, state) {
                if (state is QuizFailure) {
                  showToast(msg: state.error);
                  navigatePop(context);
                } else if (state is EvaluateFailure) {
                  showToast(msg: state.error);
                  navigatePop(context);
                } else if (state is EvaluateSuccess) {
                  navigateReplacement(context, RouteKeys.evaluate,
                      extra: state.evaluate.data);
                }
              },
              builder: (context, state) {
                if (state is QuizSuccess) {
                  final questions = state.quiz.data.questions;

                  return SliverList.builder(
                    itemCount: questions.length + 1,
                    itemBuilder: (context, index) {
                      if (index != questions.length) {
                        final q = questions[index];

                        return QuestionCard(q: q, index: index);
                      }

                      return Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 50, horizontal: padding * 1.4),
                        child: MaterialButtonW(
                          text: AppStrings.submmit,
                          onPressed: () {
                            if (questions.length ==
                                cubit.selectedAnswers.length) {
                              cubit.submitAnswers(state.quiz.data.id);
                            } else {
                              showToast(msg: AppStrings.answerAllQuestion);
                            }
                          },
                        ),
                      );
                    },
                  );
                }

                return SliverFillRemaining(
                  child: Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
