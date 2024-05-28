import 'package:flutter/material.dart';
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
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();
  final _ratingController = TextEditingController();
  final _userReviewerIdController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    _ratingController.dispose();
    _userReviewerIdController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final review = ReviewModel(
        title: _titleController.text,
        body: _bodyController.text,
        rating: int.parse(_ratingController.text),
        userReviewerId: _userReviewerIdController.text,
        movieId: widget.movieId,
      );

      widget.onSubmit(review);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a title';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _bodyController,
              decoration: const InputDecoration(labelText: 'Body'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a body';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _ratingController,
              decoration: const InputDecoration(labelText: 'Rating'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a rating';
                }
                final rating = int.tryParse(value);
                if (rating == null || rating < 1 || rating > 5) {
                  return 'Please enter a valid rating (1-5)';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _userReviewerIdController,
              decoration: const InputDecoration(labelText: 'User Reviewer ID'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a user reviewer ID';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submit,
              child: const Text('Submit Review'),
            ),
          ],
        ),
      ),
    );
  }
}
