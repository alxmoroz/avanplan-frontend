// Copyright (c) 2022. Alexandr Moroz

import '../entities/goals/goal.dart';
import '../repositories/abstract_goals_repo.dart';

class GoalsUC {
  GoalsUC({required this.goalsRepo});

  final AbstractGoalsRepo goalsRepo;

  Future<List<Goal>> getGoals() async {
    final goals = await goalsRepo.getGoals();
    return goals;
  }
}
