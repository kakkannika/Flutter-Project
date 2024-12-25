import 'package:e_learning_app/G_DOPI/screen/Shopping_Card/pop_up_add_tocard.dart';
import 'package:flutter/material.dart'; 
import 'package:video_player/video_player.dart';
import 'video_player_screen.dart';
import '../../model/04_course_model.dart';


class CourseDetailPage extends StatefulWidget {
  final Course course;

  const CourseDetailPage({Key? key, required this.course}) : super(key: key);

  @override
  _CourseDetailPageState createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends State<CourseDetailPage> {
  late VideoPlayerController _videoController;
  bool _isVideoPlaying = false;
  bool isFavorite = false;
  bool isExpanded = false;
  bool isPurchased = false; 

  List<String> savedVideos = [];
  List<Map<String, dynamic>> cartItems = [];
  double totalPrice = 0.0;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.asset(widget.course.videoPreview)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  void _toggleVideoPlayback() {
    setState(() {
      if (_videoController.value.isPlaying) {
        _videoController.pause();
        _isVideoPlaying = false;
      } else {
        _videoController.play();
        _isVideoPlaying = true;
      }
    });
  }

  void _addToCart() {
    setState(() {
      isPurchased = true;
      cartItems.add({'courseName': widget.course.title, 'price': widget.course.price});
      totalPrice += widget.course.price;
    });

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Added to Cart'),
          content: const Text('The course has been added to your cart.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ShoppingCart(cartItems: cartItems, totalPrice: totalPrice),
                  ),
                );
              },
              child: const Text('View Cart'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildVideoItem(Video video) {
    return GestureDetector(
      onTap: () {
        if (isPurchased || video.title == 'Introduction') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VideoPlayerScreen(
                videoTitle: video.title,
                videoPath: video.path,
              ),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please purchase the course to access all videos.')),
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Checkbox(
              value: savedVideos.contains(video.title),
              onChanged: (value) {
                setState(() {
                  if (value == true) {
                    savedVideos.add(video.title);
                  } else {
                    savedVideos.remove(video.title);
                  }
                });
              },
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    video.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    video.duration,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.play_circle_outline, color: Colors.blue),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          children: [
            Text(widget.course.title),
            const Spacer(),
            IconButton(
              onPressed: () {
                
              },
              icon: const Icon(Icons.save_alt_outlined),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Video Preview Section
                  Stack(
                    children: [
                      Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: _videoController.value.isInitialized
                            ? AspectRatio(
                                aspectRatio: _videoController.value.aspectRatio,
                                child: VideoPlayer(_videoController),
                              )
                            : const Center(child: CircularProgressIndicator()),
                      ),
                      Positioned(
                        top: 0,
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: IconButton(
                            icon: Icon(
                              _isVideoPlaying
                                  ? Icons.pause_circle_filled
                                  : Icons.play_circle_fill,
                              size: 60,
                              color: Colors.white,
                            ),
                            onPressed: _toggleVideoPlayback,
                          ),
                        ),
                      ),
                      const Positioned(
                        bottom: 10,
                        left: 10,
                        child: Text(
                          'Preview this course',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            backgroundColor: Colors.black54,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Course Info Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.course.title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(widget.course.description),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Course Sections
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: widget.course.sections.map((section) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              section.title,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Column(
                              children: section.videos.map((video) {
                                return _buildVideoItem(video);
                              }).toList(),
                            ),
                            const SizedBox(height: 16),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Add to Cart Button
          if (!isPurchased)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: _addToCart,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Add to Cart - \$${widget.course.price}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

List<Course> courses = [
  Course(
    title: 'Physics',
    description: 'Learn the fundamentals of Physics.',
    videoPreview: 'assets/video/video1.mp4',
    price: 19.99,
    sections: [
      Section(
        title: 'Section 1 - Introduction',
        videos: [
          Video(title: 'Introduction', duration: '01:48 mins', path: 'assets/video/video1.mp4'),
          Video(title: 'What is Physics', duration: '05:51 mins', path: 'assets/video/video1.mp4'),
        ],
      ),
      Section(
        title: 'Section 2 - Basics',
        videos: [
          Video(title: 'Understanding Motion', duration: '02:30 mins', path: 'assets/video/motion.mp4'),
          Video(title: 'Basics of Thermodynamics', duration: '04:20 mins', path: 'assets/video/thermodynamics.mp4'),
        ],
      ),
    ],
  ),

];
