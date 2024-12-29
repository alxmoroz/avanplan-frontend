import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for WSRelationsApi
void main() {
  final instance = Openapi().getWSRelationsApi();

  group(WSRelationsApi, () {
    // Delete Relation
    //
    //Future<bool> deleteRelation_0(int wsId, int relationId, { int taskId }) async
    test('test deleteRelation_0', () async {
      // TODO
    });

    // Sources For Relations
    //
    //Future<BuiltList<TaskGet>> sourcesForRelations_0(int wsId, { int taskId }) async
    test('test sourcesForRelations_0', () async {
      // TODO
    });

    // Upsert Relation
    //
    //Future<TaskRelationGet> upsertRelation_0(int wsId, TaskRelationUpsert taskRelationUpsert, { int taskId }) async
    test('test upsertRelation_0', () async {
      // TODO
    });
  });
}
