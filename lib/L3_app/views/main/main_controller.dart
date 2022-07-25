// Copyright (c) 2022. Alexandr Moroz

import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/workspace.dart';
import '../../extra/services.dart';
import '../_base/base_controller.dart';

part 'main_controller.g.dart';

class MainController extends _MainControllerBase with _$MainController {}

abstract class _MainControllerBase extends BaseController with Store {
  /// рабочие пространства
  @observable
  ObservableList<Workspace> workspaces = ObservableList();

  @action
  void _sortWS() => workspaces.sort((s1, s2) => s1.title.compareTo(s2.title));

  @action
  Future fetchData() async {
    //TODO: сделать computed для всех зависимых данных? pro: прозрачная логика загрузки cons: увеличение связанности. В любом случае большой вопрос с редактированием словарей.
    // Например, трекеров... Будет похожая заморочка, как в дереве задач (зато есть опыт уже)
    startLoading();

    clearData();
    if (loginController.authorized) {
      workspaces = ObservableList.of(await workspacesUC.getAll());
      _sortWS();

      await taskViewController.fetchData();
      await trackerController.fetchData();
      await settingsController.fetchData();
      await userController.fetchData();
    }
    stopLoading();
  }

  @action
  void clearData() {
    workspaces.clear();
    taskViewController.clearData();
    trackerController.clearData();
    importController.clearData();
    settingsController.clearData();
    userController.clearData();
  }
}
