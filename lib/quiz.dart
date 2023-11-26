import 'package:flutter/material.dart';
import 'q1.dart';
import 'q2.dart';
import 'q3.dart';
import 'q4.dart';

void main() {
  runApp(const Quiz());
}

class Quiz extends StatefulWidget {
  const Quiz({Key? key}) : super(key: key);

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  String? selectedTopic;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('InfoSphere'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/home1.png'),
              const SizedBox(height: 15),
              const Text(
                'Choose a topic:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              screenWidth < 600
                  ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildRadioButton('General Knowledge'),
                  const SizedBox(height: 8),
                  buildRadioButton('Geography'),
                  const SizedBox(height: 8),
                  buildRadioButton('Science'),
                  const SizedBox(height: 8),
                  buildRadioButton('Guess the Location'),
                ],
              )
                  : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildRadioButton('General Knowledge'),
                  const SizedBox(width: 16),
                  buildRadioButton('Geography'),
                  const SizedBox(width: 16),
                  buildRadioButton('Science'),
                  const SizedBox(width: 16),
                  buildRadioButton('Guess the Location'),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (selectedTopic != null) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          switch (selectedTopic) {
                            case 'General Knowledge':
                              return const Q1();
                            case 'Geography':
                              return const Q2();
                            case 'Science':
                              return const Q3();
                            case 'Guess the Location':
                              return const Q4();
                            default:
                              return const Q1();
                          }
                        },
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Please select a topic to start the quiz.',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  }
                },
                child: const Text(
                  'Start Quiz',
                  style: TextStyle(fontSize: 22),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildRadioButton(String topic) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio<String>(
          value: topic,
          groupValue: selectedTopic,
          onChanged: (String? value) {
            setState(() {
              selectedTopic = value;
            });
          },
        ),
        const SizedBox(width: 8),
        Text(topic),
      ],
    );
  }
}
