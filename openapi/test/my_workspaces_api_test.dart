import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for MyWorkspacesApi
void main() {
  final instance = Openapi().getMyWorkspacesApi();

  group(MyWorkspacesApi, () {
    // Create Workspace
    //
    //Future<WorkspaceGet> createWorkspaceV1MyWorkspacesCreatePost({ WorkspaceUpsert workspaceUpsert }) async
    test('test createWorkspaceV1MyWorkspacesCreatePost', () async {
      // TODO
    });

    // Update Workspace
    //
    //Future<WorkspaceGet> updateWorkspaceV1MyWorkspacesUpdatePost(int wsId, WorkspaceUpsert workspaceUpsert) async
    test('test updateWorkspaceV1MyWorkspacesUpdatePost', () async {
      // TODO
    });

    // Workspaces
    //
    //Future<BuiltList<WorkspaceGet>> workspacesV1MyWorkspacesGet() async
    test('test workspacesV1MyWorkspacesGet', () async {
      // TODO
    });
  });
}
