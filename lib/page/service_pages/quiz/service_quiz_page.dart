import 'dart:async';

import 'package:flutter/material.dart';
import 'package:vigilant_spork/api/news/model/quiz_data.dart';
import 'package:vigilant_spork/widgets/quiz_element.dart';

class ServiceQuizPage extends StatefulWidget {
  const ServiceQuizPage({super.key});

  @override
  State<ServiceQuizPage> createState() => _ServiceQuizPageState();
}

class _ServiceQuizPageState extends State<ServiceQuizPage> {
  final controller = PageController();
  final quiz = [...question]..shuffle();
  int count = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Stack(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Text('$count'),
          ),
        ),
        PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: controller,
          children: List.generate(
              quiz.length,
              (index) => QuizElement(
                    onSucccess: () {
                      setState(() {
                        count++;
                      });
                    },
                    question: quiz[index],
                    onNextPage: () {
                      Timer(
                        const Duration(seconds: 5),
                        () {
                          controller.animateToPage(
                              (controller.page?.toInt() ?? 0) + 1,
                              duration: const Duration(milliseconds: 150),
                              curve: Curves.elasticOut);
                        },
                      );
                    },
                  )),
        )
      ],
    ));
  }
}
