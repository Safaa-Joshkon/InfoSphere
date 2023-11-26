import 'package:flutter/material.dart';
import 'question.dart';
import 'quiz.dart';

void main() {
  runApp(const Q2());
}

class Q2 extends StatefulWidget {
  const Q2({Key? key}) : super(key: key);

  @override
  State<Q2> createState() => _Q2State();
}

class _Q2State extends State<Q2> {
  int currentQuestionIndex = 0;
  int score = 0;
  bool answerSelected = false;

  List<Question> quizQuestions = [
    //q1
    Question(
      questionText: 'What is the tallest mountain in the world?',
      options: ['Mount Everest', 'Himalayas', 'Kangchenjunga', 'Mount Logan'],
      correctAnswer: 'Mount Everest',
    ),
    //q2
    Question(
      questionText: 'What is the capital of Spain?',
      options: ['Berlin', 'Madrid', 'Paris', 'Rome'],
      correctAnswer: 'Madrid',
    ),
    //q3
    Question(
      questionText: 'What is the capital of Lebanon?',
      options: ['Beirut', 'Amman', 'Ankara', 'Rome'],
      correctAnswer: 'Beirut',
    ),
    //q4
    Question(
      questionText: 'Which country has the largest population in the world?',
      options: ['Russia', 'China', 'USA', 'Mexico'],
      correctAnswer: 'China',
    ),
    //q5
    Question(
      questionText: 'In which continent is Mauritania located?',
      options: ['Africa', 'Asia', 'Europe', 'North America'],
      correctAnswer: 'Africa',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Geography Quiz'),
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
                widthFactor: MediaQuery.of(context).size.width < 600 ? 0.8 : 0.5,
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
