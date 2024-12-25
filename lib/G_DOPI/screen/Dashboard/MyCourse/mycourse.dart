import 'package:flutter/material.dart';
import '../../../model/Course_model.dart';

class MyCourse extends StatefulWidget {
  final List<String> savedVideos;

  const MyCourse({Key? key, required this.savedVideos}) : super(key: key);

  @override
  _MyCourseState createState() => _MyCourseState();
}

class _MyCourseState extends State<MyCourse> {
  int _selectedTab = 0;

  final List<CourseModel> allCourses = [
    CourseModel(
      title: 'Mathematics',
      description: 'Have a lot of exercises.',
      rating: 4.7,
      students: 234,
      images: 'assets/images/mathematics.jpg',
    ),
    CourseModel(
      title: 'Biology',
      description: 'Have a lot of exercises.',
      rating: 4.7,
      students: 234,
      images: 'assets/images/Biology.jpg',
    ),
    CourseModel(
      title: 'Literature',
      description: 'Have a lot of exercises.',
      rating: 4.7,
      students: 234,
      images: 'assets/images/literature.jpg',
    ),
  ];

  final List<CourseModel> inProgressCourses = [
    CourseModel(
      title: 'Physics',
      description: 'Learn the basics of Physics.',
      rating: 4.8,
      students: 185,
      images: 'assets/images/physics.jpg',
    ),
    CourseModel(
      title: 'Chemistry',
      description: 'Understand chemical reactions.',
      rating: 4.6,
      students: 290,
      images: 'assets/images/chemistry.png',
    ),
  ];

  final List<CourseModel> completedCourses = [
    CourseModel(
      title: 'English',
      description: 'Analyze classic novels and poetry.',
      rating: 4.9,
      students: 340,
      images: 'assets/images/English.jpg',
    ),
    CourseModel(
      title: 'History',
      description: 'Introduction to algorithms and coding.',
      rating: 4.8,
      students: 410,
      images: 'assets/images/History.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    List<CourseModel> displayedCourses;
    if (_selectedTab == 0) {
      displayedCourses = allCourses.where((course) => widget.savedVideos.contains(course.title)).toList();
    } else if (_selectedTab == 1) {
      displayedCourses = inProgressCourses;
    } else {
      displayedCourses = completedCourses;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Courses'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () {
                  setState(() {
                    _selectedTab = 0;
                  });
                },
                child: Text(
                  'Saved Courses',
                  style: TextStyle(
                    color: _selectedTab == 0 ? Colors.teal : Colors.black,
                    fontWeight: _selectedTab == 0 ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _selectedTab = 1;
                  });
                },
                child: Text(
                  'In Progress',
                  style: TextStyle(
                    color: _selectedTab == 1 ? Colors.teal : Colors.black,
                    fontWeight: _selectedTab == 1 ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _selectedTab = 2;
                  });
                },
                child: Text(
                  'Completed',
                  style: TextStyle(
                    color: _selectedTab == 2 ? Colors.teal : Colors.black,
                    fontWeight: _selectedTab == 2 ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: displayedCourses.length,
              itemBuilder: (context, index) {
                final course = displayedCourses[index];
                return ListTile(
                  leading: Image.asset(course.images),
                  title: Text(course.title),
                  subtitle: Text(course.description),
                  trailing: Text('${course.rating} ★'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}