import 'package:drift/drift.dart';
import 'package:statiescan/src/database/tables/stores.dart';

class Receipts extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get code => text()();

  IntColumn get amountInCents => integer()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  DateTimeColumn get expiresAt => dateTime().nullable()();

  IntColumn get storeId => integer().references(Stores, #id)();

  IntColumn get typeId => integer().withDefault(const Constant(32))();
}
