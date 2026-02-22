class Review {
  final String id;
  final String userId;
  final String title;
  final String reviewText;
  final Enum contentType;
  final String genre;
  final String platform;
  final String author;
  final double rating;
  final int chapters;
  final int season;
  final String duration;
  final List<String> personajesFavoritos;
  final String image;
  final bool isSynced;
  final bool isDeleted;
  final DateTime updateAt;
  Review({
    required this.id,
    required this.title,
    required this.reviewText,
    required this.contentType,
    required this.genre,
    required this.userId,
    required this.platform,
    required this.author,
    required this.rating,
    required this.chapters,
    required this.season,
    required this.duration,
    required this.image,
    required this.isSynced,
    required this.isDeleted,
    required this.updateAt,
    required this.personajesFavoritos,
  });

  Review copyWith({
    String? id,
    String? userId,
    String? title,
    String? reviewText,
    Enum? contentType,
    String? genre,
    String? platform,
    String? author,
    double? rating,
    int? chapters,
    int? season,
    String? duration,
    List<String>? personajesFavoritos,
    String? image,
    bool? isSynced,
    bool? isDeleted,
    DateTime? updateAt,
  }) {
    return Review(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      reviewText: reviewText ?? this.reviewText,
      contentType: contentType ?? this.contentType,
      genre: genre ?? this.genre,
      platform: platform ?? this.platform,
      author: author ?? this.author,
      rating: rating ?? this.rating,
      chapters: chapters ?? this.chapters,
      season: season ?? this.season,
      duration: duration ?? this.duration,
      personajesFavoritos: personajesFavoritos ?? this.personajesFavoritos,
      image: image ?? this.image,
      isSynced: isSynced ?? this.isSynced,
      isDeleted: isDeleted ?? this.isDeleted,
      updateAt: updateAt ?? this.updateAt,
    );
  }
}
