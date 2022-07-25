// Copyright (c) 2022. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/remote_tracker.dart';
import '../../../L1_domain/entities/task_import.dart';
import '../../../L1_domain/system/errors.dart';
import '../../extra/services.dart';
import '../_base/edit_controller.dart';

part 'import_controller.g.dart';

class ImportController extends _ImportControllerBase with _$ImportController {}

abstract class _ImportControllerBase extends EditController with Store {
  @observable
  ObservableList<TaskImport> remoteTasks = ObservableList();

  @computed
  List<String> get selectedTasksIds => remoteTasks.where((t) => t.selected).map((t) => t.code).toList();

  @override
  bool get validated => selectedTasksIds.isNotEmpty;

  @action
  void _sortTasks() => remoteTasks.sort((t1, t2) => t1.title.compareTo(t2.title));

  @action
  Future fetchTasks(int trackerId) async {
    startLoading();
    clearData();
    if (loginController.authorized) {
      try {
        remoteTasks = ObservableList.of(await importUC.getRootTasks(trackerId));
        _sortTasks();
      } catch (e) {
        setErrorCode(e is MTException ? e.code : e.toString());
      }
    }
    stopLoading();
  }

  @action
  void clearData() => remoteTasks.clear();

  @action
  void selectTask(TaskImport task, bool selected) {
    final index = remoteTasks.indexWhere((t) => t.code == task.code);
    if (index >= 0) {
      remoteTasks[index] = task.copyWithSelected(selected);
    }
  }

  /// выбранный трекер

  @observable
  int? selectedTrackerId;

  @action
  Future selectTracker(RemoteTracker? _rt) async {
    selectedTrackerId = _rt?.id;
    if (_rt != null) {
      await fetchTasks(_rt.id);
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
    final done = await importUC.importTasks(selectedTracker!, selectedTasksIds);
    if (done) {
      await mainController.fetchData();
      Navigator.of(context).pop();
    }
    stopLoading();
  }

  Future addTracker(BuildContext context) async {
    Navigator.of(context).pop('Add tracker');
  }
}
