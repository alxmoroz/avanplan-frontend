import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for TasksApi
void main() {
  final instance = Openapi().getTasksApi();

  group(TasksApi, () {
    // Assign Roles
    //
    //Future<BuiltList<MemberGet>> assignRoles(int taskId, int wsId, int memberId, BuiltList<int> requestBody) async
    test('test assignRoles', () async {
      // TODO
    });

    // Create
    //
    //Future<InvitationGet> createInvitation(int wsId, int taskId, Invitation invitation) async
    test('test createInvitation', () async {
      // TODO
    });

    // Delete
    //
    //Future<bool> deleteNote(int wsId, int noteId, int taskId) async
    test('test deleteNote', () async {
      // TODO
    });

    // Delete
    //
    //Future<bool> deleteRepeat(int wsId, int taskId, int repeatId) async
    test('test deleteRepeat', () async {
      // TODO
    });

    // Delete
    //
    //Future<bool> deleteStatus(int statusId, int wsId, int taskId) async
    test('test deleteStatus', () async {
      // TODO
    });

    // Delete
    //
    //Future<TasksChanges> deleteTask(int wsId, int taskId) async
    test('test deleteTask', () async {
      // TODO
    });

    // Delete
    //
    //Future<TasksChanges> deleteTransaction(int wsId, int taskId, int transactionId) async
    test('test deleteTransaction', () async {
      // TODO
    });

    // Duplicate
    //
    //Future<TasksChanges> duplicateTask(int wsId, int taskId, int srcWsId, { int srcTaskId }) async
    test('test duplicateTask', () async {
      // TODO
    });

    // Invitations
    //
    //Future<BuiltList<InvitationGet>> getInvitations(int taskId, int wsId, int roleId) async
    test('test getInvitations', () async {
      // TODO
    });

    // Move
    //
    //Future<TasksChanges> moveTask(int wsId, int taskId, int srcTaskId, int srcWsId) async
    test('test moveTask', () async {
      // TODO
    });

    // Repeat
    //
    //Future<TasksChanges> repeatTask(int wsId, int taskId, int srcWsId, { int srcTaskId }) async
    test('test repeatTask', () async {
      // TODO
    });

    // Setup Project Modules
    //
    //Future<BuiltList<ProjectModuleGet>> setupProjectModules(int taskId, int wsId, BuiltList<String> requestBody) async
    test('test setupProjectModules', () async {
      // TODO
    });

    // Status Tasks Count
    //
    //Future<int> statusTasksCount(int wsId, int taskId, int projectStatusId) async
    test('test statusTasksCount', () async {
      // TODO
    });

    // Node
    //
    //Future<TaskNode> taskNode(int taskId, int wsId, { bool closed, bool fullTree }) async
    test('test taskNode', () async {
      // TODO
    });

    // Unlink
    //
    //Future<bool> unlinkTask(int taskId, int wsId) async
    test('test unlinkTask', () async {
      // TODO
    });

    // Upload Attachment
    //
    //Future<AttachmentGet> uploadAttachment(int wsId, int taskId, int noteId, MultipartFile file) async
    test('test uploadAttachment', () async {
      // TODO
    });

    // Upsert
    //
    //Future<NoteGet> upsertNote(int wsId, int taskId, NoteUpsert noteUpsert) async
    test('test upsertNote', () async {
      // TODO
    });

    // Upsert
    //
    //Future<TaskRepeatGet> upsertRepeat(int wsId, int taskId, TaskRepeatUpsert taskRepeatUpsert) async
    test('test upsertRepeat', () async {
      // TODO
    });

    // Upsert
    //
    //Future<ProjectStatusGet> upsertStatus(int wsId, int taskId, ProjectStatusUpsert projectStatusUpsert) async
    test('test upsertStatus', () async {
      // TODO
    });

    // Upsert
    //
    //Future<TasksChanges> upsertTask(int wsId, TaskUpsert taskUpsert, { String prevPosition, String nextPosition, int taskId }) async
    test('test upsertTask', () async {
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
