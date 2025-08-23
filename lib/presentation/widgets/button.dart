import 'package:critijoy_note/config/theme/app_theme.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String title;
  final Function() onPressed;
  const Button({super.key, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all<Color>(white),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(color: lightgrey, width: 2),
            ),
          ),
        ),
        onPressed: () {
          onPressed();
        },
        child: Text(
          title,
          style: TextStyle(
            fontSize: 20,
            color:
                AppTheme(selectedColor: 1).getTheme().colorScheme.onSecondary,
          ),
        ),
      ),
    );
  }
}
// This widget displays a button styled with a white background, rounded corners, and a border, typically used for toggling modes or categories in an application.