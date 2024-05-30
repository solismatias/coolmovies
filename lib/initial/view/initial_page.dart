import 'package:flutter/material.dart';

class InitialPage extends StatelessWidget {
  const InitialPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 45,
                  child: Image.asset('assets/logo.png'),
                ),
                const SizedBox(width: 10),
                Text(
                  'COOLMOVIES',
                  style: TextStyle(
                    fontSize: 24,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),
            CircularProgressIndicator(color: Theme.of(context).primaryColor),
          ],
        ),
      ),
    );
  }
}
