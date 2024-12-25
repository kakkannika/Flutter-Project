import 'package:flutter/material.dart';
import '../Grade_Calculate/result_calculate.dart';

class GradeCalculate extends StatefulWidget {
  @override
  _GradeCalculateState createState() => _GradeCalculateState();
}

class _GradeCalculateState extends State<GradeCalculate> {
  String selectedTab = "Science";

 
  final Map<String, TextEditingController> scoreControllers = {};

  final Map<String, int> scienceSubjects = {
    'Mathematics': 125,
    'Physics': 75,
    'Biology': 75,
    'English': 50,
    'Khmer': 75,
    'Chemistry': 75,
    'History': 50,
  };

  final Map<String, int> socialScienceSubjects = {
    'Khmer': 125,
    'History': 75,
    'Geography': 75,
    'Morality': 50,
    'Earth Science': 75,
    'Mathematics': 75,
    'English': 50,
  };

  @override
  void initState() {
    super.initState();
    
    for (var subject in scienceSubjects.keys) {
      scoreControllers[subject] = TextEditingController();
    }
    for (var subject in socialScienceSubjects.keys) {
      scoreControllers[subject] = TextEditingController();
    }
  }

  @override
  void dispose() {
    // Dispose controllers to avoid memory leaks
    for (var controller in scoreControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void calculateAndNavigate() {
    final Map<String, Map<String, dynamic>> results = {};

    final subjects = selectedTab == "Science" ? scienceSubjects : socialScienceSubjects;

    subjects.forEach((subject, totalScore) {
      final inputScore = int.tryParse(scoreControllers[subject]?.text ?? "0") ?? 0;
      results[subject] = _calculateGrade(inputScore, totalScore);
    });

    // Navigate to Result Screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(
          selectedTab: selectedTab,
          results: results,
        ),
      ),
    );
  }

  void resetScores() {
    for (var controller in scoreControllers.values) {
      controller.clear();
    }
  }

  Map<String, dynamic> _calculateGrade(int inputScore, int totalScore) {
    String grade;
    String result;

    if (inputScore >= totalScore * 0.9) {
      grade = "A";
      result = "Pass";
    } else if (inputScore >= totalScore * 0.8) {
      grade = "B";
      result = "Pass";
    } else if (inputScore >= totalScore * 0.7) {
      grade = "C";
      result = "Pass";
    } else if (inputScore >= totalScore * 0.6) {
      grade = "D";
      result = "Pass";
    } else if (inputScore >= totalScore * 0.3) {
      grade = "E";
      result = "Fail";
    } else {
      grade = "F";
      result = "Fail";
    }

    return {
      "inputScore": inputScore,
      "totalScore": totalScore,
      "grade": grade,
      "result": result,
    };
  }

  @override
  Widget build(BuildContext context) {
    final subjects =
        selectedTab == "Science" ? scienceSubjects : socialScienceSubjects;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Grade Calculate'),
        backgroundColor: Colors.lightBlue,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Add search functionality if needed
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Banner Section
              Container(
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/Grade_Calculate.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Tabs Section
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedTab = "Science";
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        color: selectedTab == "Science" ? Colors.blue : Colors.grey[200],
                        child: Text(
                          'Science',
                          style: TextStyle(
                            color: selectedTab == "Science" ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedTab = "Social Science";
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        color: selectedTab == "Social Science" ? Colors.blue : Colors.grey[200],
                        child: Text(
                          'Social Science',
                          style: TextStyle(
                            color: selectedTab == "Social Science" ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Input Fields Section
              Column(
                children: subjects.entries.map((entry) {
                  final subject = entry.key;
                  final totalScore = entry.value;

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            '$subject ($totalScore)',
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: TextField(
                            controller: scoreControllers[subject],
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Enter score',
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),

              // Show Results Button
              Center(
                child: ElevatedButton(
                  onPressed: calculateAndNavigate,
                   style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlue,
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Show Results',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}