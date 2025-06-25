import 'package:flutter/material.dart';

class ButtonOption extends StatelessWidget {
  final String title;
  const ButtonOption({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(Colors.white),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: Colors.grey, width: 2),
          ),
        ),
      ),
      onPressed: () {},
      child: Text(title, style: TextStyle(fontSize: 20)),
    );
  }
}
// This widget displays a button styled with a white background, rounded corners, and a border, typically used for toggling modes or categories in an application.