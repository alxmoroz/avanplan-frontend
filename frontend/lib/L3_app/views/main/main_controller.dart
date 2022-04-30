// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/auth/workspace.dart';
import '../../../L1_domain/entities/goals/goal.dart';
import '../../extra/services.dart';
import '../_base/base_controller.dart';
import '../import/import_view.dart';
import '../remote_tracker/tracker_list_view.dart';

part 'main_controller.g.dart';

//TODO: Это контроллер списка целей. Но не главное окно. Переименовать?

class MainController extends _MainControllerBase with _$MainController {}

abstract class _MainControllerBase extends BaseController with Store {
  /// цели - рутовый объект

  @observable
  ObservableList<Goal> goals = ObservableList();

  @action
  void _sortGoals() {
    goals.sort((g1, g2) => g1.title.compareTo(g2.title));
  }

  @action
  void updateGoalInList(Goal? _goal) {
    if (_goal != null) {
      final index = goals.indexWhere((g) => g.id == _goal.id);
      if (index >= 0) {
        if (_goal.deleted) {
          goals.remove(_goal);
        } else {
          goals[index] = _goal.copy();
        }
      } else {
        goals.add(_goal);
      }
      _sortGoals();
    }
  }

  @override
  Future fetchData() async {
    startLoading();
    if (loginController.authorized) {
      goals.clear();
      for (Workspace ws in workspaceController.workspaces) {
        goals.addAll(ws.goals);
      }
      _sortGoals();
    }
    stopLoading();
  }

  Future showTrackers(BuildContext context) async {
    await Navigator.of(context).pushNamed(TrackerListView.routeName);
  }

  Future importGoals(BuildContext context) async {
    await showImportDialog(context);
  }
}
