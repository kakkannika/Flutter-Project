import 'package:flutter/material.dart';
import 'grade_calculate.dart'; 

class ResultScreen extends StatelessWidget {
  final String selectedTab;
  final Map<String, Map<String, dynamic>> results;

  const ResultScreen({
    Key? key,
    required this.selectedTab,
    required this.results,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String overallGrade = _calculateOverallGrade(); 
    final String resultMessage = _generateResultMessage(overallGrade); 

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('$selectedTab Results'),
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
              const SizedBox(height: 20),
              Text(
                '$selectedTab Subjects',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Column(
                children: results.entries.map((entry) {
                  final subject = entry.key;
                  final result = entry.value;

                  final int inputScore = subject == "English"
                      ? _adjustEnglishScore(result['inputScore'])
                      : result['inputScore'];

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            '$subject (${result['totalScore']})',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            'Score: $inputScore',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            'Grade: ${result['grade']}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: result['result'] == 'Pass' ? Colors.green : Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 20),

              // Show Overall Result
              Center(
                child: Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 20),
                    child: Column(
                      children: [
                        Text(
                          'Total Score: ${_calculateTotalScore()}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Result: ${overallGrade != "F" ? "Pass" : "Fail"}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: overallGrade != "F" ? Colors.green : Colors.red,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Overall Grade: $overallGrade',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          resultMessage, 
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: overallGrade == "F"
                                ? Colors.red
                                : const Color.fromARGB(255, 228, 136, 136),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Calculate Again Button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); 
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GradeCalculate(), 
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlue,
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Calculate Again',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  int _adjustEnglishScore(int inputScore) {
    if (inputScore <= 25) return 0;
    return inputScore - 25;
  }

  /// Calculate total score
  int _calculateTotalScore() {
    int total = 0;
    results.forEach((subject, value) {
      int inputScore = value['inputScore'];
      if (subject == "English") {
        inputScore = _adjustEnglishScore(inputScore);
      }
      total += inputScore;
    });
    return total;
  }

  String _calculateOverallGrade() {
    final int totalScore = _calculateTotalScore();
    if (totalScore >= 427) return "A";
    if (totalScore >= 375) return "B";
    if (totalScore >= 325) return "C";
    if (totalScore >= 275) return "D";
    if (totalScore >= 200) return "E";
    return "F";
  }

  String _generateResultMessage(String grade) {
    if (grade == "A") {
      return "Congratulations!";
    } else if (grade == "F") {
      return "Try more, Don't be sad!";
    } else {
      return "Good job! Keep improving!";
    }
  }
}