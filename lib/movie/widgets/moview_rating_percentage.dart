import 'package:flutter/material.dart';

class RatingSquare extends StatelessWidget {
  final List<int> ratings;

  const RatingSquare({super.key, required this.ratings});

  @override
  Widget build(BuildContext context) {
    double totalRatings = ratings.length.toDouble();
    double totalSum = 0;
    for (var rating in ratings) {
      totalSum += rating;
    }
    double averageRating = totalSum / totalRatings;
    double percentage = (averageRating / 5) * 100;

    Color color;
    String emoji;
    if (percentage < 40) {
      color = Colors.red[800]!;
      emoji = '😵';
    } else if (percentage < 70) {
      color = Colors.yellow[800]!;
      emoji = '🙂';
    } else {
      color = Colors.green[800]!;
      emoji = '😎';
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Center(
            child: Text(
              '${percentage.round()}%',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const Text(
          'User rating',
          style: TextStyle(fontSize: 18),
        ),
        Text(
          emoji,
          style: const TextStyle(fontSize: 24),
        ),
      ],
    );
  }
}
