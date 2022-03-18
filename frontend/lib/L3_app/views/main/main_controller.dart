// Copyright (c) 2022. Alexandr Moroz

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

  /// настройки
  @observable
  AppSettings? settings;

  @action
  void setSettings(AppSettings _settings) => settings = _settings;

  @observable
  ObservableList<Goal> goals = ObservableList();

  @observable
  Goal? selectedGoal;

  @action
  void selectGoal(Goal? _goal) => selectedGoal = _goal;

  @action
  Future fetchGoals() async {
    if (authorized) {
      //TODO: добавить LOADING
      goals = ObservableList.of(await goalsUC.getGoals());
      _sortGoals();
    }
  }

  @computed
  bool get authorized => settings?.accessToken.isNotEmpty ?? false;

  @computed
  bool get isFirstLaunch => settings?.firstLaunch ?? true;

  @computed
  String get appVersion => settings?.version ?? '';

  @action
  Future logout() async {
    await authUC.logout();
    Navigator.of(context!).pushReplacementNamed(LoginView.routeName);
  }

  @action
  void _addGoalToList(Goal goal) {
    goals.add(goal);
    _sortGoals();
  }

  @action
  void _deleteGoalFromList(Goal goal) {
    goals.remove(goal);
    _sortGoals();
  }

  void _sortGoals() {
    goals.sort((g1, g2) => g1.title.compareTo(g2.title));
  }

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

  Future showGoal(Goal goal) async {
    selectGoal(goal);
    final result = await Navigator.of(context!).pushNamed(GoalView.routeName);
    if (result == 'deleted') {
      _deleteGoalFromList(goal);
    }
  }

  Future addGoal() async {
    selectGoal(null);
    final newGoal = await showEditGoalDialog(context!);
    if (newGoal != null) {
      _addGoalToList(newGoal);
      await showGoal(newGoal);
    }
  }
}
