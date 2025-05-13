import 'package:drift/drift.dart';
import 'package:statiescan/src/database/tables/stores.dart';

class Vouchers extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get code => text()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  IntColumn get storeId => integer().references(Stores, #id)();
}
