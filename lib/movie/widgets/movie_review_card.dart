import 'package:coolmovies/common/constants/app_layout.dart';
import 'package:coolmovies/common/widgets/widgets.dart';
import 'package:coolmovies/user/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movies_repository/movies_repository.dart';

class MovieReviewCard extends StatelessWidget {
  const MovieReviewCard({
    super.key,
    required this.review,
  });

  final ReviewModel review;

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
          children: [
            Row(
              children: [
                UserAvatar(id: review.userReviewerId, userName: review.userReviewerName),
                const SizedBox(width: AppLayout.spacingSmall),
                Text(
                  review.userReviewerName,
                  style: const TextStyle(fontSize: 20),
                ),
                if (review.userReviewerId == BlocProvider.of<UserBloc>(context).state.user.id)
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppLayout.padding / 2),
                    child: Text(
                      '(you)',
                      style: TextStyle(fontSize: 16, color: Colors.lightBlue),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: AppLayout.spacingSmall),
            Row(
              children: List.generate(5, (index) {
                return Icon(
                  index < review.rating ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                );
              }),
            ),
            const SizedBox(height: AppLayout.spacingSmall),
            Text(
              review.title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppLayout.spacingSmall),
            Text(
              review.body,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
