import 'package:coolmovies/common/widgets/show_feed_back.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For Clipboard

import 'package:coolmovies/common/constants/app_layout.dart';
import 'package:coolmovies/common/utils/utils.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({
    super.key,
    this.showBackButton = true,
  });

  final bool showBackButton;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      leading: showBackButton
          ? BackButton(
              onPressed: () {
                UtilNavigate.goBack(context);
              },
            )
          : Center(
              child: SizedBox(
                height: AppLayout.logoSmall,
                child: Image.asset('assets/logo.png'),
              ),
            ),
      actions: [
        IconButton(
          icon: const Icon(Icons.info_outline),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Row(
                    children: [
                      Image.asset('assets/logo.png', height: AppLayout.logoSmall),
                      const SizedBox(width: AppLayout.spacingSmall),
                      const Text('CoolMovies'),
                    ],
                  ),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: [
                        const Text('Developer: Matias Solis'),
                        GestureDetector(
                          onTap: () {
                            Clipboard.setData(const ClipboardData(text: 'https://www.linkedin.com/in/solismatias/'));
                            showFeedback(true, successMessage: 'LinkedIn URL copied to clipboard');
                          },
                          child: const Text(
                            'linkedin.com/in/solismatias/',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                        const SizedBox(height: AppLayout.spacingSmall),
                        const Text('✅ List all the available movies, showing at least the title.'),
                        const Text('✅ Tapping on a movie must open a view page presenting all the available information to the user.'),
                        const Text('✅ Each movie page must display all its reviews.'),
                        const Text('✅ Each review should consist of (at least): title, body and stars (1-5).'),
                        const Text('✅ The user should be able to create new reviews.'),
                        const Text('✅ User should be able to see the reviews and the movies even if offline.'),
                        const Text('✅ User should be able to create reviews offline and sync them when online.'),
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Close'),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
