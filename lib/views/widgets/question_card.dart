import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studypress_new/models/single_question_model.dart';

import '../../controllers/practise_chapter_controller.dart';


class QuestionCard extends StatelessWidget {
  final SingleQuestionModel question;
  final int index;
  final PractiseChapterController controller;

  const QuestionCard({
    super.key,
    required this.question,
    required this.index,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      child: Card(
        elevation: 2,
        child: Padding(
          padding: EdgeInsets.all(12.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${index + 1}. ${question.question}",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8.h),

              if (question.options != null)
                ...List.generate((question.options?.length??0), (optIndex) {
                  final option = question.options![optIndex];
                  final selected = controller.myAnswers[index] == option;
                  return ListTile(
                    title: Text(option),
                    leading: Radio(
                      value: option,
                      groupValue: controller.myAnswers[index],
                      onChanged: (value) {
                        controller.selectAnswer(index, value);
                      },
                    ),
                    selected: selected,
                  );
                }),

              if (question.hints != null)
                ExpansionTile(
                  title: Text("Explanation"),
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        question.hints??"",
                        style: TextStyle(fontSize: 14.sp, color: Colors.grey[700]),
                      ),
                    )
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
