import 'package:drift/drift.dart';
import 'users_table.dart';

@DataClassName('ReviewEntry')
class Reviews extends Table {
  TextColumn get id => text()(); // UUID, Primary Key
  TextColumn get userId => text().references(Users, #id)(); // Foreign Key
  TextColumn get title => text()();
  TextColumn get reviewText => text()();
  TextColumn get contentType => text()(); // Ej: "Dorama", "Anime"
  TextColumn get genre => text()();
  TextColumn get platform => text()();
  TextColumn get author => text()();
  RealColumn get rating => real()(); // 0.0 a 5.0
  IntColumn get totalEpisodes => integer().nullable()();
  IntColumn get season => integer().nullable()();
  TextColumn get favoriteCharacters =>
      text().nullable()(); // Separados por comas o JSON
  IntColumn get episodeDuration => integer().nullable()(); // En minutos
  TextColumn get imagePath => text()();
  DateTimeColumn get createdAt => dateTime()();
  IntColumn get syncStatus =>
      integer()(); // 0: Sincronizado, 1: Pendiente Crear, 2: Pendiente Editar, 3: Pendiente Eliminar

  @override
  Set<Column> get primaryKey => {id};
}
