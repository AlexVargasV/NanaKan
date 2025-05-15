import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';

class TestCalculosPage extends StatefulWidget {
  @override
  _TestCalculosPageState createState() => _TestCalculosPageState();
}

class _TestCalculosPageState extends State<TestCalculosPage> {
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
      return lang.translate("test_result_low");
    } else if (totalPoints <= 10) {
      return lang.translate("test_result_moderate");
    } else if (totalPoints <= 18) {
      return lang.translate("test_result_high");
    } else {
      return lang.translate("test_result_critical");
    }
  }

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageProvider>(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final List<Map<String, dynamic>> questions = [
      {
        "question": lang.translate("test_q1"),
        "answers": [
          {"text": lang.translate("test_q1_a1"), "points": 0},
          {"text": lang.translate("test_q1_a2"), "points": 1},
          {"text": lang.translate("test_q1_a3"), "points": 3},
        ]
      },
      {
        "question": lang.translate("test_q2"),
        "answers": [
          {"text": lang.translate("test_q2_a1"), "points": 0},
          {"text": lang.translate("test_q2_a2"), "points": 1},
          {"text": lang.translate("test_q2_a3"), "points": 3},
        ]
      },
      {
        "question": lang.translate("test_q3"),
        "answers": [
          {"text": lang.translate("test_q3_a1"), "points": 0},
          {"text": lang.translate("test_q3_a2"), "points": 1},
          {"text": lang.translate("test_q3_a3"), "points": 3},
        ]
      },
      {
        "question": lang.translate("test_q4"),
        "answers": [
          {"text": lang.translate("test_q4_a1"), "points": 0},
          {"text": lang.translate("test_q4_a2"), "points": 1},
          {"text": lang.translate("test_q4_a3"), "points": 3},
        ]
      },
      {
        "question": lang.translate("test_q5"),
        "answers": [
          {"text": lang.translate("test_q5_a1"), "points": 0},
          {"text": lang.translate("test_q5_a2"), "points": 2},
          {"text": lang.translate("test_q5_a3"), "points": 4},
        ]
      },
      {
        "question": lang.translate("test_q6"),
        "answers": [
          {"text": lang.translate("test_q6_a1"), "points": 0},
          {"text": lang.translate("test_q6_a2"), "points": 3},
          {"text": lang.translate("test_q6_a3"), "points": 5},
        ]
      },
      {
        "question": lang.translate("test_q7"),
        "answers": [
          {"text": lang.translate("test_q7_a1"), "points": 0},
          {"text": lang.translate("test_q7_a2"), "points": 2},
          {"text": lang.translate("test_q7_a3"), "points": 4},
        ]
      },
      {
        "question": lang.translate("test_q8"),
        "answers": [
          {"text": lang.translate("test_q8_a1"), "points": 0},
          {"text": lang.translate("test_q8_a2"), "points": 2},
          {"text": lang.translate("test_q8_a3"), "points": 4},
        ]
      },
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isDark
                  ? [Colors.grey.shade900, Colors.grey.shade800]
                  : [Colors.blue.shade300, Colors.purple.shade300],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        shape: BoxShape.circle,
                      ),
                      child:
                          Icon(Icons.arrow_back, color: Colors.white, size: 28),
                    ),
                  ),
                  Text(
                    lang.translate("renal_test"),
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 6,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 40),
                ],
              ),
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
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                  SizedBox(height: 12),
                  Card(
                    color: isDark ? Colors.grey[850] : Colors.white,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        questions[currentQuestion]["question"],
                        style: TextStyle(
                          fontSize: 17,
                          height: 1.4,
                          color: isDark ? Colors.grey[200] : Colors.black87,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ...questions[currentQuestion]["answers"]
                      .map<Widget>((answer) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isDark
                              ? Colors.deepPurple.shade400
                              : Colors.blueAccent,
                          minimumSize: Size(double.infinity, 48),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          answer["text"],
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        onPressed: () => answerQuestion(answer["points"]),
                      ),
                    );
                  }).toList(),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.pets,
                      color: isDark ? Colors.purple.shade300 : Colors.teal,
                      size: 60),
                  SizedBox(height: 20),
                  Text(
                    lang.translate("result"),
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                  SizedBox(height: 10),
                  Card(
                    color: isDark ? Colors.grey[850] : Colors.white,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        getResultMessage(lang),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: isDark ? Colors.grey[200] : Colors.black87,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  ElevatedButton.icon(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    label: Text(
                      lang.translate("back"),
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isDark
                          ? Colors.purple.shade400
                          : Colors.teal.shade600,
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
    );
  }
}
