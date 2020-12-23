import 'package:covidensa/pages/question_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QuizPage  extends StatefulWidget {
  @override
_QuizPageState createState() => _QuizPageState();
}
class _QuizPageState extends State<QuizPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Color(0xFF512DA8),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 50, horizontal: 10),
            child: QuestionsPage(),
          ),
        ),

    );
  }
}

