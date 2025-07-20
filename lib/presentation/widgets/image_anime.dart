import 'package:flutter/material.dart';

class ImageAnime extends StatelessWidget {
  final String imagePath;
  final double? width;
  final double? height;
  final Color? color;
  final double borderRadius;

  const ImageAnime({
    super.key,
    required this.imagePath,
    this.width,
    this.height,
    this.color,
    required this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(borderRadius),
        image: DecorationImage(image: AssetImage(imagePath), fit: BoxFit.cover),
        border: Border.all(
          width: 2,
          color: Colors.grey,
          style: BorderStyle.solid,
          strokeAlign: BorderSide.strokeAlignOutside,
        ),
      ),
    );
  }
}
// This widget displays an image from the assets folder with specified dimensions and fit.