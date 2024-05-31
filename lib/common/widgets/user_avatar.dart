import 'dart:math';

import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  final String id;
  final String userName;

  const UserAvatar({
    super.key,
    required this.id,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    String initials = userName.substring(0, 2).toUpperCase();

    Color backgroundColor = _generateColorFromId(id);

    return CircleAvatar(
      radius: 25,
      backgroundColor: backgroundColor,
      child: Text(
        initials,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Color _generateColorFromId(String id) {
    int hash = id.hashCode;
    Random random = Random(hash);
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }
}
