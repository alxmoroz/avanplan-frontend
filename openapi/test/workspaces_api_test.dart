import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for WorkspacesApi
void main() {
  final instance = Openapi().getWorkspacesApi();

  group(WorkspacesApi, () {
    // Assign
    //
    //Future<BuiltList<MemberGet>> assignRole(int taskId, int wsId, int memberId, BuiltList<int> requestBody, { int permissionTaskId }) async
    test('test assignRole', () async {
      // TODO
    });

    // Create
    //
    //Future<InvitationGet> createInvitation(int wsId, int taskId, Invitation invitation, { int permissionTaskId }) async
    test('test createInvitation', () async {
      // TODO
    });

    // Create Workspace
    //
    //Future<WorkspaceGet> createWorkspace() async
    test('test createWorkspace', () async {
      // TODO
    });

    // Delete
    //
    //Future<bool> deleteNote(int noteId, int wsId, int taskId, { int permissionTaskId }) async
    test('test deleteNote', () async {
      // TODO
    });

    // Delete
    //
    //Future<TasksChanges> deleteTask(int taskId, int wsId, { int permissionTaskId }) async
    test('test deleteTask', () async {
      // TODO
    });

    // Available Tariffs
    //
    //Future<BuiltList<TariffGet>> getAvailableTariffs(int wsId) async
    test('test getAvailableTariffs', () async {
      // TODO
    });

    // Invitations
    //
    //Future<BuiltList<InvitationGet>> getInvitations(int taskId, int wsId, int roleId, { int permissionTaskId }) async
    test('test getInvitations', () async {
      // TODO
    });

    // Get My Workspaces
    //
    //Future<BuiltList<WorkspaceGet>> getMyWorkspaces() async
    test('test getMyWorkspaces', () async {
      // TODO
    });

    // Get Workspace
    //
    //Future<WorkspaceGet> getWorkspace(int wsId) async
    test('test getWorkspace', () async {
      // TODO
    });

    // Setup Feature Sets
    //
    //Future<BuiltList<ProjectFeatureSetGet>> setupFeatureSets(int taskId, int wsId, BuiltList<int> requestBody, { int permissionTaskId }) async
    test('test setupFeatureSets', () async {
      // TODO
    });

    // Update Workspace
    //
    //Future<WorkspaceGet> updateWorkspace(int wsId, WorkspaceUpsert workspaceUpsert) async
    test('test updateWorkspace', () async {
      // TODO
    });

    // Upsert
    //
    //Future<NoteGet> upsertNote(int wsId, int taskId, NoteUpsert noteUpsert, { int permissionTaskId }) async
    test('test upsertNote', () async {
      // TODO
    });

    // Task Upsert
    //
    //Future<TasksChanges> upsertTask(int wsId, TaskUpsert taskUpsert, { int permissionTaskId, int taskId }) async
    test('test upsertTask', () async {
      // TODO
    });
  });
}
