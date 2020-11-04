import 'package:flutter/material.dart';
import 'package:quizz_ap/question.dart';
import 'quiz_bank.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

Quiz_Bank quizbank = Quiz_Bank();
int crctanswer = 0;
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.green.shade900,
            title: Text(
              'Quiz App',
              style: TextStyle(color: Colors.white, fontSize: 30.0),
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: QuizApp(),
            ),
          )),
    );
  }
}

class QuizApp extends StatefulWidget {
  @override
  _QuizAppState createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  List<Icon> scorekeeper = [];
  int score = 0;
  void checkanswer(bool pickanswer) {
    bool correctanswer = quizbank.getCorrectanswer();
    if (quizbank.isFinished() == true) {
      Alert(
        context: context,
        title: "Finished",
        desc: "Total Correct Answers are $crctanswer .Your score is $score/60.",
      ).show();
      quizbank.reset();
      scorekeeper = [];
      score = 0;
      crctanswer = 0;
    } else {
      if (pickanswer == correctanswer) {
        score = score + 5;
        crctanswer++;
        scorekeeper.add(
          Icon(
            Icons.check,
            color: Colors.green,
            size: 25.0,
          ),
        );
      } else {
        scorekeeper.add(
          Icon(
            Icons.close,
            color: Colors.red,
            size: 25.0,
          ),
        );
      }
      quizbank.nextQuestion();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 20.0),
        Expanded(
          flex: 3,
          child: Container(
            child: Image.asset('assets/download1.jpg'),
          ),
        ),
        Expanded(
          flex: 3,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizbank.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20.0, color: Colors.black),
              ),
            ),
          ),
        ),
        Expanded(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              Text('Total Questions are 12'),
              Text('Each Question has 5 Marks'),
            ],
          ),
        )),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.green.shade900,
              child: Text(
                'True',
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
              onPressed: () {
                setState(() {
                  checkanswer(true);
                });
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red.shade900,
              child: new Text(
                'False',
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
              onPressed: () {
                setState(() {
                  checkanswer(false);
                });
              },
            ),
          ),
        ),
        Expanded(
            child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Row(
            children: scorekeeper,
          ),
        ))
      ],
    );
  }
}
