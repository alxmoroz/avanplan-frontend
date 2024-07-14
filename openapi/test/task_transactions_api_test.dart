import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for TaskTransactionsApi
void main() {
  final instance = Openapi().getTaskTransactionsApi();

  group(TaskTransactionsApi, () {
    // Delete
    //
    //Future<TasksChanges> deleteTransaction(int wsId, int taskId, int transactionId) async
    test('test deleteTransaction', () async {
      // TODO
    });

    // Upsert
    //
    //Future<TasksChanges> upsertTransaction(int wsId, int taskId, TaskTransactionUpsert taskTransactionUpsert) async
    test('test upsertTransaction', () async {
      // TODO
    });
  });
}
