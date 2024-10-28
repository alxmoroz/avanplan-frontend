// Copyright (c) 2024. Alexandr Moroz

import 'package:mobx/mobx.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities/task_relation.dart';
import '../../../../components/dialog.dart';
import '../../../../extra/services.dart';
import '../../../../navigation/router.dart';
import '../../../../presenters/task_tree.dart';
import '../../../../usecases/ws_actions.dart';
import '../../../_base/loadable.dart';
import '../../controllers/task_controller.dart';
import '../../usecases/edit.dart';
import '../tasks/tasks_selector_controller.dart';
import '../tasks/tasks_selector_dialog.dart';

part 'create_relations_controller.g.dart';

class CreateRelationsController extends _Base with _$CreateRelationsController {
  CreateRelationsController(TaskController tcIn) {
    _tc = tcIn;
  }
}

abstract class _Base with Store, Loadable {
  late final TaskController _tc;
  Task get task => _tc.task;

  @observable
  TaskController? _dstTC;

  @computed
  bool get dstSelected => _dstTC != null;

  Task? get dstGroup => _dstTC?.task;

  @observable
  List<Task> dstTasks = [];

  @action
  Future _setDstGroup(Task dst) async {
    _dstTC = TaskController(taskIn: dst);

    if (dstGroup?.filled == false) {
      await load(() async => await _dstTC!.reload());
    }

    dstTasks = dstGroup?.subtasks.toList() ?? [];
  }

  Future selectDstGroup() async {
    final src = task;

    if (await src.ws.checkBalance('${loc.action_add_title} ${loc.relation_title}'.toLowerCase())) {
      final tsc = TasksSelectorController();
      tsc.load(() async {
        final tasks = (await relationsUC.sourcesForRelations(src.wsId)).toList();
        tasks.sort();
        tsc.setTasks(tasks);
      });
      final dstGroup = await showMTDialog<Task>(TasksSelectorDialog(
        tsc,
        loc.relation_create_dialog_title,
        '',
      ));
      if (dstGroup != null) {
        _setDstGroup(dstGroup);
      }
    }
  }

  Future createRelation(Task dst) async {
    router.pop();
    load(() async {
      final src = task;
      await relationsUC.upsertRelation(TaskRelation(
        wsId: src.wsId,
        srcId: src.id!,
        dstId: dst.id!,
      ));
    });
  }
}
