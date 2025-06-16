import 'package:bright_minds/core/functions/calc_padding.dart';
import 'package:bright_minds/core/widgets/back_button.dart';
import 'package:bright_minds/features/video/models/evaluate_model.dart';
import 'package:flutter/material.dart';

class EvaluateView extends StatelessWidget {
  const EvaluateView({super.key, required this.evaluate});
  final EvaluateData evaluate;

  @override
  Widget build(BuildContext context) {
    final padding = calcPadding(context);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: padding),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              leading: const BackButtonW(),
              titleSpacing: 4,
              actions: [Text('${evaluate.grade}/${evaluate.questions.length}')],
              backgroundColor: Colors.white,
            ),
            SliverList.builder(
              itemCount: evaluate.questions.length,
              itemBuilder: (context, index) {
                final item = evaluate.questions[index];
                final question = item.question;
                final userAnswer = item.answer;
                final correctAnswer = question.correctAnswer;
                final isCorrect = item.status;

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${index + 1}. ${question.title}',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        ...[
                          question.option1,
                          question.option2,
                          question.option3,
                          question.option4
                        ].map(
                          (opt) {
                            final bool isOptionCorrect = opt == correctAnswer;
                            final bool isOptionSelectedWrong =
                                opt == userAnswer && !isCorrect;

                            Color? bgColor;
                            if (isOptionCorrect) {
                              bgColor = Colors.green.withAlpha(40);
                            } else if (isOptionSelectedWrong) {
                              bgColor = Colors.red.withAlpha(40);
                            }

                            return Container(
                              margin: const EdgeInsets.symmetric(vertical: 4),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: bgColor,
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Text(opt,
                                          style:
                                              const TextStyle(fontSize: 14))),
                                  if (isOptionCorrect)
                                    const Icon(Icons.check_circle,
                                        color: Colors.green, size: 20)
                                  else if (isOptionSelectedWrong)
                                    const Icon(Icons.cancel,
                                        color: Colors.red, size: 20),
                                ],
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
