// Copyright (c) 2022. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/goals/remote_tracker.dart';
import '../../extra/services.dart';
import '../_base/base_controller.dart';

part 'tracker_controller.g.dart';

class TrackerController extends _TrackerControllerBase with _$TrackerController {}

abstract class _TrackerControllerBase extends BaseController with Store {
  /// трекеры
  @observable
  ObservableList<RemoteTracker> trackers = ObservableList();

  @action
  void _sortTrackers() {
    trackers.sort((g1, g2) => g1.title.compareTo(g2.title));
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

  /// роутер

  Future showTracker(BuildContext context, RemoteTracker rt) async {
    selectTracker(rt);
    // await Navigator.of(context).pushNamed(TrackerView.routeName);
  }

  Future addTracker(BuildContext context) async {
    selectTracker(null);
    // final newTracker = await showEditTrackerDialog(context);
    // if (newTracker != null) {
    //   updateTrackerInList(newTracker);
    //   await showTracker(context, newTracker);
    // }
  }

  Future editTracker(BuildContext context) async {
    // final tracker = await showEditTrackerDialog(context);
    // if (tracker != null) {
    //   updateTrackerInList(tracker);
    //   if (tracker.deleted) {
    //     Navigator.of(context).pop();
    //   }
    // }
  }
}
