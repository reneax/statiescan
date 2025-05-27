import 'package:drift/drift.dart';

class Stores extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text()();

  IntColumn get lastExpiryTimeId => integer().nullable()();
}
