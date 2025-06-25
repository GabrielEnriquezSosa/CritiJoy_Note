import 'package:critijoy_note/ui/widgets/button.dart';
import 'package:flutter/material.dart';

class OptionMenu extends StatelessWidget {
  const OptionMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(Icons.grid_view_outlined, color: Colors.black, size: 30),
          SizedBox(width: 140, height: 35, child: ButtonOption(title: 'Anime')),
          Container(
            color: Colors.white,
            width: 140,
            height: 35,
            child: ButtonOption(title: 'Peliculas'),
          ),
          Icon(Icons.filter_alt_outlined, color: Colors.black, size: 30),
        ],
      ),
    );
  }
}


// This widget displays a horizontal menu with icons and buttons for filtering and options, typically used in a navigation bar or toolbar.