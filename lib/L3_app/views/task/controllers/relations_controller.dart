// Copyright (c) 2023. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:mobx/mobx.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/entities/task_relation.dart';
import '../../../../L1_domain/entities_extensions/task_relation.dart';
import '../../../extra/services.dart';
import '../../../presenters/task_tree.dart';
import '../../../presenters/task_type.dart';
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
      reload();
    });
  }

  Future deleteRelationFromTask(Task dst) async {
    final r = _relations.firstWhereOrNull((r) => r.relatedTaskId(_taskId) == dst.id);
    if (r != null) {
      final relation = await relationsUC.deleteRelation(r);
      if (relation != null) {
        task.relations.remove(relation);
        reload();
        dst.relations.remove(relation);
      }
    }
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
  Iterable<Task> get _relatedTasks => _relations.map((r) => (TaskController()..init(wsId, r.relatedTaskId(_taskId))).task);
  @computed
  Iterable<int> get _relatedTasksIds => _relatedTasks.map((t) => t.id!);

  @computed
  List<Task> get _sortedRelatedTasks => _relatedTasks.sorted((t1, t2) => t1.compareTo(t2));

  @computed
  List<MapEntry<TaskState, List<Task>>> get tasksGroups => groups(_sortedRelatedTasks);

  static const _visibleTitlesCount = 1;

  @computed
  String get relationsStr => _sortedRelatedTasks.map((t) => t.title.isNotEmpty ? t.title : t.viewTitle).take(_visibleTitlesCount).join(', ');
  @computed
  String get relationsCountMoreStr => _relations.length > _visibleTitlesCount ? loc.more_count(_relations.length - _visibleTitlesCount) : '';
}
