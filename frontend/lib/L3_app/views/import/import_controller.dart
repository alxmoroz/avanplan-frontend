// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/goals/goal_import.dart';
import '../../../L1_domain/entities/goals/remote_tracker.dart';
import '../../../L1_domain/system/errors.dart';
import '../../extra/services.dart';
import '../_base/base_controller.dart';
import '../remote_tracker/tracker_controller.dart';

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
    goals = ObservableList();
    try {
      goals = ObservableList.of(await importUC.getGoals(trackerId));
      _sortGoals();
    } catch (e) {
      setErrorCode(e is MTException ? e.code : e.toString());
    }
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
    final wsId = mainController.selectedWSId;
    if (wsId == null) {
      return;
    }

    startLoading();
    final done = await importUC.importGoals(
      _trackerController.selectedTrackerId!,
      wsId,
      selectedGoalsIds,
    );
    if (done) {
      await mainController.fetchData();
      Navigator.of(context).pop();
    }
    stopLoading();
  }

  Future addTracker(BuildContext context) async {
    _trackerController.addTracker(context);
  }
}
