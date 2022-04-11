// Copyright (c) 2022. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/api_schema/remote_tracker.dart';
import '../../../L1_domain/entities/goals/remote_tracker.dart';
import '../../components/confirmation_dialog.dart';
import '../../extra/services.dart';
import '../_base/base_controller.dart';
import 'tracker_edit_view.dart';

part 'tracker_controller.g.dart';

class TrackerController extends _TrackerControllerBase with _$TrackerController {}

abstract class _TrackerControllerBase extends BaseController with Store {
  /// тип трекера

  @observable
  ObservableList<RemoteTrackerType> types = ObservableList();

  @action
  void sortTypes() => types.sort((s1, s2) => s1.title.compareTo(s2.title));

  @observable
  int? selectedTypeId;

  @action
  void selectType(RemoteTrackerType? _type) => selectedTypeId = _type?.id;

  @computed
  RemoteTrackerType? get selectedType => types.firstWhereOrNull((s) => s.id == selectedTypeId);

  @action
  Future fetchTypes() async {
    types = ObservableList.of(await trackerTypesUC.getAll());
    sortTypes();
    selectType(selectedTracker?.type);
  }

  /// трекеры

  @observable
  ObservableList<RemoteTracker> trackers = ObservableList();

  @action
  void _sortTrackers() {
    trackers.sort((g1, g2) => g1.url.compareTo(g2.url));
  }

  @action
  Future fetchTrackers() async {
    //TODO: добавить LOADING
    trackers = ObservableList.of(await trackersUC.getAll());
    _sortTrackers();
  }

  @action
  void updateTrackerInList(RemoteTracker? rt) {
    if (rt != null) {
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
      _sortTrackers();
    }
  }

  /// выбранный трекер

  @observable
  int? selectedTrackerId;

  @action
  void selectTracker(RemoteTracker? _rt) => selectedTrackerId = _rt?.id;

  @computed
  RemoteTracker? get selectedTracker => trackers.firstWhereOrNull((g) => g.id == selectedTrackerId);

  @computed
  bool get canEdit => selectedTracker != null && selectedType != null;

  @override
  bool get allNeedFieldsTouched => super.allNeedFieldsTouched || canEdit;

  /// действия

  Future save(BuildContext context) async {
    final editedTracker = await trackersUC.save(RemoteTrackerUpsert(
      id: selectedTracker?.id,
      typeId: selectedTypeId!,
      url: tfAnnoForCode('url').text,
      loginKey: tfAnnoForCode('loginKey').text,
      password: tfAnnoForCode('password').text,
      description: tfAnnoForCode('description').text,
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
        description: '${loc.common_delete_dialog_description}',
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
      updateTrackerInList(tracker);
      if (tracker.deleted) {
        Navigator.of(context).pop();
      }
    }
  }
}
