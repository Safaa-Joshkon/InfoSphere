import 'package:flutter/material.dart';
import 'question.dart';
import 'quiz.dart';

void main() {
  runApp(const Q3());
}

class Q3 extends StatefulWidget {
  const Q3({Key? key}) : super(key: key);

  @override
  State<Q3> createState() => _Q3State();
}

class _Q3State extends State<Q3> {
  int currentQuestionIndex = 0;
  int score = 0;
  bool answerSelected = false;

  List<Question> quizQuestions = [
    //q1
    Question(
      questionText: 'What is the chemical symbol for gold?',
      options: ['Au', 'Ag', 'Fe', 'Cu'],
      correctAnswer: 'Au',
    ),
    //q2
    Question(
      questionText: 'Which planet is known as the "Red Planet"?',
      options: ['Mars', 'Venus', 'Jupiter', 'Saturn'],
      correctAnswer: 'Mars',
    ),
    //q3
    Question(
      questionText: 'What is the chemical formula for water?',
      options: ['CO2', 'O2', 'H2O', 'CH4'],
      correctAnswer: 'H2O',
    ),
    //q4
    Question(
      questionText: ' What is the SI unit of force?',
      options: ['Watt', 'Joule', 'Newton', 'Pascal'],
      correctAnswer: 'Newton',
    ),
    //q5
    Question(
      questionText: ' Which organ in the human body produces insulin?',
      options: ['Liver', 'Kidney', 'Stomach', 'Pancreas'],
      correctAnswer: 'Pancreas',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Science Quiz'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            const SizedBox(height: 20),
            Center(
              child: Text(
                'Question ${currentQuestionIndex + 1}:',
                style: const TextStyle(fontSize: 25),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Text(
                quizQuestions[currentQuestionIndex].questionText,
                style: const TextStyle(fontSize: 25),
                textAlign: TextAlign.center, // Center the text
              ),
            ),
            const SizedBox(height: 20),
            ...quizQuestions[currentQuestionIndex].options.expand((option) => [
              FractionallySizedBox(
                widthFactor: 0.8,
                child: ElevatedButton(
                  onPressed: () => selectAnswer(option),
                  child: Text(
                    option,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ]).toList(),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () => checkAnswerAndProceed(),
                child: const Text('Next Question'),
              ),
            ),
            const SizedBox(height: 20),
            const Center(
              child: Text(
                'Score: ',
                style: TextStyle(fontSize: 20),
              ),
            ),
            Center(
              child: Text(
                '$score',
                style: TextStyle(
                  fontSize: 20,
                  color: score >= 3 ? Colors.green : Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void selectAnswer(String selectedAnswer) {
    if (selectedAnswer == quizQuestions[currentQuestionIndex].correctAnswer) {
      setState(() {
        score++;
      });
    }
    setState(() {
      answerSelected = true;
    });
  }

  void checkAnswerAndProceed() {
    // Check if there are more questions
    if (currentQuestionIndex < quizQuestions.length - 1 && answerSelected) {
      setState(() {
        currentQuestionIndex++;
        answerSelected = false;
      });
    } else if (answerSelected) {
      displayFinalScore();
    } else {
      // ha mtl an alert la yen2ebir yna2e an answer
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please select an answer',
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
  }

  void displayFinalScore() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Quiz Completed'),
          content: Text('Your final score is $score'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                resetQuiz();
              },
              child: const Text('Play Again'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                resetQuiz();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const Quiz()),
                );
              },
              child: const Text('Go to Home'),
            ),
          ],
        );
      },
    );
  }

  void resetQuiz() {
    setState(() {
      currentQuestionIndex = 0;
      score = 0;
    });
  }
}
