// Copyright (c) 2023. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:mobx/mobx.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/entities/task_relation.dart';
import '../../../extra/services.dart';
import '../../../presenters/task_relation.dart';
import '../../../presenters/task_tree.dart';
import '../../../views/_base/loadable.dart';
import 'task_controller.dart';

part 'relations_controller.g.dart';

class RelationsController extends _Base with _$RelationsController {
  RelationsController(TaskController tcIn) {
    _tc = tcIn;
  }
}

abstract class _Base with Store, Loadable {
  late final TaskController _tc;
  Task get task => _tc.task;
  int get _wsId => _tc.taskDescriptor.wsId;
  int get _taskId => _tc.taskDescriptor.id!;

  @observable
  ObservableList<TaskRelation> _relations = ObservableList();

  @computed
  bool get hasRelations => _relations.isNotEmpty;

  @action
  void reload() => _relations = ObservableList.of(_tc.task.relations);

  @computed
  Iterable<int> get _relatedTasksIds => _relations.map((r) => r.relatedTaskId(_taskId));

  @computed
  List<MapEntry<TaskState, List<Task>>> get tasksGroups => groups(_relatedTasksIds.map((id) => tasksMainController.task(_wsId, id)).whereNotNull());

  Future reloadRelatedTasks() async {
    await load(() async {
      await tasksMainController.loadTasksIfAbsent(_wsId, _relatedTasksIds);
    });
  }

  @computed
  List<TaskRelation> get sortedRelations => _relations.sorted((r1, r2) => r1.title(_taskId).compareTo(r2.title(_taskId)));

  static const _visibleTitles = 1;

  @computed
  String get relationsStr => sortedRelations.map((r) => r.title(_taskId)).take(_visibleTitles).join(', ');
  @computed
  String get relationsCountMoreStr => sortedRelations.length > _visibleTitles ? loc.more_count(_relations.length - _visibleTitles) : '';
}
