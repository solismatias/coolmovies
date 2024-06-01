import 'package:flutter/material.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

void showFeedback(bool success, {String? successMessage, String? errorMessage}) {
  final snackBar = SnackBar(
    content: Text(
      success ? successMessage ?? 'Petition sent successfully!' : errorMessage ?? 'Failed to send petition.',
      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
    ),
    backgroundColor: success ? Colors.green : Colors.red,
  );

  scaffoldMessengerKey.currentState?.showSnackBar(snackBar);
}
