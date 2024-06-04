// Copyright (c) 2024. Alexandr Moroz

import 'package:mobx/mobx.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../components/dialog.dart';
import '../../../../extra/router.dart';
import '../../../../extra/services.dart';
import '../../../../usecases/task_tree.dart';
import '../../../../views/_base/loadable.dart';
import '../../controllers/task_controller.dart';
import '../../usecases/edit.dart';
import 'transfer_selector.dart';
import 'transfer_selector_controller.dart';

part 'local_import_controller.g.dart';

class LocalImportController extends _LocalImportControllerBase with _$LocalImportController {
  LocalImportController(TaskController taskController) {
    _taskController = taskController;
  }
}

abstract class _LocalImportControllerBase with Store, Loadable {
  late final TaskController _taskController;

  Task get dstGroup => _taskController.task;

  @observable
  TaskController? srcController;

  @computed
  bool get srcSelected => srcController != null;

  Task? get srcGroup => srcController?.task;

  @action
  Future _setSrc(Task src) async {
    srcController = TaskController(taskIn: src);

    if (srcGroup?.filled == false) {
      await load(() async => await srcController!.reload());
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
    final controller = TransferSelectorController();
    controller.getSourcesForMove(dstGroup);
    final srcGoal = await showMTDialog<Task>(TransferSelectorDialog(
      controller,
      loc.task_transfer_source_hint,
      loc.task_transfer_import_empty_title,
    ));
    if (srcGoal != null) {
      _setSrc(srcGoal);
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
