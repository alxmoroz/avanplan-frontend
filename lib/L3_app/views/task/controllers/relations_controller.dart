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
import '../widgets/relations/create_relation_dialog.dart';
import 'task_controller.dart';

part 'relations_controller.g.dart';

class RelationsController extends _Base with _$RelationsController {
  RelationsController(TaskController tcIn) {
    _tc = tcIn;
  }

  void startCreateRelation() => createRelationDialog(_tc);

  Future reloadRelatedTasks() async {
    await load(() async {
      final forbiddenTasksCount = await tasksMainController.loadTasksIfAbsent(wsId, _relatedTasksIds);
      setForbiddenRelatedTasksCount(forbiddenTasksCount);
    });
  }
}

abstract class _Base with Store, Loadable {
  late final TaskController _tc;
  Task get task => _tc.task;
  int get wsId => _tc.taskDescriptor.wsId;
  int get _taskId => _tc.taskDescriptor.id!;

  @observable
  ObservableList<TaskRelation> _relations = ObservableList();

  @observable
  int forbiddenRelatedTasksCount = 0;

  @action
  void setForbiddenRelatedTasksCount(int count) => forbiddenRelatedTasksCount = count;

  @computed
  bool get hasRelations => _relations.isNotEmpty;

  @action
  void reload() => _relations = ObservableList.of(task.relations);

  @computed
  Iterable<int> get _relatedTasksIds => _relations.map((r) => r.relatedTaskId(_taskId));

  @computed
  List<MapEntry<TaskState, List<Task>>> get tasksGroups => groups(_relatedTasksIds.map((id) => tasksMainController.task(wsId, id)).whereNotNull());

  @computed
  List<TaskRelation> get sortedRelations => _relations.sorted((r1, r2) => r1.title(_taskId).compareTo(r2.title(_taskId)));

  static const _visibleTitlesCount = 1;

  @computed
  String get relationsStr => sortedRelations.map((r) => r.title(_taskId)).take(_visibleTitlesCount).join(', ');
  @computed
  String get relationsCountMoreStr => sortedRelations.length > _visibleTitlesCount ? loc.more_count(_relations.length - _visibleTitlesCount) : '';
}
