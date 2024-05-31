import 'package:coolmovies/common/constants/app_layout.dart';
import 'package:coolmovies/user/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_repository/movies_repository.dart';

class MovieReviewForm extends StatefulWidget {
  const MovieReviewForm({
    super.key,
    required this.movieId,
    required this.onSubmit,
  });

  final String movieId;
  final void Function(ReviewModel review) onSubmit;

  @override
  State<MovieReviewForm> createState() => _MovieReviewFormState();
}

class _MovieReviewFormState extends State<MovieReviewForm> {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final bodyController = TextEditingController();
  int rating = 0;
  bool isRatingValid = true;

  @override
  void dispose() {
    titleController.dispose();
    bodyController.dispose();
    super.dispose();
  }

  void _submit(context) {
    setState(() {
      isRatingValid = rating >= 1 && rating <= 5;
    });

    if (formKey.currentState!.validate() && isRatingValid) {
      final review = ReviewModel(
        title: titleController.text,
        body: bodyController.text,
        rating: rating,
        userReviewerId: BlocProvider.of<UserBloc>(context).state.user.id,
        movieId: widget.movieId,
      );

      widget.onSubmit(review);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(AppLayout.padding),
        child: Column(
          children: [
            _StarRow(
                selectedStars: rating,
                onStarTapped: (newRating) {
                  setState(() {
                    rating = newRating;
                  });
                }),
            if (!isRatingValid)
              Text(
                'Please select a rating',
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            const SizedBox(height: AppLayout.spacingMedium),
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a title';
                }
                return null;
              },
            ),
            const SizedBox(height: AppLayout.spacingMedium),
            TextFormField(
              controller: bodyController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Opinion',
                hintMaxLines: 4,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an opinion';
                }
                return null;
              },
            ),
            const SizedBox(height: AppLayout.spacingMedium),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () => _submit(context),
                  child: const Text('Send'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StarRow extends StatelessWidget {
  const _StarRow({
    required this.selectedStars,
    required this.onStarTapped,
  });

  final int selectedStars;
  final Function(int) onStarTapped;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
          5,
          (index) => GestureDetector(
                onTap: () => onStarTapped(index + 1),
                child: Icon(
                  index < selectedStars ? Icons.star : Icons.star_border,
                  color: Colors.yellow,
                  size: 40,
                ),
              )),
    );
  }
}
