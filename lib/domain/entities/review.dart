class Review {
  final String id;
  final String titulo;
  final String sinopsis;
  final String genero;
  final String plataforma;
  final String autor;
  final double valoracion;
  final int totalCapitulos;
  final int temporada;
  final List<String> personajesFavoritos;
  final String duracion;
  final String imagen;
  final String type_content_id;
  final String usuarioId;
  Review({
    required this.id,
    required this.titulo,
    required this.sinopsis,
    required this.genero,
    required this.plataforma,
    required this.autor,
    required this.valoracion,
    required this.totalCapitulos,
    required this.temporada,
    required this.personajesFavoritos,
    required this.duracion,
    required this.imagen,
    required this.type_content_id,
    required this.usuarioId,
  });
}
