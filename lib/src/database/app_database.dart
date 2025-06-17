import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:statiescan/src/database/app_database.steps.dart';
import 'package:statiescan/src/database/tables/receipts.dart';
import 'package:statiescan/src/database/tables/stores.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [Receipts, Stores])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 3;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'database',
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationDocumentsDirectory,
      ),
    );
  }

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (m) => m.createAll(),
      onUpgrade: stepByStep(
        from1To2: (m, schema) async {
          await m.addColumn(schema.receipts, schema.receipts.typeId);
        },
        from2To3: (m, schema) async {
          await m.addColumn(schema.receipts, schema.receipts.deletedAt);
        },
      ),
    );
  }
}
