import 'package:flutter/material.dart';
import 'package:vigilant_spork/api/news/model/quiz_data.dart';

class QuizElement extends StatelessWidget {
  final Question question;
  final VoidCallback onNextPage;
  final VoidCallback onSucccess;
  const QuizElement({
    super.key,
    required this.question,
    required this.onNextPage,
    required this.onSucccess,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          question.value,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ElevatedButton(
            onPressed: () {
              onSucccess();
            },
            child: Text(question.variants[0]),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ElevatedButton(
            onPressed: () {
              onNextPage();
            },
            child: Text(question.variants[1]),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ElevatedButton(
            onPressed: () {},
            child: Text(question.variants[2]),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ElevatedButton(
            onPressed: () {},
            child: Text(question.variants[3]),
          ),
        ),
      ],
    );
  }
}
