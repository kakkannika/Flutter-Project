import 'package:flutter/material.dart';
import 'package:e_learning_app/G_DOPI/model/category_model.dart';

class CategoryCard extends StatelessWidget {
  final CategoryModel category;

  const CategoryCard({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.all(8.0),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                category.imageUrl,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 10),
          // Title Section
          Text(
            category.title,
            style: TextStyle(
              fontSize: screenWidth > 600 ? 16 : 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            category.description,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black87,
            ),
            maxLines: 2, // Limit to 2 lines
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 5),
          Text(
            'By ${category.author}',
            style: TextStyle(
              fontSize: screenWidth > 600 ? 14 : 12,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }
}