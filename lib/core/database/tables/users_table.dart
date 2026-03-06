import 'package:drift/drift.dart';

@DataClassName('UserEntry')
class Users extends Table {
  TextColumn get id => text()(); // UUID, Primary Key
  TextColumn get name => text()();
  TextColumn get email => text().unique()();
  TextColumn get passwordHash => text()();
  TextColumn get profilePicturePath => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  IntColumn get syncStatus =>
      integer()(); // 0: Synced, 1: Pending Create, 2: Pending Update

  @override
  Set<Column> get primaryKey => {id};
}
