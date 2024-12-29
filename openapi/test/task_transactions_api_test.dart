import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for TaskTransactionsApi
void main() {
  final instance = Openapi().getTaskTransactionsApi();

  group(TaskTransactionsApi, () {
    // Delete
    //
    //Future<TasksChanges> deleteTransaction_1(int wsId, int taskId, int transactionId) async
    test('test deleteTransaction_1', () async {
      // TODO
    });

    // Upsert
    //
    //Future<TasksChanges> upsertTransaction_1(int wsId, int taskId, TaskTransactionUpsert taskTransactionUpsert) async
    test('test upsertTransaction_1', () async {
      // TODO
    });
  });
}
