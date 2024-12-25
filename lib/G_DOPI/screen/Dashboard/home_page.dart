import 'package:e_learning_app/G_DOPI/screen/Grade_Calculate/grade_calculate.dart';
import 'package:e_learning_app/G_DOPI/screen/Social_Science/social_science.dart';
import 'package:e_learning_app/G_DOPI/screen/Tips/tips.dart';
import 'package:flutter/material.dart';
import '../../model/category_model.dart';
import '../../widget/category_card.dart';
import '../Science/science_page.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final List<CategoryModel> _categories = [
    CategoryModel(
      title: 'Science',
      author: 'Kannika',
      imageUrl: 'assets/images/Science.jpg',
      description: 'Explore the world of Mathematics, Physics, Chemistry, and Biology.',
    ),
    CategoryModel(
      title: 'Social Science',
      author: 'Kannika',
      imageUrl: 'assets/images/Social_Science.jpg',
      description: 'Dive into History, Geography, and Morality and so on.',
    ),
    CategoryModel(
      title: 'Grade Calculate',
      author: 'Kannika',
      imageUrl: 'assets/images/Grade_Calculate.png',
      description: 'Easily calculate and manage your grades here.',
    ),
    CategoryModel(
      title: 'Tips',
      author: 'Kannika',
      imageUrl: 'assets/images/Tips.jpg',
      description: 'Stay updated and share experience to help students achieve their goals.',
    ),
  ];

  String _searchText = ""; // Search query

  @override
  Widget build(BuildContext context) {
    // Filter categories based on the search text
    final filteredCategories = _categories.where((category) {
      return category.title.toLowerCase().contains(_searchText.toLowerCase());
    }).toList();

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),

          // Search Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                ),
              ],
            ),
            child: Row(
              children: [
                const Icon(Icons.search, color: Colors.grey),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        _searchText = value;
                      });
                    },
                    decoration: const InputDecoration(
                      hintText: 'Search for a category...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Category',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              TextButton(onPressed: () {}, child: const Text('View All')),
            ],
          ),

          // Category Grid
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: filteredCategories.length,
              itemBuilder: (context, index) {
                final category = filteredCategories[index];
                return GestureDetector(
                  onTap: () {
                    if (category.title == 'Science') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SciencePage(),
                        ),
                      );
                    } else if (category.title == 'Grade Calculate') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GradeCalculate(),
                        ),
                      );

                      
                    } 
                    else if (category.title == 'Social Science') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SocialScience(),
                        ),
                      );

                      
                    } 
                    else if (category.title == 'Tips') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TipsScreen(),
                        ),
                      );

                      
                    } 
                    
                    
                   
                  },
                  child: CategoryCard(
                    category: category,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}