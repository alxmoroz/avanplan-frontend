// Copyright (c) 2022. Alexandr Moroz

import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/goals/goal.dart';
import '../base/base_controller.dart';

part 'goal_controller.g.dart';

class GoalController extends _GoalControllerBase with _$GoalController {}

abstract class _GoalControllerBase extends BaseController with Store {
  @observable
  Goal? goal;

  @action
  void setGoal(Goal? _goal) => goal = _goal;
}
