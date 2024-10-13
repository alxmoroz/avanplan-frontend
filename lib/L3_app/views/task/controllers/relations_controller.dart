// Copyright (c) 2023. Alexandr Moroz

import 'package:avanplan/L3_app/presenters/task_relation.dart';
import 'package:collection/collection.dart';
import 'package:mobx/mobx.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/entities/task_relation.dart';
import '../../../extra/services.dart';
import 'task_controller.dart';

part 'relations_controller.g.dart';

class RelationsController extends _Base with _$RelationsController {
  RelationsController(TaskController tcIn) {
    taskController = tcIn;
  }
}

abstract class _Base with Store {
  late final TaskController taskController;
  Task get task => taskController.task;

  @observable
  ObservableList<TaskRelation> _relations = ObservableList();

  @action
  void reload() => _relations = ObservableList.of(task.relations);

  @computed
  List<TaskRelation> get sortedRelations => _relations.sorted((r1, r2) => r1.title(task.id!).compareTo(r2.title(task.id!)));

  static const _visibleTitles = 1;

  @computed
  String get relationsStr => sortedRelations.map((r) => r.title(task.id!)).take(_visibleTitles).join(', ');
  @computed
  String get relationsCountMoreStr => sortedRelations.length > _visibleTitles ? loc.more_count(_relations.length - _visibleTitles) : '';
}
