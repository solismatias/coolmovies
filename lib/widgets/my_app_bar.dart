import 'package:coolmovies/utils/utils.dart';
import 'package:flutter/material.dart';

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
                height: 35,
                child: Image.asset('assets/logo.png'),
              ),
            ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
