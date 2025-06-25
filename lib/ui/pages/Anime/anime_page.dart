import 'package:critijoy_note/ui/widgets/appbar_menu.dart';
import 'package:critijoy_note/ui/pages/Anime/widgets/description_anime.dart';
import 'package:critijoy_note/ui/pages/Anime/widgets/image_anime.dart';
import 'package:critijoy_note/ui/widgets/option_menu.dart';

import 'package:critijoy_note/ui/pages/Anime/widgets/title_anime.dart';
import 'package:flutter/material.dart';

class AnimePage extends StatefulWidget {
  const AnimePage({super.key});

  @override
  State<AnimePage> createState() => _AnimePageState();
}

class _AnimePageState extends State<AnimePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar_Menu(preferredSize: Size(395, 60), child: Container()),
      body: Column(
        children: [
          OptionMenu(),

          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(0),
              itemCount: 10,
              itemBuilder: (context, index) {
                return Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 4.5),
                    color: Color.fromARGB(255, 217, 217, 217),
                    child: Row(
                      children: [
                        ImageAnime(),
                        SizedBox(width: 10),
                        TitleAnime(title: 'Title $index'),
                        SizedBox(width: 10),
                        DescriptionAnime(
                          description:
                              'Lorem Ipsumis simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
