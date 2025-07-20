import 'package:critijoy_note/config/theme/theme.dart';
import 'package:flutter/material.dart';

class AppBarMenu extends PreferredSize implements PreferredSizeWidget {
  const AppBarMenu({
    super.key,
    required super.preferredSize,
    required super.child,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: blue,
      centerTitle: true,
      title: Text('CritiJoy_Note', style: TextStyle(color: black)),
      actions: [
        Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/addreview');
              },
              icon: Icon(Icons.add_circle_outline, color: black),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.search, color: black),
            ),
          ],
        ),
      ],
      leading: IconButton(
        onPressed: () {},
        icon: Icon(Icons.dehaze_rounded, color: black),
      ),
    );
  }
}
// This widget creates a custom AppBar with a title, action buttons for adding and searching, and a leading button for navigation, all styled with a blue background and black icons.