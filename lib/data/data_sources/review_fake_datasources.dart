import 'package:critijoy_note/data/data_sources/local_datasource.dart';
import 'package:critijoy_note/data/data_sources/review_datasources.dart';
import 'package:critijoy_note/data/models/review_model.dart';
import 'package:critijoy_note/data/repositories/review_repository_impl.dart';
import 'package:critijoy_note/domain/entities/review.dart';
import 'package:critijoy_note/domain/usecases/get_reviews_by_type.dart';

class ReviewFakeDataSource implements ReviewDataSource {
  final List<ReviewModel> _data = [];

  ReviewFakeDataSource() {
    // Cargar datos iniciales desde rawData
    _data.addAll(localDataSource.map((e) => ReviewModel.fromjson(e)));
  }

  @override
  Future<void> addReview(Review review) async {
    _data.add(
      review is ReviewModel
          ? review
          : ReviewModel(
            id: review.id,
            titulo: review.titulo,
            sinopsis: review.sinopsis,
            imagen: review.imagen,
            genero: review.genero,
            valoracion: review.valoracion,
            personajesFavoritos: review.personajesFavoritos,
            totalCapitulos: review.totalCapitulos,
            plataforma: review.plataforma,
            autor: review.autor,
            type_content_id: review.type_content_id,
            temporada: review.temporada,
            duracion: review.duracion,
            usuarioId: review.usuarioId,
          ),
    );
  }

  @override
  Future<List<Review>> getReviewsByType(String type) async {
    return _data
        .where((r) => r.type_content_id.toLowerCase() == type.toLowerCase())
        .toList();
  }

  @override
  Future<void> deleteReview(String id) async {
    _data.removeWhere((r) => r.id == id);
  }

  @override
  Future<void> updateReview(Review review) {
    // TODO: implement updateReview
    throw UnimplementedError();
  }
}
