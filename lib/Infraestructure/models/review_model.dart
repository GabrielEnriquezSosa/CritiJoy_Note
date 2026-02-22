import 'package:critijoy_note/Infraestructure/data_sources/local_datasource.dart';
import 'package:critijoy_note/domain/entities/review.dart';

class ReviewModel extends Review {
  ReviewModel({
    required super.id,
    required super.title,
    required super.reviewText,
    required super.contentType,
    required super.genre,
    required super.userId,
    required super.platform,
    required super.author,
    required super.rating,
    required super.chapters,
    required super.season,
    required super.duration,
    required super.image,
    required super.isSynced,
    required super.isDeleted,
    required super.updateAt,
    required super.personajesFavoritos,
  });

  factory ReviewModel.fromjson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'] ?? '',
      title: json['Title'] ?? '',
      reviewText: json['Description'] ?? '',
      contentType: _parseContentType(json['ContentType'] ?? 'Anime'),
      genre: json['Genre'] ?? '',
      userId: json['UserId'] ?? '',
      platform: json['Platform'] ?? '',
      author: json['Director'] ?? '',
      rating: (json['Rating'] ?? 0).toDouble(),
      chapters: json['Episodes'] ?? 0,
      season: 1,
      personajesFavoritos: List<String>.from(json['Characters'] ?? []),
      duration: json['Duration'] ?? '',
      image: json['Image'] ?? 'assets/images/anime.png',
      isSynced: json['IsSynced'] ?? false,
      isDeleted: json['IsDeleted'] ?? false,
      updateAt:
          json['UpdateAt'] != null
              ? DateTime.parse(json['UpdateAt'])
              : DateTime.now(),
    );
  }

  static Enum _parseContentType(dynamic value) {
    // Implementa la conversión según tu enum ContentType
    // Por ahora retorna un enum genérico basado en el string
    if (value is Enum) return value;
    return _ContentTypeEnum.values.firstWhere(
      (e) =>
          e.toString().split('.').last.toLowerCase() ==
          value.toString().toLowerCase(),
      orElse: () => _ContentTypeEnum.anime,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'titulo': title,
    'review': reviewText,
    'genero': genre,
    'plataforma': platform,
    'autor': author,
    'valoracion': rating,
    'totalCapitulos': chapters,
    'temporada': season,
    'personajesFavoritos': personajesFavoritos,
    'duracion': duration,
    'imagen': image,
    'type': contentType,
    'usuarioId': userId,
  };
}

enum _ContentTypeEnum { anime, manga, book, movie, tvshow }

final List<ReviewModel> reviews =
    localDataSource.map((item) => ReviewModel.fromjson(item)).toList();
