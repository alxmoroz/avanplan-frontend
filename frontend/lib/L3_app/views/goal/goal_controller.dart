// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/goals/goal.dart';
import '../../../L3_app/extra/services.dart';
import '../base/base_controller.dart';
import '../base/tf_annotation.dart';

part 'goal_controller.g.dart';

class GoalController extends _GoalControllerBase with _$GoalController {}

abstract class _GoalControllerBase extends BaseController with Store {
  @override
  void initState(BuildContext _context, {List<TFAnnotation>? tfaList}) {
    super.initState(_context, tfaList: tfaList);

    setEditMode(goal == null);
  }

  @override
  bool get validated => !tfAnnotations.values
      .where(
        (ta) => ['title', 'due_date'].contains(ta.code),
      )
      .any((ta) => ta.errorText != null || !ta.edited);

  @observable
  Goal? goal;

  @action
  void setGoal(Goal? _goal) => goal = _goal;

  Future saveGoal() async {
    final goal = await goalsUC.saveGoal(
      title: tfAnnoForCode('title').text,
      description: tfAnnoForCode('description').text,
      dueDate: DateTime.parse(tfAnnoForCode('dueDate').text),
    );

    if (goal != null) {
      setGoal(goal);
      setEditMode(false);
    }
  }
}
