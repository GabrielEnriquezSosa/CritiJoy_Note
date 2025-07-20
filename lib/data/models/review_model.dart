import 'package:critijoy_note/data/data_sources/local_datasource.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:critijoy_note/domain/entities/review.dart';

class ReviewModel extends Review {
  ReviewModel({
    required super.id,
    required super.titulo,
    required super.sinopsis,
    required super.genero,
    required super.plataforma,
    required super.autor,
    required super.valoracion,
    required super.totalCapitulos,
    required super.temporada,
    required super.personajesFavoritos,
    required super.duracion,
    required super.imagen,
    required super.type_content_id,
    required super.usuarioId,
  });

  factory ReviewModel.fromjson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['Title'] ?? '', // Mapea correctamente
      titulo: json['Title'] ?? '',
      sinopsis: json['Description'] ?? '',
      genero: json['Genre'] ?? '',
      plataforma: json['Platform'] ?? '',
      autor: json['Director'] ?? '',
      valoracion: (json['Rating'] ?? 0).toDouble(),
      totalCapitulos: json['Episodes'] ?? 0,
      temporada: 1, // Si no tienes este dato, pon un valor por defecto
      personajesFavoritos: List<String>.from(json['Characters'] ?? []),
      duracion: json['Duration'] ?? '',
      imagen: json['Image'] ?? 'assets/images/anime.png',
      type_content_id: (json['Episodes'] ?? 0) > 20 ? 'Anime' : 'Películas',
      usuarioId: '', // Si no tienes este dato, pon un valor por defecto
    );
  }
  Map<String, dynamic> toJson() => {
    'id': id,
    'titulo': titulo,
    'sinopsis': sinopsis,
    'genero': genero,
    'plataforma': plataforma,
    'autor': autor,
    'valoracion': valoracion,
    'totalCapitulos': totalCapitulos,
    'temporada': temporada,
    'personajesFavoritos': personajesFavoritos,
    'duracion': duracion,
    'imagen': imagen,
    'type': type_content_id,
    'usuarioId': usuarioId,
  };
}

final List<ReviewModel> reviews =
    localDataSource.map((item) => ReviewModel.fromjson(item)).toList();
