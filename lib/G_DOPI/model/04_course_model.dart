class Course {
  final String title;
  final String description;
  final String videoPreview;
  final double price;
  final List<Section> sections;

  Course({
    required this.title,
    required this.description,
    required this.videoPreview,
    required this.price,
    required this.sections,
  });
}

class Section {
  final String title;
  final List<Video> videos;

  Section({required this.title, required this.videos});
}

class Video {
  final String title;
  final String duration;
  final String path;

  Video({
    required this.title,
    required this.duration,
    required this.path,
  });
}
