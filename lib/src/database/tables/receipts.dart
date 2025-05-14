import 'package:drift/drift.dart';
import 'package:statiescan/src/database/tables/stores.dart';

class Receipts extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get code => text()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  DateTimeColumn get expiresAt => dateTime().nullable()();

  IntColumn get storeId => integer().references(Stores, #id)();
}
