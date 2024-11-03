// Copyright (c) 2024. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:mobx/mobx.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities_extensions/task_type.dart';
import '../../../../presenters/task_tree.dart';
import '../../../../views/_base/loadable.dart';

part 'tasks_selector_controller.g.dart';

const AVANPLAN_KEY_OTHER_PROJECTS = '_AVANPLAN_KEY_OTHER_PROJECTS';

class TasksSelectorController extends _Base with _$TasksSelectorController {}

abstract class _Base with Store, Loadable {
  @observable
  List<Task> tasks = [];

  @action
  void setTasks(List<Task> tasksIn) => tasks = tasksIn;

  @computed
  List<MapEntry<String, List<Task>>> get groups {
    final gt = groupBy<Task, String>(
        tasks,
        (t) => t.isProject
            ? AVANPLAN_KEY_OTHER_PROJECTS
            : t.isInbox
                ? ''
                : t.project.title);
    return gt.entries.sorted((g1, g2) {
      final title1 = g1.key;
      final title2 = g2.key;
      int res = 0;

      if (title2.isEmpty || title1 == AVANPLAN_KEY_OTHER_PROJECTS) {
        res = 1;
      } else if (title1.isEmpty || title2 == AVANPLAN_KEY_OTHER_PROJECTS) {
        res = -1;
      }

      if (res == 0) {
        res = compareNatural(g1.key, g2.key);
      }

      return res;
    });
  }
}
