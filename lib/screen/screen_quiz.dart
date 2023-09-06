import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/model_quiz.dart';
import 'package:flutter_application_1/screen/screen_result.dart';
import 'package:flutter_application_1/widget/widget_candidate.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';


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
    double height = screenSize.height * 1.3;    // 내가 임의로 수정함(화면에 다 안들어가서 에라떠서)
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
            child: Swiper(
              physics: NeverScrollableScrollPhysics(),
              loop: false,
              itemCount: widget.quizzes.length,
              itemBuilder: (BuildContext context, int index) {
                return _buildQuizCard(widget.quizzes[index], width, height);
              },
            ),
          ),
        ),
      ),
    );
  }
  Widget _buildQuizCard(Quiz quiz, double width, double height) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white),
        color: Colors.white
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(0, width * 0.024, 0, width * 0.024),
            child: Text(
              'Q' + (_currentIndex + 1).toString() + '.',
              style: TextStyle(
                fontSize: width * 0.06,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            width: width * 0.8,
            padding: EdgeInsets.only(top: width * 0.012),
            child: AutoSizeText(
              quiz.title,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: TextStyle(
                fontSize: width * 0.048,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Container(),
          ),
          Column(
            children: _buildCandidates(width, quiz),
          ),
          Container(
            padding: EdgeInsets.all(width * 0.024),
            child: Center(
              child: ButtonTheme(
                minWidth: width * 0.5,
                height: height * 0.05,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ElevatedButton(
                  child: _currentIndex == widget.quizzes.length - 1
                      ? const Text('결과보기')
                      : Text('다음문제'),
                      
                  // textColor: Colors.white,
                  // color: Colors.deepPurple,
                  onPressed: _answers[_currentIndex] == -1
                      ? null
                      : () {
                          if (_currentIndex == widget.quizzes.length - 1) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ResultScreen(
                                answers: _answers,
                                quizs: widget.quizzes
                                )
                              )
                            );
                          } else {
                            _answerState = [false, false, false, false];
                            _currentIndex += 1;
                          }
                        },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
  List<Widget> _buildCandidates(double width, Quiz quiz) {
    List<Widget> _children = [];
    for (int i = 0; i < 4; i++) {
      _children.add(
        CandWidget(
          index: i,
          text: quiz.candidates[i],
          width: width,
          answerState: _answerState[i],
          tap: () {
            setState(() {
              for (int j = 0; j < 4; j++) {
                if (j == i) {
                  _answerState[j] = true;
                  _answers[_currentIndex] = j;
                  // print(_answers[_currentIndex]);
                }
                else {
                  _answerState[j] = false;
                }
              }
            });
          },
        ),
      );
      _children.add(
        Padding(
          padding: EdgeInsets.all(width * 0.024),
        ),
      );
    }
    return _children;
  }
}