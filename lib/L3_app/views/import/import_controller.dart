// Copyright (c) 2022. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/remote_tracker.dart';
import '../../../L1_domain/entities/task_import.dart';
import '../../../L1_domain/system/errors.dart';
import '../../extra/services.dart';
import '../_base/edit_controller.dart';
import 'import_view.dart';

part 'import_controller.g.dart';

class ImportController extends _ImportControllerBase with _$ImportController {}

abstract class _ImportControllerBase extends EditController with Store {
  @observable
  ObservableList<TaskImport> remoteTasks = ObservableList();

  @computed
  List<String> get selectedTasksIds => remoteTasks.where((t) => t.selected).map((t) => t.remoteCode).toList();

  @override
  bool get validated => selectedTasksIds.isNotEmpty;

  @action
  Future fetchTasks(int trackerId) async {
    startLoading();
    clearData();
    if (loginController.authorized) {
      try {
        final rootTasks = await importUC.getRootTasks(trackerId);
        remoteTasks = ObservableList.of(rootTasks);
        remoteTasks.sort((t1, t2) => t1.title.compareTo(t2.title));
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
    final index = remoteTasks.indexWhere((t) => t.remoteCode == task.remoteCode);
    if (index >= 0) {
      remoteTasks[index] = task.copyWithSelected(selected);
    }
  }

  @override
  bool get isLoading => super.isLoading || mainController.isLoading;

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

  Future importTasks(BuildContext context) async {
    if (trackerController.trackers.isEmpty) {
      await trackerController.addTracker(context);
    }
    final res = await showImportDialog(context);
    if (res == 'Add tracker') {
      await importTasks(context);
    }
  }

  Future updateImportedTasks() async {
    // TODO: исключение для "локальных" задач
    // трекеры и импортированные задачи
    final importedTasks = taskViewController.rootTask.tasks.where((rt) => rt.trackerId != null);
    final Set trackersIds = importedTasks.map((t) => t.trackerId).toSet();
    for (int trID in trackersIds) {
      final Set<String> ids = (importedTasks.where((t) => t.trackerId == trID)).map((t) => t.remoteCode!).toSet();
      final tracker = trackerController.trackersMap[trID];
      await importUC.importTasks(tracker!, ids.toList());
    }
  }
}
