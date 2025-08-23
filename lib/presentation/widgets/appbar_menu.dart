import 'package:critijoy_note/config/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
      title: Text('CritiJoy_Note'),
      actions: [
        Row(
          children: [
            IconButton(
              onPressed: () {
                context.push('/addreview');
              },
              icon: Icon(Icons.add_circle_outline),
            ),
            IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          ],
        ),
      ],
    );
  }
}
// This widget creates a custom AppBar with a title, action buttons for adding and searching, and a leading button for navigation, all styled with a blue background and black icons.