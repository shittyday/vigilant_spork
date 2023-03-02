class Question {
  final String value;
  final List<String> variants;
  final List<bool> variantAnswers;
  const Question({
    required this.value,
    required this.variantAnswers,
    required this.variants,
  });
}

final question = [
  const Question(
    value:
        'Which player scored the fastest goal in World Cup history for any team?',
    variantAnswers: [false, false, false, true],
    variants: ['Spain', 'German', 'Italy', 'Turkey'],
  ),
  const Question(
    value:
        'Which goalkeeper made a fatal mistake in the Russia-Ukraine match during the qualifying tournament for the 2000 European Championship?',
    variantAnswers: [false, false, true, false],
    variants: ['Ovchinnikov', 'Cherchesov', 'Filimonov', 'Akinfeev'],
  ),
  const Question(
    value: 'For which club did Fabio Cannavaro win the "Golden Ball" award?',
    variantAnswers: [false, true, false, false],
    variants: ['Juventus', 'Real Madrid', 'Inter', 'Milan'],
  ),
  const Question(
    value: 'Who won the first FIFA World Cup?',
    variantAnswers: [true, false, false, false],
    variants: ['Uruguay', 'Brazil', 'England', 'Argentina'],
  ),
  const Question(
    value: 'What is the weight of the lightest football boots?',
    variantAnswers: [false, true, false, false],
    variants: ['80 grams', '99 grams', '127 grams', '153 grams'],
  ),
  const Question(
    value: 'Who is the most decorated football player in the world?',
    variantAnswers: [false, false, false, true],
    variants: ['Lionel Messi', 'Cristiano Ronaldo', 'Pele', 'Dani Alves'],
  ),
  const Question(
    value:
        'Guess the football player by his career? (Corinthians, Shakhtar, Anzhi, Chelsea)',
    variantAnswers: [true, false, false, false],
    variants: ['Willian', 'Fernandinho', 'Douglas Costa', 'David Luiz'],
  ),
  const Question(
    value:
        'How many minutes did Robert Lewandowski take to score the fastest hat-trick?',
    variantAnswers: [false, false, true, false],
    variants: ['7 minutes', '8 minutes', '9 minutes', '12 minutes'],
  ),
];
