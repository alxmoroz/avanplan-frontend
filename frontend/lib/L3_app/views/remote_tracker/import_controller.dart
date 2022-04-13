// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/goals/goal_import.dart';
import '../../../L1_domain/entities/goals/remote_tracker.dart';
import '../../extra/services.dart';
import '../_base/base_controller.dart';
import 'tracker_controller.dart';

part 'import_controller.g.dart';

class ImportController extends _ImportControllerBase with _$ImportController {}

abstract class _ImportControllerBase extends BaseController with Store {
  TrackerController get _trackerController => trackerController;

  @observable
  ObservableList<GoalImport> goals = ObservableList();

  @computed
  List<String> get selectedGoalsIds => goals.where((g) => g.selected).map((g) => g.code).toList();

  @override
  bool get validated => selectedGoalsIds.isNotEmpty;

  @action
  void _sortGoals() {
    goals.sort((g1, g2) => g1.title.compareTo(g2.title));
  }

  @action
  Future _fetchGoals(int trackerId) async {
    startLoading();
    goals = ObservableList.of(await importUC.getGoals(trackerId));
    _sortGoals();
    stopLoading();
  }

  @action
  void selectGoal(GoalImport goal, bool selected) {
    final index = goals.indexWhere((g) => g.code == goal.code);
    if (index >= 0) {
      goals[index] = goal.copyWithSelected(selected);
    }
  }

  /// действия,  роутер

  Future selectTracker(RemoteTracker? _rt) async {
    _trackerController.selectTracker(_rt);
    if (_rt != null) {
      await _fetchGoals(_rt.id);
    }
  }

  @action
  Future startImport(BuildContext context) async {
    startLoading();
    final done = await importUC.importGoals(
      _trackerController.selectedTrackerId!,
      selectedGoalsIds,
    );
    if (done) {
      await mainController.fetchGoals();
      Navigator.of(context).pop();
    }
    stopLoading();
  }
}
