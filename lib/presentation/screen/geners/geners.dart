import 'package:critijoy_note/config/theme/theme.dart';
import 'package:flutter/material.dart';

class GenersScreen extends StatelessWidget {
  const GenersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Generos'), centerTitle: true),
      body: Row(
        children: [
          Container(
            width: 100,
            height: 100,
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/anime.png'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.5),
                  BlendMode.darken,
                ),
              ),
            ),
            child: Center(
              child: Text(
                'Accion',
                style: TextStyle(fontSize: 20, color: white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
