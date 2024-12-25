import 'package:flutter/material.dart';

class SocialScienceTipsPage extends StatelessWidget {
  final List<Map<String, String>> lessons = [
    {
      'title': 'Lesson 1: Complex Numbers',
      'description': 'Learn about complex numbers.',
      'filePath': 'assets/Files/Complex.pdf',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Science Tips'),
        backgroundColor: Colors.lightBlue,
      ),
      body: ListView.builder(
        itemCount: lessons.length,
        itemBuilder: (context, index) {
          final lesson = lessons[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ExpansionTile(
              title: Text(
                lesson['title']!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              children: [
                ListTile(
                  title: Text(lesson['description']!),
                  trailing: const Icon(Icons.picture_as_pdf),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LessonDetailScreen(
                          title: lesson['title']!,
                          description: lesson['description']!,
                          filePath: lesson['filePath']!,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class LessonDetailScreen extends StatelessWidget {
  final String title;
  final String description;
  final String filePath;

  const LessonDetailScreen({
    Key? key,
    required this.title,
    required this.description,
    required this.filePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.lightBlue,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              description,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          
        ],
      ),
    );
  }
}