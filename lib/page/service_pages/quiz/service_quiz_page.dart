import 'dart:async';

import 'package:flutter/cupertino.dart';
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
  bool loading = false;
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
        PageView(
          onPageChanged: (value) {
            if (value == quiz.length - 1) {
              if (!mounted) return;
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => Scaffold(
                      body: Center(
                        child: OutlinedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                                'Вы ответили правильно на $count вопроса из ${quiz.length}')),
                      ),
                    ),
                  )).then((value) {
                if (!mounted) return;
                setState(() {
                  loading = true;
                  quiz.shuffle();
                  controller.animateToPage(0,
                      duration: const Duration(milliseconds: 150),
                      curve: Curves.linear);
                });
                Future.delayed(
                  const Duration(seconds: 1),
                  () {
                    if (!mounted) return;
                    setState(() {
                      count = 0;
                      loading = false;
                    });
                  },
                );
              });
            }
          },
          physics: const NeverScrollableScrollPhysics(),
          controller: controller,
          children: List.generate(
              quiz.length,
              (index) => QuizElement(
                    onSucccess: (index) {
                      count++;
                    },
                    question: quiz[index],
                    onNextPage: () {
                      Timer(
                        const Duration(seconds: 2),
                        () {
                          controller.nextPage(
                              duration: const Duration(milliseconds: 150),
                              curve: Curves.linear);
                        },
                      );
                    },
                  )),
        ),
        if (loading)
          const Positioned.fill(
              child: ColoredBox(
            color: Colors.white,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ))
      ],
    ));
  }
}
