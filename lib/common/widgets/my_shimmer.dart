import 'package:coolmovies/common/constants/app_layout.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MyShimmer extends StatelessWidget {
  final double width;
  final double height;

  const MyShimmer({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color(0xFF121212),
      highlightColor: const Color(0xFF757575),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(AppLayout.borderRadius),
        ),
      ),
    );
  }
}
