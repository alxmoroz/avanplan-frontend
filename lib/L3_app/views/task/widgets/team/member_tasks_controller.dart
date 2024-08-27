// Copyright (c) 2023. Alexandr Moroz

import 'package:mobx/mobx.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities_extensions/task_type.dart';
import '../../../../extra/services.dart';
import '../../../../views/_base/loadable.dart';

part 'member_tasks_controller.g.dart';

class MemberTasksController extends _Base with _$MemberTasksController {
  MemberTasksController(int wsId, int memberId) {
    _wsId = wsId;
    _memberId = memberId;
    setLoaderScreenLoading();
    reload();
  }
}

abstract class _Base with Store, Loadable {
  late final int _memberId;
  late final int _wsId;

  @observable
  int classifiedTasksCount = 0;

  @computed
  List<Task> get assignedTasks => tasksMainController.openedTasks.where((t) => t.wsId == _wsId && t.assigneeId == _memberId).toList();

  @computed
  bool get hasAssignedTasks => classifiedTasksCount > 0 || assignedTasks.isNotEmpty;

  @action
  Future reload() async {
    load(() async {
      final assignedTasks = await wsUC.memberAssignedTasks(_wsId, _memberId);
      tasksMainController.setTasks(assignedTasks.where((t) => !t.isClassified));
      classifiedTasksCount = assignedTasks.where((t) => t.isClassified).length;
    });
  }
}
