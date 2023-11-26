import 'package:flutter/material.dart';
import 'question.dart';
import 'quiz.dart';

void main() {
  runApp(const Q1());
}

class Q1 extends StatefulWidget {
  const Q1({Key? key}) : super(key: key);

  @override
  State<Q1> createState() => _Q1State();
}

class _Q1State extends State<Q1> {
  int currentQuestionIndex = 0;
  int score = 0;
  bool answerSelected = false;

  List<Question> quizQuestions = [
    Question(
      questionText: 'Who was the first president of Lebanon?',
      options: ['Bechara El Khoury', 'Elias Hrawi', 'Riad Al Solh', 'Fouad Chehab'],
      correctAnswer: 'Bechara El Khoury',
    ),
    Question(
      questionText: 'Who is the father of physics?',
      options: ['Albert Einstein', 'Nikola Tesla', 'Isaac Newton', 'Leonardo da Vinci'],
      correctAnswer: 'Isaac Newton',
    ),
    Question(
      questionText: 'Who was the first person on the moon?',
      options: ['Michael Collins', 'Neil Armstrong', 'Valentina Tereshkova ', 'Yuri Gagarin'],
      correctAnswer: 'Neil Armstrong',
    ),
    Question(
      questionText: 'Who invented electricity?',
      options: ['Benjamin Franklin', 'Thomas Jefferson', 'William Greener', 'Charles Brush'],
      correctAnswer: 'Benjamin Franklin',
    ),
    Question(
      questionText: 'Who wrote "A Brief History of Time"?',
      options: ['Lawrence Krauss', 'Kip S. Throne', 'Stephen Hawking', 'Brain Greene'],
      correctAnswer: 'Stephen Hawking',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('General Knowledge Quiz'),
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
                textAlign: TextAlign.center,
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
    if (currentQuestionIndex < quizQuestions.length - 1 && answerSelected) {
      setState(() {
        currentQuestionIndex++;
        answerSelected = false;
      });
    } else if (answerSelected) {
      displayFinalScore();
    } else {
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
