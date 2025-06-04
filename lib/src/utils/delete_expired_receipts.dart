import 'package:drift/drift.dart';
import 'package:statiescan/src/database/app_database.dart';

class DeleteExpiredReceipts {
  final AppDatabase database;

  DeleteExpiredReceipts({required this.database});

  Future<void> deleteExpiredReceipts() async {
    final now = DateTime.now();

    final expiredReceipts =
        await (database.select(database.receipts)
          ..where((r) => r.expiresAt.isSmallerThanValue(now))).get();

    if (expiredReceipts.isEmpty) return;

    final idsToDelete = expiredReceipts.map((r) => r.id).toList();

    await (database.delete(database.receipts)
      ..where((r) => r.id.isIn(idsToDelete))).go();
  }
}
