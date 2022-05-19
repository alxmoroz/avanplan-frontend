// Copyright (c) 2022. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/goals/goal_import.dart';
import '../../../L1_domain/entities/goals/remote_tracker.dart';
import '../../../L1_domain/system/errors.dart';
import '../../extra/services.dart';
import '../_base/edit_controller.dart';

part 'import_controller.g.dart';

class ImportController extends _ImportControllerBase with _$ImportController {}

abstract class _ImportControllerBase extends EditController with Store {
  @observable
  ObservableList<GoalImport> remoteGoals = ObservableList();

  @computed
  List<String> get selectedGoalsIds => remoteGoals.where((g) => g.selected).map((g) => g.code).toList();

  @override
  bool get validated => selectedGoalsIds.isNotEmpty;

  @action
  void _sortGoals() => remoteGoals.sort((g1, g2) => g1.title.compareTo(g2.title));

  @action
  Future fetchGoals(int trackerId) async {
    startLoading();
    clearData();
    if (loginController.authorized) {
      try {
        remoteGoals = ObservableList.of(await importUC.getGoals(trackerId));
        _sortGoals();
      } catch (e) {
        setErrorCode(e is MTException ? e.code : e.toString());
      }
    }
    stopLoading();
  }

  @action
  void clearData() => remoteGoals.clear();

  @action
  void selectGoal(GoalImport goal, bool selected) {
    final index = remoteGoals.indexWhere((g) => g.code == goal.code);
    if (index >= 0) {
      remoteGoals[index] = goal.copyWithSelected(selected);
    }
  }

  /// выбранный трекер

  @observable
  int? selectedTrackerId;

  @action
  Future selectTracker(RemoteTracker? _rt) async {
    selectedTrackerId = _rt?.id;
    if (_rt != null) {
      await fetchGoals(_rt.id);
    }
  }

  @computed
  RemoteTracker? get selectedTracker => trackerController.trackers.firstWhereOrNull((g) => g.id == selectedTrackerId);

  @computed
  bool get canEdit => selectedTracker != null;

  /// действия,  роутер

  @action
  Future startImport(BuildContext context) async {
    startLoading();
    final done = await importUC.importGoals(selectedTracker!, selectedGoalsIds);
    if (done) {
      // TODO: здесь должны обновляться только цели, но мы обновляем всё дерево данных. Поэтому есть побочки всякие
      await mainController.fetchData();
      Navigator.of(context).pop();
    }
    stopLoading();
  }

  Future addTracker(BuildContext context) async {
    trackerController.addTracker(context);
  }
}
