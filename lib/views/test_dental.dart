import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';

class TestDentalPage extends StatefulWidget {
  @override
  _TestDentalPageState createState() => _TestDentalPageState();
}

class _TestDentalPageState extends State<TestDentalPage> {
  int totalPoints = 0;
  int currentQuestion = 0;

  void answerQuestion(int points) {
    setState(() {
      totalPoints += points;
      currentQuestion++;
    });
  }

  String getResultMessage(LanguageProvider lang) {
    if (totalPoints <= 5) {
      return lang.translate("dtest_result_low");
    } else if (totalPoints <= 10) {
      return lang.translate("dtest_result_moderate");
    } else if (totalPoints <= 18) {
      return lang.translate("dtest_result_high");
    } else {
      return lang.translate("dtest_result_critical");
    }
  }

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageProvider>(context);

    final List<Map<String, dynamic>> questions = [
      {
        "question": lang.translate("dtest_q1"),
        "answers": [
          {"text": lang.translate("dtest_q1_a1"), "points": 0},
          {"text": lang.translate("dtest_q1_a2"), "points": 1},
          {"text": lang.translate("dtest_q1_a3"), "points": 3},
        ]
      },
      {
        "question": lang.translate("dtest_q2"),
        "answers": [
          {"text": lang.translate("dtest_q2_a1"), "points": 0},
          {"text": lang.translate("dtest_q2_a2"), "points": 1},
          {"text": lang.translate("dtest_q2_a3"), "points": 2},
        ]
      },
      {
        "question": lang.translate("dtest_q3"),
        "answers": [
          {"text": lang.translate("dtest_q3_a1"), "points": 0},
          {"text": lang.translate("dtest_q3_a2"), "points": 1},
          {"text": lang.translate("dtest_q3_a3"), "points": 3},
        ]
      },
      {
        "question": lang.translate("dtest_q4"),
        "answers": [
          {"text": lang.translate("dtest_q4_a1"), "points": 0},
          {"text": lang.translate("dtest_q4_a2"), "points": 2},
          {"text": lang.translate("dtest_q4_a3"), "points": 4},
        ]
      },
      {
        "question": lang.translate("dtest_q5"),
        "answers": [
          {"text": lang.translate("dtest_q5_a1"), "points": 0},
          {"text": lang.translate("dtest_q5_a2"), "points": 2},
          {"text": lang.translate("dtest_q5_a3"), "points": 4},
        ]
      },
      {
        "question": lang.translate("dtest_q6"),
        "answers": [
          {"text": lang.translate("dtest_q6_a1"), "points": 0},
          {"text": lang.translate("dtest_q6_a2"), "points": 2},
          {"text": lang.translate("dtest_q6_a3"), "points": 4},
        ]
      },
      {
        "question": lang.translate("dtest_q7"),
        "answers": [
          {"text": lang.translate("dtest_q7_a1"), "points": 0},
          {"text": lang.translate("dtest_q7_a2"), "points": 2},
          {"text": lang.translate("dtest_q7_a3"), "points": 4},
        ]
      },
      {
        "question": lang.translate("dtest_q8"),
        "answers": [
          {"text": lang.translate("dtest_q8_a1"), "points": 0},
          {"text": lang.translate("dtest_q8_a2"), "points": 3},
          {"text": lang.translate("dtest_q8_a3"), "points": 5},
        ]
      },
      {
        "question": lang.translate("dtest_q9"),
        "answers": [
          {"text": lang.translate("dtest_q9_a1"), "points": 0},
          {"text": lang.translate("dtest_q9_a2"), "points": 3},
          {"text": lang.translate("dtest_q9_a3"), "points": 5},
        ]
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(lang.translate("dental_test")),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade300, Colors.purple.shade300],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: currentQuestion < questions.length
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${lang.translate("question")} ${currentQuestion + 1}/${questions.length}",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    questions[currentQuestion]["question"],
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 20),
                  ...questions[currentQuestion]["answers"]
                      .map<Widget>((answer) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          minimumSize: Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(answer["text"],
                            style:
                                TextStyle(fontSize: 16, color: Colors.white)),
                        onPressed: () => answerQuestion(answer["points"]),
                      ),
                    );
                  }).toList(),
                ],
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.health_and_safety, color: Colors.teal, size: 60),
                    SizedBox(height: 20),
                    Text(
                      lang.translate("result"),
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      getResultMessage(lang),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 30),
                    ElevatedButton.icon(
                      icon: Icon(Icons.arrow_back),
                      label: Text(lang.translate("back")),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
