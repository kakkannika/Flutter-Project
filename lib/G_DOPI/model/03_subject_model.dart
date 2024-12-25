class SubjectModel {
  final String title;
  final String description;
  final String instructor;
  final String lastUpdated;
  final String language;
  final String students;
  final String price;
  final String imagePath;
  final List<String> learningPoints; 

  SubjectModel({
    required this.title,
    required this.description,
    required this.instructor,
    required this.lastUpdated,
    required this.language,
    required this.students,
    required this.price,
    required this.imagePath,
    required this.learningPoints,
  });
}
