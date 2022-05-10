// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/auth/workspace.dart';
import '../../extra/services.dart';
import '../_base/base_controller.dart';
import '../import/import_view.dart';
import '../remote_tracker/tracker_list_view.dart';

part 'main_controller.g.dart';

class MainController extends _MainControllerBase with _$MainController {}

abstract class _MainControllerBase extends BaseController with Store {
  /// рабочие пространства
  @observable
  ObservableList<Workspace> workspaces = ObservableList();

  @action
  void _sortWS() => workspaces.sort((s1, s2) => s1.title.compareTo(s2.title));

  @override
  Future fetchData() async {
    //TODO: сделать computed для всех зависимых данных? pro: прозрачная логика загрузки cons: увеличение связанности. В любом случае большой вопрос с редактированием словарей.
    // Например, трекеров... Будет похожая заморочка, как в дереве задач (зато есть опыт уже)

    workspaces.clear();
    if (loginController.authorized) {
      startLoading();
      workspaces = ObservableList.of(await workspacesUC.getAll());
      _sortWS();

      stopLoading();
    }
  }

  Future showTrackers(BuildContext context) async {
    await Navigator.of(context).pushNamed(TrackerListView.routeName);
  }

  Future importGoals(BuildContext context) async {
    await showImportDialog(context);
  }
}
