// Copyright (c) 2022. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/api_schema/remote_tracker.dart';
import '../../../L1_domain/entities/auth/workspace.dart';
import '../../../L1_domain/entities/goals/remote_tracker.dart';
import '../../components/confirmation_dialog.dart';
import '../../components/text_field_annotation.dart';
import '../../extra/services.dart';
import '../_base/base_controller.dart';
import '../workspace/workspace_bounded.dart';
import 'tracker_edit_view.dart';

part 'tracker_controller.g.dart';

class TrackerController extends _TrackerControllerBase with _$TrackerController {}

abstract class _TrackerControllerBase extends BaseController with Store, WorkspaceBounded {
  @override
  void initState({List<TFAnnotation>? tfaList}) {
    super.initState(tfaList: tfaList);
    selectType(selectedTracker?.type);
  }

  // TODO: здесь загружаем и проверяем трекеры на старте приложения (загружаем вместе в РП). Что не обязательно делать на старте.
  // Если тут сделать по запросу, тогда в окне импорта нужно будет учесть тоже

  @override
  Future fetchData() async {
    trackers.clear();
    if (loginController.authorized) {
      startLoading();
      for (Workspace ws in workspaceController.workspaces) {
        trackers.addAll(ws.remoteTrackers);
      }
      _sortAndCheckTrackers();

      rtTypes = ObservableList.of(await trackerTypesUC.getAll());
      _sortTypes();

      stopLoading();
    }
  }

  /// тип трекера

  @observable
  ObservableList<RemoteTrackerType> rtTypes = ObservableList();

  @action
  void _sortTypes() => rtTypes.sort((s1, s2) => s1.title.compareTo(s2.title));

  @observable
  int? selectedTypeId;

  @action
  void selectType(RemoteTrackerType? _type) => selectedTypeId = _type?.id;

  @computed
  RemoteTrackerType? get selectedType => rtTypes.firstWhereOrNull((s) => s.id == selectedTypeId);

  /// трекеры

  @observable
  ObservableList<RemoteTracker> trackers = ObservableList();

  /// выбранный трекер

  @observable
  int? selectedTrackerId;

  @action
  void selectTracker(RemoteTracker? _rt) {
    selectedTrackerId = _rt?.id;
    selectWS(_rt?.workspaceId);
  }

  @computed
  RemoteTracker? get selectedTracker => trackers.firstWhereOrNull((g) => g.id == selectedTrackerId);

  @computed
  bool get canEdit => selectedTracker != null;

  @override
  bool get validated => super.validated && selectedType != null && selectedWS != null;

  @action
  Future _sortAndCheckTrackers() async {
    trackers.forEachIndexed((index, t) async {
      bool connected = false;
      try {
        connected = (await importUC.getGoals(t.id)).isNotEmpty;
      } catch (_) {}
      trackers[index] = t.copyWithConnected(connected);
    });
    trackers.sort((g1, g2) => g1.url.compareTo(g2.url));
  }

  @action
  void _updateTrackerInList(RemoteTracker? rt) {
    if (rt != null) {
      startLoading();
      final index = trackers.indexWhere((g) => g.id == rt.id);
      if (index >= 0) {
        if (rt.deleted) {
          trackers.remove(rt);
        } else {
          trackers[index] = rt;
        }
      } else {
        trackers.add(rt);
      }
      _sortAndCheckTrackers();
      stopLoading();
    }
  }

  /// действия

  Future save(BuildContext context) async {
    final editedTracker = await trackersUC.save(RemoteTrackerUpsert(
      id: selectedTracker?.id,
      typeId: selectedTypeId!,
      url: tfAnnoForCode('url').text,
      loginKey: tfAnnoForCode('loginKey').text,
      password: tfAnnoForCode('password').text,
      description: tfAnnoForCode('description').text,
      workspaceId: selectedWS!.id,
    ));

    if (editedTracker != null) {
      Navigator.of(context).pop(editedTracker);
    }
  }

  Future delete(BuildContext context) async {
    if (canEdit) {
      final confirm = await showMTDialog<bool?>(
        context,
        title: loc.tracker_delete_dialog_title,
        description: '${loc.tracker_delete_dialog_description}\n\n${loc.common_delete_dialog_description}',
        actions: [
          MTDialogAction(title: loc.common_yes, isDestructive: true, result: true),
          MTDialogAction(title: loc.common_no, isDefault: true, result: false),
        ],
      );
      if (confirm != null && confirm) {
        Navigator.of(context).pop(await trackersUC.delete(tracker: selectedTracker!));
      }
    }
  }

  /// роутер

  Future addTracker(BuildContext context) async {
    editTracker(context, null);
  }

  Future editTracker(BuildContext context, RemoteTracker? rt) async {
    selectTracker(rt);
    final tracker = await showEditTrackerDialog(context);
    if (tracker != null) {
      _updateTrackerInList(tracker);
      if (tracker.deleted) {
        Navigator.of(context).pop();
      }
    }
  }
}
