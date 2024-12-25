import 'package:e_learning_app/G_DOPI/screen/Science/course_detail.dart';
import 'package:flutter/material.dart';
import '../../model/03_subject_model.dart';
import '../../model/04_course_model.dart';
class SubjectDetailsScreen extends StatelessWidget {
  final SubjectModel subject;

  const SubjectDetailsScreen({Key? key, required this.subject}) : super(key: key);

  Course getCourseBySubjectTitle(String title) {
    return courses.firstWhere((course) => course.title == title, orElse: () => courses[0]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(subject.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Column(
                  children: [
                    const SizedBox(height: 40),
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(subject.imagePath),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Center(
                        child: IconButton(
                          icon: const Icon(Icons.play_circle_fill, size: 60, color: Colors.white),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CourseDetailPage(course: getCourseBySubjectTitle(subject.title)),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Container(
                      height: 40,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: Color(0x99000000),
                      ),
                      child: const Text(
                        'Preview this course',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Subject Title
            Text(
              subject.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            // Subject Description
            Text(
              subject.description,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),

            // Students
            Row(
              children: [
                const Icon(Icons.star, color: Colors.orange, size: 16),
                const SizedBox(width: 4),
                Text('(${subject.students} students)'),
              ],
            ),
            const SizedBox(height: 20),

            // Creator and Updates
            Text('Created by ${subject.instructor}', style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.access_time, size: 14, color: Colors.grey),
                const SizedBox(width: 4),
                Text('Last updated ${subject.lastUpdated}', style: TextStyle(fontSize: 14, color: Colors.grey[700])),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.language, size: 14, color: Colors.grey),
                const SizedBox(width: 4),
                Text('Language: ${subject.language}', style: TextStyle(fontSize: 14, color: Colors.grey[700])),
              ],
            ),
            const SizedBox(height: 16),

            // Price and Buttons
            Container(
              padding: const EdgeInsets.all(16.0),
              color: Colors.grey[200],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Price: ${subject.price}',
                    style: const TextStyle(fontSize: 16, color: Colors.green, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CourseDetailPage(course: getCourseBySubjectTitle(subject.title)),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal,
                          ),
                          child: const Text(
                            'Watch Video',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // What You Will Learn
            const Text(
              'What you will learn from this course',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: subject.learningPoints.map((point) {
                return ListTile(
                  leading: const Icon(Icons.check, color: Colors.green),
                  title: Text(point),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

final List<SubjectModel> subjects = [
  SubjectModel(
    title: 'Mathematics',
    description: 'Learn the fundamentals of Mathematics.',
    instructor: 'T. Hiek Dyna',
    lastUpdated: '2024',
    language: 'Khmer',
    students: '120',
    price: '\$19.99',
    imagePath: 'assets/images/mathematics.jpg',
    learningPoints: [
      'Understand the basics of algebra and geometry.',
      'Learn problem-solving techniques.',
      'Develop critical thinking skills through math exercises.',
    ],
  ),
  SubjectModel(
    title: 'Physics',
    description: 'Understand the basics of Physics with practical exercises.',
    instructor: 'T. Khov Somawatey',
    lastUpdated: '2024',
    language: 'Khmer',
    students: '150',
    price: '\$21.99',
    imagePath: 'assets/images/physics.jpg',
    learningPoints: [
      'Explore the laws of motion and gravity.',
      'Learn the fundamentals of thermodynamics.',
      'Understand concepts of energy and work.',
    ],
  ),
  SubjectModel(
    title: 'Chemistry',
    description: 'Master the fundamentals of Chemistry.',
    instructor: 'T. Korn Visal',
    lastUpdated: '2024',
    language: 'English',
    students: '100',
    price: '\$18.99',
    imagePath: 'assets/images/chemistry.png',
    learningPoints: [
      'Understand chemical reactions and equations.',
      'Learn the periodic table and its elements.',
      'Study acids, bases, and their applications.',
    ],
  ),
  SubjectModel(
    title: 'Literature',
    description: 'Learn the fundamentals of Literature.',
    instructor: 'T. Hiek Dyna',
    lastUpdated: '2024',
    language: 'Khmer',
    students: '120',
    price: '\$19.99',
    imagePath: 'assets/images/literature.jpg',
    learningPoints: [
      'Analyze poems, novels, and plays.',
      'Understand literary devices and their usage.',
      'Develop critical reading and writing skills.',
    ],
  ),
  SubjectModel(
    title: 'Biology',
    description: 'Discover the concepts of life and biological sciences.',
    instructor: 'T. Kak Kannika',
    lastUpdated: '2024',
    language: 'Khmer',
    students: '140',
    price: '\$22.49',
    imagePath: 'assets/images/Biology.jpg',
    learningPoints: [
      'Learn the structure and function of cells.',
      'Understand genetics and inheritance.',
      'Explore ecosystems and biodiversity.',
    ],
  ),
  SubjectModel(
    title: 'History',
    description: 'Explore the world’s history with in-depth analysis.',
    instructor: 'T. Ban Sovanda',
    lastUpdated: '2024',
    language: 'Khmer',
    students: '110',
    price: '\$20.00',
    imagePath: 'assets/images/History.jpg',
    learningPoints: [
      'Study major historical events and timelines.',
      'Understand the impact of historical figures.',
      'Learn how history shapes the modern world.',
    ],
  ),
  SubjectModel(
    title: 'English',
    description: 'Master the English language with practical lessons.',
    instructor: 'T. Kim Sovanarong',
    lastUpdated: '2024',
    language: 'Khmer',
    students: '200',
    price: '\$19.49',
    imagePath: 'assets/images/English.jpg',
    learningPoints: [
      'Improve grammar and vocabulary.',
      'Develop writing and speaking skills.',
      'Learn effective communication techniques.',
    ],
  ),
];