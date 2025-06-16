import 'package:bright_minds/core/utils/app_colors.dart';
import 'package:bright_minds/core/utils/app_text_style.dart';
import 'package:bright_minds/features/video/cubit/video_cubit.dart';
import 'package:bright_minds/features/video/models/quiz_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuestionCard extends StatefulWidget {
  const QuestionCard({super.key, required this.q, required this.index});

  final Question q;
  final int index;

  @override
  State<QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<VideoCubit>();

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${widget.index + 1}. ${widget.q.title}',
              style: AppTextStyle.nunitoSansBlack,
            ),
            const SizedBox(height: 8),
            ...[
              widget.q.option1,
              widget.q.option2,
              widget.q.option3,
              widget.q.option4
            ].map(
              (opt) {
                return RadioListTile(
                  title: Text(opt),
                  value: opt,
                  groupValue: cubit.selectedAnswers[widget.q.id],
                  onChanged: (val) => setState(
                    () => cubit.selectedAnswers[widget.q.id] = val!,
                  ),
                  activeColor: AppColors.primaryColor,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
