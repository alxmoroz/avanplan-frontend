// Copyright (c) 2022. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:openapi/openapi.dart';

import '../../../L1_domain/entities/app_settings.dart';
import '../../../L1_domain/entities/goals/goal.dart';
import '../../extra/services.dart';
import '../_base/base_controller.dart';
import '../auth/login_view.dart';
import '../goal/goal_edit_view.dart';
import '../goal/goal_view.dart';

part 'main_controller.g.dart';

//TODO: Это контроллер списка целей. Но не главное окно. Переименовать

class MainController extends _MainControllerBase with _$MainController {
  @override
  Future<MainController> init() async {
    // эти инициализации здесь для авторизации
    // TODO: подыскать место получше
    settings = await settingsUC.getSettings();
    await settingsUC.updateVersion(packageInfo.version);
    await authUC.setApiCredentialsFromSettings();

    return this;
  }
}

abstract class _MainControllerBase extends BaseController with Store {
  // этот параметр не меняется после запуска
  String get appName => packageInfo.appName;

  /// настройки и авторизация

  @observable
  AppSettings? settings;

  @action
  void setSettings(AppSettings _settings) => settings = _settings;

  @computed
  bool get authorized => settings?.accessToken.isNotEmpty ?? false;

  @computed
  bool get isFirstLaunch => settings?.firstLaunch ?? true;

  @computed
  String get appVersion => settings?.version ?? '';

  @action
  Future logout(BuildContext context) async {
    await authUC.logout();
    Navigator.of(context).pushReplacementNamed(LoginView.routeName);
  }

  /// цели - рутовый объект

  @observable
  ObservableList<Goal> goals = ObservableList();

  @action
  void _sortGoals() {
    goals.sort((g1, g2) => g1.title.compareTo(g2.title));
  }

  @action
  Future fetchGoals() async {
    if (authorized) {
      //TODO: добавить LOADING
      goals = ObservableList.of(await goalsUC.getAll());
      _sortGoals();
    }
  }

  @action
  void updateGoalInList(Goal? goal) {
    if (goal != null) {
      final index = goals.indexWhere((g) => g.id == goal.id);
      if (index >= 0) {
        if (goal.deleted) {
          goals.remove(goal);
        } else {
          goals[index] = goal;
        }
      } else {
        goals.add(goal);
      }
      _sortGoals();
    }
  }

  /// выбранная цель

  @observable
  int? selectedGoalId;

  @action
  void selectGoal(Goal? _goal) => selectedGoalId = _goal?.id;

  @computed
  Goal? get selectedGoal => goals.firstWhereOrNull((g) => g.id == selectedGoalId);

  //TODO: для тестирования метод пока что тут. Нужен отдельный юзкейс и репы
  Future redmine() async {
    final builder = BodyGoalsApiV1IntegrationsRedmineGoalsPostBuilder()
      ..apiKey = '101b62ea94b4132625a3d079451ea13fed3f4b87'
      ..host = 'https://redmine.moroz.team';

    await openAPI.getIntegrationsRedmineApi().goalsApiV1IntegrationsRedmineGoalsPost(
          bodyGoalsApiV1IntegrationsRedmineGoalsPost: builder.build(),
        );
  }

  /// роутер

  Future showGoal(BuildContext context, Goal goal) async {
    selectGoal(goal);
    await Navigator.of(context).pushNamed(GoalView.routeName);
  }

  Future addGoal(BuildContext context) async {
    selectGoal(null);
    final newGoal = await showEditGoalDialog(context);
    if (newGoal != null) {
      updateGoalInList(newGoal);
      await showGoal(context, newGoal);
    }
  }

  Future editGoal(BuildContext context) async {
    final goal = await showEditGoalDialog(context);
    if (goal != null) {
      // только если редактирование было вызвано из вьюхи просмотра цели. Т.е. метод должен вызываться из вьюхи цели!
      // поэтому в контроллере цели должен находиться этот метод.
      updateGoalInList(goal);
      if (goal.deleted) {
        Navigator.of(context).pop();
      }
    }
  }
}
