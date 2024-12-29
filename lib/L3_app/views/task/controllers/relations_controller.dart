// Copyright (c) 2023. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:mobx/mobx.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/entities/task_relation.dart';
import '../../../../L1_domain/entities_extensions/task_relation.dart';
import '../../../presenters/task_type.dart';
import '../../../views/_base/loadable.dart';
import '../../app/services.dart';
import '../usecases/state.dart';
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
  int get wsId => tc.taskDescriptor.wsId;
  int get _taskId => tc.taskDescriptor.id!;

  @observable
  ObservableList<TaskRelation> relations = ObservableList();

  @observable
  int forbiddenRelatedTasksCount = 0;

  @action
  void setForbiddenRelatedTasksCount(int count) => forbiddenRelatedTasksCount = count;

  @computed
  bool get hasRelations => relations.isNotEmpty;

  @action
  void reload() => relations = ObservableList.of(task.relations);

  @computed
  Iterable<Task> get _relatedTasks => relations.map((r) => (TaskController()..init(wsId, r.relatedTaskId(_taskId))).task);

  @computed
  Iterable<int> get relatedTasksIds => _relatedTasks.map((t) => t.id!);

  @computed
  List<Task> get _sortedRelatedTasks => _relatedTasks.sorted((t1, t2) => t1.compareTo(t2));

  static const _visibleTitlesCount = 1;

  @computed
  String get relationsStr => _sortedRelatedTasks.map((t) => t.title.isNotEmpty ? t.title : t.viewTitle).take(_visibleTitlesCount).join(', ');
  @computed
  String get relationsCountMoreStr => relations.length > _visibleTitlesCount ? loc.more_count(relations.length - _visibleTitlesCount) : '';

  @computed
  Iterable<Task> get _availableTasks =>
      _relatedTasks.where((rt) => tasksMainController.task(rt.wsId, rt.id) != null).sorted((t1, t2) => t1.compareTo(t2));

  @computed
  List<MapEntry<TaskState, List<Task>>> get availableTasksGroups => groups(_availableTasks);
}
