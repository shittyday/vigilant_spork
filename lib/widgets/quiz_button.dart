import 'package:flutter/material.dart';
import 'package:vigilant_spork/api/news/model/quiz_data.dart';

class QuizButton extends StatefulWidget {
  final Question question;
  final ValueChanged<int> onSucccess;
  final int index;
  final ValueNotifier<int> currentIndex;
  final VoidCallback onNextPage;
  const QuizButton({
    super.key,
    required this.onSucccess,
    required this.question,
    required this.index,
    required this.currentIndex,
    required this.onNextPage,
  });

  @override
  State<QuizButton> createState() => _QuizButtonState();
}

class _QuizButtonState extends State<QuizButton> {
  bool success = false;
  bool init = true;
  int milliseconds = 500;
  bool disabled = false;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: widget.currentIndex,
        builder: (context, value, child) {
          if (widget.index == value) {
            init = false;
            success = true;
            milliseconds = 850;
            disabled = true;
          } else if (value != -1) {
            disabled = true;
          }
          return GestureDetector(
              onTap: disabled
                  ? null
                  : () {
                      setState(() {
                        disabled = true;
                        init = false;
                        success = widget.question.variantAnswers[widget.index];
                        if (!success) {
                          widget.currentIndex.value = widget
                              .question.variantAnswers
                              .asMap()
                              .entries
                              .where((element) => element.value)
                              .first
                              .key;
                        } else {
                          widget.onSucccess(widget.index);
                        }
                        widget.onNextPage();
                      });
                    },
              child: AnimatedContainer(
                duration: Duration(milliseconds: milliseconds),
                margin: const EdgeInsets.all(5),
                alignment: Alignment.center,
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2,
                    color: Colors.white.withOpacity(.5),
                  ),
                  borderRadius: BorderRadius.circular(20),
                  color: _caseColor(),
                ),
                child: Text(
                  widget.question.variants[widget.index],
                  style: DefaultTextStyle.of(context)
                      .style
                      .copyWith(fontWeight: FontWeight.w500, fontSize: 16),
                ),
              ));
        });
  }

  Color? _caseColor() {
    if (init) return Theme.of(context).buttonTheme.colorScheme?.background;
    return success ? Colors.green : Colors.red;
  }
}
