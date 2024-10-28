// Copyright (c) 2023. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:mobx/mobx.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/entities/task_relation.dart';
import '../../../../L1_domain/entities_extensions/task_relation.dart';
import '../../../extra/services.dart';
import '../../../presenters/task_relation.dart';
import '../../../presenters/task_tree.dart';
import '../../../views/_base/loadable.dart';
import 'task_controller.dart';

part 'relations_controller.g.dart';

class RelationsController extends _Base with _$RelationsController {
  RelationsController(TaskController tcIn) {
    tc = tcIn;
  }
}

abstract class _Base with Store, Loadable {
  late final TaskController tc;
  Task get task => tc.task;
  int get _wsId => tc.taskDescriptor.wsId;
  int get _taskId => tc.taskDescriptor.id!;

  @observable
  ObservableList<TaskRelation> _relations = ObservableList();

  @observable
  int forbiddenRelatedTasksCount = 0;

  @action
  void setForbiddenRelatedTasksCount(int count) => forbiddenRelatedTasksCount = count;

  @computed
  bool get hasRelations => _relations.isNotEmpty;

  @action
  void reload() => _relations = ObservableList.of(tc.task.relations);

  @computed
  Iterable<int> get _relatedTasksIds => _relations.map((r) => r.relatedTaskId(_taskId));

  @computed
  List<MapEntry<TaskState, List<Task>>> get tasksGroups => groups(_relatedTasksIds.map((id) => tasksMainController.task(_wsId, id)).whereNotNull());

  Future reloadRelatedTasks() async {
    await load(() async {
      final frtCount = await tasksMainController.loadTasksIfAbsent(_wsId, _relatedTasksIds);
      setForbiddenRelatedTasksCount(frtCount);
    });
  }

  @computed
  List<TaskRelation> get sortedRelations => _relations.sorted((r1, r2) => r1.title(_taskId).compareTo(r2.title(_taskId)));

  static const _visibleTitlesCount = 1;

  @computed
  String get relationsStr => sortedRelations.map((r) => r.title(_taskId)).take(_visibleTitlesCount).join(', ');
  @computed
  String get relationsCountMoreStr => sortedRelations.length > _visibleTitlesCount ? loc.more_count(_relations.length - _visibleTitlesCount) : '';
}
