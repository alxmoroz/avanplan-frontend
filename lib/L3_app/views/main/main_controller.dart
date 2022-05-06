// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../_base/base_controller.dart';
import '../import/import_view.dart';
import '../remote_tracker/tracker_list_view.dart';

part 'main_controller.g.dart';

class MainController extends _MainControllerBase with _$MainController {}

abstract class _MainControllerBase extends BaseController with Store {
  Future showTrackers(BuildContext context) async {
    await Navigator.of(context).pushNamed(TrackerListView.routeName);
  }

  Future importGoals(BuildContext context) async {
    await showImportDialog(context);
  }
}
