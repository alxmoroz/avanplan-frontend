// Copyright (c) 2024. Alexandr Moroz

import 'package:mobx/mobx.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities/workspace.dart';
import '../../../../components/dialog.dart';
import '../../../../extra/services.dart';
import '../../../../navigation/router.dart';
import '../../../../presenters/task_tree.dart';
import '../../../../usecases/ws_actions.dart';
import '../../../../views/_base/loadable.dart';
import '../../controllers/task_controller.dart';
import '../../usecases/edit.dart';
import '../tasks/tasks_selector_controller.dart';
import '../tasks/tasks_selector_dialog.dart';

part 'local_import_controller.g.dart';

class LocalImportController extends _Base with _$LocalImportController {
  LocalImportController(TaskController tc) {
    _tc = tc;
  }
}

abstract class _Base with Store, Loadable {
  late final TaskController _tc;

  Task get dstGroup => _tc.task;

  @observable
  TaskController? _srcController;

  @computed
  bool get srcSelected => _srcController != null;

  Task? get srcGroup => _srcController?.task;

  @action
  Future _setSrc(Task src) async {
    _srcController = TaskController(taskIn: src);

    if (srcGroup?.filled == false) {
      await load(() async => await _srcController!.reload(closed: false));
    }

    srcTasks = srcGroup?.openedSubtasks.toList() ?? [];
    checks = ObservableList.of([for (var _ in srcTasks) false]);
  }

  @observable
  List<Task> srcTasks = [];

  @observable
  ObservableList<bool> checks = ObservableList();

  @computed
  bool get validated => checks.contains(true);

  @computed
  bool get selectedAll => !checks.contains(false);

  @action
  void toggleAll(bool? value) => checks = ObservableList.of([for (var _ in srcTasks) value == true]);

  @action
  void checkTask(int index, bool? selected) => checks[index] = selected == true;

  Future selectSourceForMove() async {
    // TODO: проверяем баланс в РП назначения. Хотя, в исходном тоже надо бы проверять...
    final dst = dstGroup;
    if (await dst.ws.checkBalance(loc.task_transfer_export_action_title)) {
      final tsc = TasksSelectorController();
      tsc.load(() async {
        // перенос из других целей, бэклогов, проектов
        final tasks = <Task>[];
        for (Workspace ws in wsMainController.workspaces) {
          tasks.addAll(await wsTransferUC.sourcesForMove(ws.id!));
        }
        tasks.removeWhere((t) => t.wsId == dst.wsId && t.id == dst.id);
        tasks.sort();
        tsc.setTasks(tasks);
      });
      final srcGroup = await showMTDialog<Task>(TasksSelectorDialog(
        tsc,
        loc.task_transfer_source_hint,
        loc.task_transfer_import_empty_title,
      ));
      if (srcGroup != null) {
        _setSrc(srcGroup);
      }
    }
  }

  Future moveTasks() async {
    router.pop();
    for (int index = 0; index < checks.length; index++) {
      if (checks[index]) {
        final src = srcTasks[index];
        await TaskController(taskIn: src).move(dstGroup);
      }
    }
  }
}
