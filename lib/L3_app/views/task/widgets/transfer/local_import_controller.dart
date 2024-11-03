// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';
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
    _dstTC = tc;
  }

  Future selectSourceForMove() async {
    final dst = dstGroup;
    // TODO: проверяем баланс в РП назначения. Хотя, в исходном тоже надо бы проверять...
    if (await dst.ws.checkBalance(loc.task_transfer_export_action_title)) {
      final tsc = TasksSelectorController();
      tsc.load(() async {
        final groups = <Task>[];
        for (Workspace ws in wsMainController.workspaces) {
          groups.addAll(await wsTransferUC.sourcesForMove(ws.id!));
        }
        groups.removeWhere((t) => t.wsId == dst.wsId && t.id == dst.id);

        if (groups.length == 1 && globalContext.mounted) {
          _setSingleSourceFlag(true);
          Navigator.of(globalContext).pop(groups.first);
        } else {
          groups.sort();
          tsc.setTasks(groups);
        }
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

abstract class _Base with Store, Loadable {
  late final TaskController _dstTC;

  Task get dstGroup => _dstTC.task;

  @observable
  TaskController? _srcTC;

  @computed
  bool get srcSelected => _srcTC != null;

  Task? get srcGroup => _srcTC?.task;

  @action
  Future _setSrc(Task src) async {
    _srcTC = TaskController(taskIn: src);

    if (srcGroup?.filled == false) {
      await load(() async => await _srcTC!.reload(closed: false));
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

  @observable
  bool singleSourceFlag = false;

  @action
  void _setSingleSourceFlag(bool ss) => singleSourceFlag = ss;
}
