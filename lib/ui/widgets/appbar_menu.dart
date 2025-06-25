import 'package:flutter/material.dart';

class appBar_Menu extends PreferredSize implements PreferredSizeWidget {
  const appBar_Menu({
    super.key,
    required super.preferredSize,
    required super.child,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.blue,
      centerTitle: true,
      title: Text('CritiJoy_Note', style: TextStyle(color: Colors.black)),
      actions: [
        Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.add_circle_outline, color: Colors.black),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.search, color: Colors.black),
            ),
          ],
        ),
      ],
      leading: IconButton(
        onPressed: () {},
        icon: Icon(Icons.dehaze_rounded, color: Colors.black),
      ),
    );
  }
}
// This widget creates a custom AppBar with a title, action buttons for adding and searching, and a leading button for navigation, all styled with a blue background and black icons.