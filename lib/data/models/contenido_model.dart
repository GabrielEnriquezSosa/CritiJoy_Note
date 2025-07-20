import 'package:critijoy_note/domain/entities/type_content.dart';
import 'package:flutter/material.dart';

class OptionContenidoImpl extends TypeContent {
  final IconData? icon;

  OptionContenidoImpl({this.icon, required super.type});
}

class OptionContenidoImplList {
  static List<OptionContenidoImpl> contenidolist = [
    OptionContenidoImpl(type: 'Anime', icon: Icons.animation),
    OptionContenidoImpl(type: 'Películas', icon: Icons.local_movies),
    OptionContenidoImpl(type: 'Caricaturas', icon: Icons.child_care),
    OptionContenidoImpl(type: 'Reality show', icon: Icons.record_voice_over),
    OptionContenidoImpl(type: 'Dorama', icon: Icons.live_tv),
    OptionContenidoImpl(type: 'Telenovela', icon: Icons.theater_comedy),
    OptionContenidoImpl(type: 'Dibujos animados', icon: Icons.color_lens),
    OptionContenidoImpl(type: 'K-Drama', icon: Icons.tv),
    OptionContenidoImpl(type: 'Cartoon', icon: Icons.sentiment_very_satisfied),
    OptionContenidoImpl(type: 'Dorama chino', icon: Icons.video_camera_front),
  ];
}
