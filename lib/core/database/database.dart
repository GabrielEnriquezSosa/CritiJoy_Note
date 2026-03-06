import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'tables/users_table.dart';
import 'tables/reviews_table.dart';

// Generates the code needed by Drift.
part 'database.g.dart';

@DriftDatabase(tables: [Users, Reviews])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // You can add migrations here in the future
}

LazyDatabase _openConnection() {
  // `LazyDatabase` utility lets us find the right location for the file async.
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
