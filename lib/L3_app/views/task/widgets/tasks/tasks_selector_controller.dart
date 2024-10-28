// Copyright (c) 2024. Alexandr Moroz

import 'package:mobx/mobx.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../views/_base/loadable.dart';

part 'tasks_selector_controller.g.dart';

class TasksSelectorController extends _Base with _$TasksSelectorController {}

abstract class _Base with Store, Loadable {
  @observable
  List<Task> tasks = [];

  @action
  void setTasks(List<Task> tasksIn) => tasks = tasksIn;
}
