import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function() onPressed;
  final Color titleColor;
  final Color iconColor;
  final Color borderColor;
  final Color? backgroundColor;

  const ActionButton({
    super.key,
    required this.title,
    required this.icon,
    required this.onPressed,
    required this.titleColor,
    required this.iconColor,
    required this.borderColor,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    if (backgroundColor != null) {
      return FilledButton.icon(
        style: FilledButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: titleColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        ),
        onPressed: onPressed,
        icon: Icon(icon, color: iconColor),
        label: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: titleColor,
          ),
        ),
      );
    }

    return OutlinedButton.icon(
      style: OutlinedButton.styleFrom(
        foregroundColor: titleColor,
        side: BorderSide(color: borderColor, width: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      ),
      onPressed: onPressed,
      icon: Icon(icon, color: iconColor),
      label: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: titleColor,
        ),
      ),
    );
  }
}
