import 'package:coolmovies/common/constants/app_layout.dart';
import 'package:flutter/material.dart';

class MovieReviewCard extends StatelessWidget {
  const MovieReviewCard({
    super.key,
    required this.title,
    required this.body,
    required this.rating,
  });

  final String title;
  final String body;
  final int rating;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppLayout.padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppLayout.spacingSmall),
            Text(
              body,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: AppLayout.spacingSmall),
            Row(
              children: List.generate(5, (index) {
                return Icon(
                  index < rating ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
