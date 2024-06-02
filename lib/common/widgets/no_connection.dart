import 'package:coolmovies/common/constants/app_layout.dart';
import 'package:flutter/material.dart';

class NoConnection extends StatelessWidget {
  const NoConnection({
    Key? key,
    this.onRetryPressed,
  }) : super(key: key);

  final void Function()? onRetryPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          const Icon(
            Icons.wifi_off,
            size: 100,
            color: Colors.red,
          ),
          const SizedBox(height: AppLayout.spacingLarge),
          const Text(
            "Something went wrong",
            style: TextStyle(
              fontSize: 24,
            ),
          ),
          const SizedBox(height: AppLayout.spacingLarge),
          ElevatedButton(onPressed: onRetryPressed, child: const Text('Retry'))
        ],
      ),
    );
  }
}
