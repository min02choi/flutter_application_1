import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/model_quiz.dart';


class QuizScreen extends StatefulWidget {
  List<Quiz> quizzes;
  // 생성자. 아니 넘겨받는게 안되는데
  QuizScreen({required this.quizzes});
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<int> _answers = [-1, -1, -1];    // 사용자의 정답을 담아 놓을 _answers 리스트
  List<bool> _answerState = [false, false, false, false];   // 퀴즈 하나에 대해 각 선택지가 선택되었는지를 bool 형태로 기록하는 리스트
  int _currentIndex = 0;    // 현재 어떤 문제를 보고 있는지

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.deepPurple,
        body: Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.deepPurple),
            ),
            width: width * 0.85,
            height: height * 0.5,
            // child: Swiper(phy),
          ),
        ),
      ),
    );
  }
}