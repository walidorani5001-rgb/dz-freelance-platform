import 'package:flutter/material.dart';

class AppAvatar extends StatelessWidget {
  final String url;
  final double size;
  const AppAvatar({super.key, required this.url, this.size = 40});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: size / 2,
      backgroundImage: NetworkImage(url),
    );
  }
}
