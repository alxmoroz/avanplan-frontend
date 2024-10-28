import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for WSRelationsApi
void main() {
  final instance = Openapi().getWSRelationsApi();

  group(WSRelationsApi, () {
    // Delete Relation
    //
    //Future<bool> deleteRelation(int wsId, int relationId, { int taskId }) async
    test('test deleteRelation', () async {
      // TODO
    });

    // Sources For Relations
    //
    //Future<BuiltList<TaskGet>> sourcesForRelations(int wsId, { int taskId }) async
    test('test sourcesForRelations', () async {
      // TODO
    });

    // Upsert Relation
    //
    //Future<TaskRelationGet> upsertRelation(int wsId, TaskRelationUpsert taskRelationUpsert, { int taskId }) async
    test('test upsertRelation', () async {
      // TODO
    });
  });
}
