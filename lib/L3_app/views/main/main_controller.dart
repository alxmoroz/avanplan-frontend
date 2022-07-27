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
  Future fetchData() async {
    //TODO: сделать computed для всех зависимых данных? pro: прозрачная логика загрузки cons: увеличение связанности. В любом случае большой вопрос с редактированием словарей.
    // Например, трекеров... Будет похожая заморочка, как в дереве задач (зато есть опыт уже)
    // startLoading();
    workspaces = ObservableList.of(await workspacesUC.getAll());
    workspaces.sort((ws1, ws2) => ws1.title.compareTo(ws2.title));

    await taskViewController.fetchData();
    await trackerController.fetchData();
    await settingsController.fetchData();
    await userController.fetchData();
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

  Future updateAll() async {
    startLoading();
    await fetchData();
    // TODO: Подумать над фоновым обновлением или обновлением на бэке по расписанию. Иначе каждый запуск прилоежния — это будет вот это вст всё.
    // TODO: Можно эту логику на бэк отправить вообще вместе с настройкой частоты обновления для трекера. Чтобы вообще не запускать процесс импорта из клиента.
    await importController.updateImportedTasks();
    await fetchData();
    stopLoading();
  }
}
