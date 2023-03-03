import 'package:flutter/material.dart';
import 'package:vigilant_spork/api/news/model/quiz_data.dart';
import 'package:vigilant_spork/widgets/quiz_button.dart';

class QuizElement extends StatefulWidget {
  final Question question;
  final ValueChanged<int> onSucccess;
  final VoidCallback onNextPage;

  const QuizElement({
    super.key,
    required this.question,
    required this.onNextPage,
    required this.onSucccess,
  });

  @override
  State<QuizElement> createState() => _QuizElementState();
}

class _QuizElementState extends State<QuizElement> {
  final ValueNotifier<int> _currentIndex = ValueNotifier<int>(-1);
  @override
  void dispose() {
    _currentIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            widget.question.value,
            textAlign: TextAlign.center,
            style: DefaultTextStyle.of(context)
                .style
                .copyWith(fontWeight: FontWeight.w600, fontSize: 20),
          ),
          const SizedBox(
            height: 20,
          ),
          ...List.generate(
              4,
              (index) => QuizButton(
                    currentIndex: _currentIndex,
                    onSucccess: widget.onSucccess,
                    question: widget.question,
                    index: index,
                    onNextPage: widget.onNextPage,
                  ))
            ..shuffle()
        ],
      ),
    ));
  }
}
