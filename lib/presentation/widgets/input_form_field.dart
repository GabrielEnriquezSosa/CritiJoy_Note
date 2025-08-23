import 'package:critijoy_note/config/theme/app_theme.dart';
import 'package:flutter/material.dart';

class InputFormField extends StatelessWidget {
  final String labelText;
  final int maxLength;
  final double? widht;
  final double labelfont;
  final TextInputType keyboardType;
  const InputFormField({
    super.key,
    required this.labelText,
    required this.maxLength,
    required this.keyboardType,
    this.widht,
    required this.labelfont,
  });

  @override
  Widget build(BuildContext context) {
    return FormField(
      builder: (context) {
        return Container(
          width: widht,
          padding: EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
            color: lightBlue,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              width: 2,
              color: grey,
              style: BorderStyle.solid,
              strokeAlign: BorderSide.strokeAlignOutside,
            ),
          ),
          child: TextFormField(
            keyboardType: keyboardType,
            maxLines: keyboardType == TextInputType.multiline ? 5 : 1,
            maxLength: maxLength,
            cursorHeight: 20,
            buildCounter: (
              BuildContext context, {
              required int currentLength,
              required bool isFocused,
              required int? maxLength,
            }) {
              return null;
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: lightBlue,
              floatingLabelStyle: TextStyle(fontSize: 20, color: Colors.black),
              labelText: labelText,
              labelStyle: TextStyle(fontSize: labelfont, color: Colors.black),
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide.none, // No border for the input field
              ),
            ),
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
        );
      },
    );
  }
}
