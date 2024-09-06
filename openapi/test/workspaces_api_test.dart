import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for WorkspacesApi
void main() {
  final instance = Openapi().getWorkspacesApi();

  group(WorkspacesApi, () {
    // Assign Roles
    //
    //Future<BuiltList<MemberGet>> assignRoles(int taskId, int wsId, int memberId, BuiltList<int> requestBody) async
    test('test assignRoles', () async {
      // TODO
    });

    // Available Tariffs
    //
    //Future<BuiltList<TariffGet>> availableTariffs(int wsId) async
    test('test availableTariffs', () async {
      // TODO
    });

    // Check Connection
    //
    //Future<bool> checkConnection(int wsId, int sourceId) async
    test('test checkConnection', () async {
      // TODO
    });

    // Create From Template
    //
    //Future<TasksChanges> createFromTemplate(int wsId, int srcProjectId, int srcWsId, { int srcTaskId, int taskId }) async
    test('test createFromTemplate', () async {
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
    //Future<bool> deleteSource(int sourceId, int wsId) async
    test('test deleteSource', () async {
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

    // Destinations For Move
    //
    //Future<BuiltList<TaskGet>> destinationsForMove(int wsId, String taskType, { int taskId }) async
    test('test destinationsForMove', () async {
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

    // My Workspaces
    //
    //Future<BuiltList<WorkspaceGet>> getMyWorkspaces() async
    test('test getMyWorkspaces', () async {
      // TODO
    });

    // Get Projects
    //
    //Future<BuiltList<TaskRemote>> getProjects(int wsId, int sourceId) async
    test('test getProjects', () async {
      // TODO
    });

    // Get Workspace
    //
    //Future<WorkspaceGet> getWorkspace(int wsId) async
    test('test getWorkspace', () async {
      // TODO
    });

    // Member Assigned Tasks
    //
    // Задачи участника РП
    //
    //Future<BuiltList<TaskGet>> memberAssignedTasks(int memberId, int wsId, { int taskId }) async
    test('test memberAssignedTasks', () async {
      // TODO
    });

    // Move
    //
    //Future<TasksChanges> moveTask(int wsId, int taskId, int srcTaskId, int srcWsId) async
    test('test moveTask', () async {
      // TODO
    });

    // Projects
    //
    // Мои проекты, куда у меня есть доступ, в том числе Входящие
    //
    //Future<BuiltList<TaskGet>> myProjects(int wsId, { bool closed, bool imported, int taskId }) async
    test('test myProjects', () async {
      // TODO
    });

    // Tasks
    //
    // Мои задачи
    //
    //Future<BuiltList<TaskGet>> myTasks(int wsId, { int projectId, int taskId }) async
    test('test myTasks', () async {
      // TODO
    });

    // Project Templates
    //
    //Future<BuiltList<ProjectGet>> projectTemplates(int wsId) async
    test('test projectTemplates', () async {
      // TODO
    });

    // Repeat
    //
    //Future<TasksChanges> repeatTask(int wsId, int taskId, int srcWsId, { int srcTaskId }) async
    test('test repeatTask', () async {
      // TODO
    });

    // Request Type
    //
    //Future<bool> requestType(int wsId, BodyRequestType bodyRequestType) async
    test('test requestType', () async {
      // TODO
    });

    // Setup Project Modules
    //
    //Future<BuiltList<ProjectModuleGet>> setupProjectModules(int taskId, int wsId, BuiltList<String> requestBody) async
    test('test setupProjectModules', () async {
      // TODO
    });

    // Sign
    //
    //Future<InvoiceGet> sign(int tariffId, int wsId) async
    test('test sign', () async {
      // TODO
    });

    // Sources For Move
    //
    //Future<BuiltList<TaskGet>> sourcesForMoveTasks(int wsId, { int taskId }) async
    test('test sourcesForMoveTasks', () async {
      // TODO
    });

    // Start Import
    //
    //Future<bool> startImport(int wsId, int sourceId, BodyStartImport bodyStartImport) async
    test('test startImport', () async {
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
    //Future<TaskNode> taskNode(int taskId, int wsId, { bool closed }) async
    test('test taskNode', () async {
      // TODO
    });

    // Unlink
    //
    //Future<bool> unlinkTask(int taskId, int wsId) async
    test('test unlinkTask', () async {
      // TODO
    });

    // Upsert
    //
    //Future<WorkspaceGet> updateWorkspace(int wsId, WorkspaceUpsert workspaceUpsert) async
    test('test updateWorkspace', () async {
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
    //Future<InvoiceGet> upsertOption(int wsId, int tariffId, int optionId, bool subscribe) async
    test('test upsertOption', () async {
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
    //Future<SourceGet> upsertSource(int wsId, SourceUpsert sourceUpsert) async
    test('test upsertSource', () async {
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
