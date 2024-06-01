import 'package:coolmovies/common/constants/app_layout.dart';
import 'package:coolmovies/common/utils/utils.dart';
import 'package:coolmovies/movie/movie.dart';
import 'package:flutter/material.dart';

Future<ReviewModal?> showAddReviewModal<ReviewModal>({
  required BuildContext context,
  required String movieId,
}) async {
  return await showDialog<ReviewModal?>(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppLayout.padding),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              MovieReviewForm(
                  movieId: movieId,
                  onSubmit: (review) {
                    UtilNavigate.goBack(context, review);
                  }),
            ],
          ),
        ),
      );
    },
  );
}
