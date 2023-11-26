import 'package:flutter/material.dart';
import 'question.dart';
import 'quiz.dart';

void main() {
  runApp(const Q4());
}

class Q4 extends StatefulWidget {
  const Q4({Key? key}) : super(key: key);

  @override
  State<Q4> createState() => _Q4State();
}

class _Q4State extends State<Q4> {
  int currentQuestionIndex = 0;
  int score = 0;
  static int count = 0;
  bool answerSelected = false;

  String image = 'assets/p1.png';
  List<String> images = [
    'assets/p1.png',
    'assets/p2.png',
    'assets/p3.png',
    'assets/p4.jpg',
    'assets/p5.png',
  ];

  List<Question> quizQuestions = [
    Question(
      questionText: 'Where is this tourist landmark located?',
      options: ['France', 'Spain', 'Italy', 'Germany'],
      correctAnswer: 'France',
    ),
    Question(
      questionText: 'Where is this tourist landmark located?',
      options: ['Spain', 'Italy', 'Mexico', 'Thailand'],
      correctAnswer: 'Italy',
    ),
    Question(
      questionText: 'Where is this tourist landmark located?',
      options: ['Turkiye', 'USA', 'Egypt', 'Tunisia'],
      correctAnswer: 'Turkiye',
    ),
    Question(
      questionText: 'Where is this tourist landmark located?',
      options: ['Pakistan', 'India', 'UAE', 'Kuwait'],
      correctAnswer: 'India',
    ),
    Question(
      questionText: 'Where is this tourist landmark located?',
      options: ['Spain', 'Italy', 'India', 'Thailand'],
      correctAnswer: 'Spain',
    ),
  ];

  @override
  Widget build(BuildContext context) {

    double imageHeight = MediaQuery.of(context).size.width < 600 ? 155.0 : 280.0;
    double questionSpacing = MediaQuery.of(context).size.width < 600 ? 15.0 : 20.0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Guess the Location'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            const SizedBox(height: 15),
            Image.asset(image, width: 250.0, height: imageHeight),
            const SizedBox(height: 15),
            Center(
              child: Text(
                'Question ${currentQuestionIndex + 1}: ${quizQuestions[currentQuestionIndex].questionText}',
                style: const TextStyle(fontSize: 25),
              ),
            ),
            SizedBox(height: questionSpacing),
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
            SizedBox(height: questionSpacing),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () => checkAnswerAndProceed(),
                child: const Text('Next Question'),
              ),
            ),
            SizedBox(height: questionSpacing),
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
    if (currentQuestionIndex < quizQuestions.length-1 && answerSelected) {
      setState(() {
        currentQuestionIndex++;
        count = (count+1) % images.length;
        image = images[count];
        answerSelected = false;
      });
    } else if (answerSelected) {
      displayFinalScore();
    } else {
      //hon like an alert la yen2ebir yna2e an answer
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
      count = 0;
      image = images[count];
    });
  }
}
